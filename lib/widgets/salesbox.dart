


import 'package:flutter/material.dart';
import 'package:flutterappxiecheng/model/common_model.dart';
import 'package:flutterappxiecheng/model/sales_box_model.dart';
import 'package:flutterappxiecheng/util/navigator_util.dart';
import 'package:flutterappxiecheng/widgets/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBoxModel;

  const SalesBox({Key key, this.salesBoxModel}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  Widget _items(BuildContext context) {
    if(salesBoxModel == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(context,salesBoxModel.bigCard1,salesBoxModel.bigCard2,true,false));
    items.add(_doubleItem(context,salesBoxModel.smallCard1,salesBoxModel.smallCard2,false,false));
    items.add(_doubleItem(context,salesBoxModel.smallCard3,salesBoxModel.smallCard4,false,true));
    return Column(
      children: <Widget>[
        //热门活动
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide( color: Color(0xfff2f2f2))
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                 salesBoxModel.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)
                ),
                child: GestureDetector(
                  onTap: () {
                    NavigatorUtil.push(
                        context, WebView(url: salesBoxModel.moreUrl, title: '更多活动'));
                  },
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        //第一行 2张大图
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        //第2行
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        //第3行
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        )
      ],
    );
  }

  /**
   * @leftCard 左边卡片
   * @rightCard 右边卡片
   * @isBig 是不是大图；第一行的才是大图
   * @isLast 是不是最后一行
   */
  Widget _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rightCard, bool isBig, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
         _item(context,leftCard,isBig,true,isLast),
         _item(context,rightCard,isBig,false,isLast),
      ],
    );
  }

  /**
   * 这里的item是一张图片
   */
  Widget _item(BuildContext context, CommonModel model, bool isBig, bool isLeft, bool isLast) {
    BorderSide borderSide = BorderSide(width: 0.8,color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            WebView(
              url: model.url,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
              title: model.title,
            );
          }
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            //只有左边的图才设置灰色的右边界线
            right: isLeft ? borderSide : BorderSide.none,
            //不是最后一行，就设置灰色的下边界线
            bottom: isLast ? BorderSide.none : borderSide
          ),

        ),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2 - 8,
          //大图和小图高度不一样
          height: isBig ? 129 : 80,
        ),
      ),
    );
  }
}
