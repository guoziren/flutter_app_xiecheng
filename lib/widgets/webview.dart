

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];
class WebView extends StatefulWidget {
  String icon;
  String title;
  String url;
  String statusBarColor;
  bool hideAppBar;
  bool backForbid;


  WebView(
  {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar,this.backForbid = false} );

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  final webviewPlugin = FlutterWebviewPlugin();

  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<String> _onUrlChanged;
  bool exiting = false;
  @override
  void initState() {

    super.initState();
    //防止页面重新打开
    webviewPlugin.close();
    _onUrlChanged = webviewPlugin.onUrlChanged.listen((event) {
      print("");
    });
    _onStateChanged = webviewPlugin.onStateChanged.listen((WebViewStateChanged state) { 
      switch(state.type){
        case WebViewState.startLoad:
//          if(_isToHome(state.url) && !exiting){
//            if(widget.backForbid){
//              //重新打开
//              webviewPlugin.launch(state.url);
//            }else{
//              //返回到上一页
//              Navigator.pop(context);
//              exiting = true;
//            }
//          }
          break;
        default:
          break;
      }
    });
    _onHttpError = webviewPlugin.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
    
  }
  @override
  void dispose() {
    //页面关闭时,关流
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onUrlChanged.cancel();
    webviewPlugin.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if(statusBarColorStr == 'ffffff'){
      backButtonColor = Colors.black;

    }else{
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff' + statusBarColorStr)),backButtonColor),
          Expanded(child: WebviewScaffold(
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            //webview加载前的初始化布局
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('waiting..'),
              ),
            ),
          ))
        ],
      ),
    );
  }

  _appBar(Color background, Color backButton) {
    if(widget.hideAppBar ?? false){
      return Container(
        color: background,
        height: 30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1, //宽度撑满
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(

              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isToHome(String url) {
    bool result = false;
    for(String addr in CATCH_URLS){
      if(url?.endsWith(addr)?? false){
        result = true;
        return result;
      }
    }
    return result;
  }
}
