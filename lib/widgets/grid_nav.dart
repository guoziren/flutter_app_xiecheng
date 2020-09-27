


import 'package:flutter/material.dart';
import 'package:flutterappxiecheng/model/common_model.dart';
import 'package:flutterappxiecheng/model/grid_nav_model.dart';
import 'package:flutterappxiecheng/widgets/webview.dart';

class GridNav extends StatefulWidget {
  GridNavModel model;

  GridNav({this.model});

  @override
  _GridNavState createState() => _GridNavState();
}

class _GridNavState extends State<GridNav> {


  @override
  Widget build(BuildContext context) {

    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(widget.model == null) return null;
    if(widget.model.hotel != null){
      items.add(_getGridNavItem(context,widget.model.hotel,true));
    }
    if(widget.model.flight != null){
      items.add(_getGridNavItem(context,widget.model.flight,false));

    }
    if(widget.model.travel != null){
      items.add(_getGridNavItem(context,widget.model.travel,false));

    }
    return items;
  }

  /**
   * 一个row ,总共三个row :hotel ,flight,travle
   * 一个row: 1个main，2个double
   */
  Widget _getGridNavItem(BuildContext context,GridNavItem item,bool first) {
    List<Widget> items = [];
    List<Widget> expandItems = [];
    items.add(_getGridMainItem(context, item.mainItem));
    items.add(_getDoubleItem(context, item.item1,item.item2));
    items.add(_getDoubleItem(context, item.item3,item.item4));
    //渐变色
    Color startColor = Color(int.parse('0xff${item.startColor}'));
    Color endColor = Color(int.parse('0xff${item.startColor}'));
    items.forEach((element) {
      expandItems.add(Expanded(
        flex: 1,
        child: element,
      ));
    });
    return Container(
      height: 88,
      margin: first?null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor,endColor])
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }
  Widget _getDoubleItem(BuildContext context,CommonModel top,CommonModel down) {
    return Column(

      children: <Widget>[
        Expanded(
          flex: 1,
          child: _item(context,top,true),
        ),
        Expanded(
          flex: 1,
          child: _item(context,down,false),
        ),
      ],
    );
  }

  /**
   * 左边的单个大ITEM
   */
  Widget _getGridMainItem(BuildContext context,CommonModel model) {
     Widget mainItem = GestureDetector(
       onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return WebView(
                url:model.url,
                icon: model.icon,
                statusBarColor: model.statusBarColor,
                hideAppBar: model.hideAppBar,
                title: model.title,
              );
            },
          ));
       },
       child: Stack(
         alignment: AlignmentDirectional.topCenter,
         children: <Widget>[
           Image.network(
             model.icon,
             width: 88,
             height: 121,
             fit: BoxFit.fitWidth,
             alignment: AlignmentDirectional.bottomEnd,
           ),
           Container(
             margin: EdgeInsets.only(top: 11),
             child: Text(
               model.title,
               style: TextStyle(fontSize: 14,color: Colors.white),
             ),
           )
         ],
       ),
     );
     return mainItem;
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide side = BorderSide(width: 0.8,color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,//撑满宽度
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: side,
            bottom: first ? side : BorderSide.none
          ),
        ),
        child: _wrapGesture(context,
            item
            , Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
        )),
      ),
    );

      ;
  }
  _wrapGesture(BuildContext context, CommonModel model,Widget widget){
    Widget w = GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return WebView(
              url:model.url,
              icon: model.icon,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
              title: model.title,
            );
          },
        ));
      },
      child: widget,
    );
    return w;
  }
}
