import 'package:flutter/material.dart';
import 'package:flutterappxiecheng/dao/search_dao.dart';
import 'package:flutterappxiecheng/model/search_model.dart';
import 'package:flutterappxiecheng/util/navigator_util.dart';
import 'package:flutterappxiecheng/widgets/search_bar.dart';
import 'package:flutterappxiecheng/widgets/webview.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup',
];
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

//搜索页面
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchUrl, this.keyword, this.hint})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//                colors: [Color(0x66000000), Colors.transparent],
//                begin: Alignment.topCenter,
//                end: Alignment.bottomCenter),
//          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint ?? SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
              speakButtonClick: _jumpToSpeak,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    if (widget.keyword != null) {
      _onTextChange(widget.keyword);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar,
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int position) {
                        return _item(position);
                      })))
        ],
      ),
    );
  }

  /**
   * 输入框文本更改
   */
  Future<void> _onTextChange(String text) async {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel == null;
      });
      return;
    }
    try {
      SearchModel model = await SearchDao.fetch(keyword);
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model ;
        });
      }
    } catch (e) {
      print('_SearchPageState._onTextChange:' + e);
    }
  }

  //搜索结果的一个item
  Widget _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebView(
              url: item.url,
              title: '详情',
            ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(item.type)),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: _subTitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _jumpToSpeak() {}

  /**
   * 搜索标题
   */
  Widget _title(SearchItem item) {
    if (item == null) return null;
    List<TextSpan> spans = [];

    spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
    spans.add(TextSpan(
      text: ' ' + (item.districtname ?? '') + ' ' + (item.zonename ?? ''),
      style: TextStyle(fontSize: 12, color: Colors.grey),
    ));
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  _subTitle(SearchItem item) {
    if (item == null) return null;
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: item.price ?? '',
            style: TextStyle(fontSize: 16, color: Colors.orange)),
        TextSpan(
            text: ' ' + (item.type ?? ''),
            style: TextStyle(fontSize: 12, color: Colors.grey)),
      ]),
    );
  }
  //搜索结果左边的图片
  String _typeImage(String type) {
    if(type == null) return 'assets/images/type_travelgroup.png';
    String path = 'travelgroup';
    for(final val in TYPES){
      if(type.contains(val)){
        path = val;
        break;
      }
    }
    return 'assets/images/type_$path.png';
  }

  List<TextSpan> _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if(word == null || word.length == 0) return spans;
    //搜索关键字高亮忽略大小写
    String wordL = word.toLowerCase();
    String keywordL = keyword.toLowerCase();

    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);

    int preIndex = 0;
    for(int i = 0; i < arr.length;i++){
      if(i != 0){
        preIndex = wordL.indexOf(keywordL,preIndex);
        spans.add(TextSpan(
          text: word.substring(preIndex,preIndex + keyword.length),
          style: keywordStyle
        ));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
