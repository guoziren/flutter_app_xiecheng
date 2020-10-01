import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutterappxiecheng/dao/travel_dao.dart';
import 'package:flutterappxiecheng/model/travel_model.dart' hide Image;
import 'package:flutterappxiecheng/util/navigator_util.dart';
import 'package:flutterappxiecheng/widgets/loading_container.dart';
import 'package:flutterappxiecheng/widgets/webview.dart';

const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final Map<String, dynamic> params;
  final String groupChannelCode;
  final int type;

  const TravelTabPage(
      {Key key, this.travelUrl, this.params, this.groupChannelCode, this.type})
      : super(key: key);

  @override
  _TravelTabPageState createState() {
    return _TravelTabPageState();
  }
}

class _TravelTabPageState extends State<TravelTabPage> {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  ScrollController _scrollController = ScrollController();

  var _isLoading = true;

  @override
  void initState() {
    loadData(false);
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
       loadData(true);
      }
    });
    super.initState();
  }

  void loadData(bool loadMore) async {
    _isLoading = true;
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelModel model = await TravelDao.fetch(widget.travelUrl, widget.params,
          widget.groupChannelCode, widget.type, pageIndex, PAGE_SIZE);
      _isLoading = false;
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (!loadMore) {
          travelItems.clear();
        }
        travelItems.addAll(items);
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      isLoading: _isLoading,
      child: RefreshIndicator(
//      color: Colors.grey,
          onRefresh: _handleRefresh,

          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: new StaggeredGridView.countBuilder(
              controller: _scrollController,
              crossAxisCount: 2,
              itemCount: travelItems?.length ?? 0,
              itemBuilder: (BuildContext context, int index) => new Container(
                child: _item(index),
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
//        new StaggeredTile.count(1, index.isEven ? 2 : 1),
//        new StaggeredTile.count(2,  1),

            ),
          )),
    );
  }

  Widget _item([int index]) {
    if (travelItems == null) return null;
    TravelItem item = travelItems[index];
    return GestureDetector(
      onTap: () {
        if (item.article.urls != null && item.article.urls.length > 0) {
          NavigatorUtil.push(
              context,
              WebView(
                url: item.article.urls[0].h5Url,
                title: '详情',
              ));
        }
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  item.article.images[0]?.dynamicUrl,
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.white,
                        ),
                        LimitedBox(
                          maxWidth: 130,
                          child: Text(
                            _poiName(item),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Text(
                item.article.articleTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            _infoText(item),
          ],
        ),
      ),
    );
  }

  String _poiName(TravelItem item) {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知'
        : item.article.pois[0].poiName ?? '未知';
  }

  Widget _infoText(TravelItem item) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article.author?.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {

    loadData(false);
    return null;
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) return [];
    List<TravelItem> filterItems = [];
    resultList.forEach((element) {
      if (element.article != null) {
        filterItems.add(element);
      }
    });
    return filterItems;
  }
}
