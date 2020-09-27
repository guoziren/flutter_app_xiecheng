


import 'package:flutter/material.dart';
import 'package:flutterappxiecheng/model/common_model.dart';
import 'package:flutterappxiecheng/widgets/webview.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavlist;

  const LocalNav(this.localNavlist);

  _items(BuildContext context) {
    if(localNavlist == null){
      return null;
    }
    List<Widget> items = [];
    localNavlist.forEach((model) => items.add(_item(context,model)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,//平均排列？
      children: items,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(7)),

      ),
      child: Padding(
          padding: EdgeInsets.all(7),
          child: _items(context),
      ),
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    //可点击
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return WebView(
              url: model.url,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
            );
          }
        ));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}


