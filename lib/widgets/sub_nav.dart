


import 'package:flutter/material.dart';
import 'package:flutterappxiecheng/model/common_model.dart';
import 'package:flutterappxiecheng/widgets/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavlist;

  const SubNav({Key key,@required this.subNavlist}):super(key:key);

  _items(BuildContext context) {
    if(subNavlist == null){
      return null;
    }
    List<Widget> items = [];
    subNavlist.forEach((model) => items.add(_item(context,model)));

    int seprate = (subNavlist.length / 2 + 0.5).toInt();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,//平均排列？
          children: items.sublist(0,seprate),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,//平均排列？
            children: items.sublist(seprate,subNavlist.length),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),

      ),
      child: Padding(
          padding: EdgeInsets.all(7),
          child: _items(context),
      ),
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    //可点击
    return Expanded(
      flex: 1,
      child: GestureDetector(
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
              width: 18,
              height: 18,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child:  Text(
                model.title,
                style: TextStyle(fontSize: 12),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


