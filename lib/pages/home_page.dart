import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterappxiecheng/dao/home_dao.dart';
import 'package:flutterappxiecheng/model/common_model.dart';
import 'package:flutterappxiecheng/model/grid_nav_model.dart';
import 'package:flutterappxiecheng/model/sales_box_model.dart';
import 'package:flutterappxiecheng/pages/search_page.dart';
import 'package:flutterappxiecheng/pages/travel_tab_page.dart';
import 'package:flutterappxiecheng/util/navigator_util.dart';
import 'package:flutterappxiecheng/widgets/grid_nav.dart';
import 'package:flutterappxiecheng/widgets/loading_container.dart';
import 'package:flutterappxiecheng/widgets/local_nav.dart';
import 'package:flutterappxiecheng/widgets/salesbox.dart';
import 'package:flutterappxiecheng/widgets/search_bar.dart';
import 'package:flutterappxiecheng/widgets/sub_nav.dart';
import 'package:flutterappxiecheng/widgets/webview.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => (_HomePageState());
}

const int MAX_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';


class _HomePageState extends State<HomePage> {

  List<CommonModel> localNavlist = [];
  List<CommonModel> bannerlist = [];
  List<CommonModel> subNavlist = [];
  GridNavModel gridNav;
  SalesBoxModel salebox;

  bool _loading = true;

  var city = "西安市";//页面加载状态

  //主页列表
  get _listView => ListView(
    children: <Widget>[
      _banner,
      Padding(
        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
        child: LocalNav(localNavlist),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
        child: GridNav(model: gridNav),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
        child: SubNav(subNavlist: subNavlist),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
        child: SalesBox(salesBoxModel : salebox),
      ),
    ],
  );
  //轮播图
  get _banner => Container(
    height: 160,
    child: Swiper(
      autoplay: true,
      loop: true,
      itemCount: bannerlist.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
           NavigatorUtil.push(context, WebView(
             title: bannerlist[index].title,
             url: bannerlist[index].url,
           ));
          },
          child: Image.network(
            bannerlist[index].icon,
            fit: BoxFit.fitWidth,
          ),
        );
      },
      pagination: SwiperPagination(),
    ),
  );

  @override
  void initState() {
    //
    print("initState");

    loadData();
    super.initState();
  }

  var appBarAlpha = 0.0;
  String resultString = '';

  /**
   * listview滑动时
   */
  void _onScroll(double pixels) {
    appBarAlpha = pixels / MAX_OFFSET;
    if (appBarAlpha < 0) {
      appBarAlpha = 0;
    } else if (appBarAlpha > 1) {
      appBarAlpha = 1;
    }
    print(appBarAlpha);
    setState(() {});
  }
  //获取首页数据
  loadData() {
    HomeDao.fetch().then((homeModel) {
//      print(value);
      setState(() {
        localNavlist = homeModel.localNavList;
        gridNav = homeModel.gridNav;
        subNavlist = homeModel.subNavList;
        salebox = homeModel.salesBox;
        bannerlist = homeModel.bannerList;
        _loading = false;
      });
    }).catchError((e) {
      setState(() {
        resultString = e.toString();
        _loading = false;
      });
    });
  }
  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors:[Color(0x66000000),Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakButtonClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: _jumpToCity,
              city: city,
            ),
          ),

        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
                color:Colors.black12,
                blurRadius: 0.5
            )]
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                onNotification: (Notification notification) {
                  if (notification is ScrollUpdateNotification &&
                      notification.depth == 0) {
                    //是滚动且是第一个孩子滚动的时候出发
                    _onScroll(notification.metrics.pixels);
                  }
                },
                child: _listView,
              ),
            ),
//            Opacity(
//              opacity: appBarAlpha, // 0 是透明  ，1是不透明
//              child: Container(
//                height: 80,
//                decoration: BoxDecoration(color: Colors.white),
//                child: Center(
//                  child: Padding(
//                    padding: EdgeInsets.only(top: 20),
//                    child: Text('首页'),
//                  ),
//                ),
//              ),
//            )
          _appBar
          ],
        ),
      ),
    );
  }

  void _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage(

    ));
  }

  void _jumpToSpeak() {
  }

  void _jumpToCity() {
  }
}
