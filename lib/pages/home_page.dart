import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => (_HomePageState());
}

const int MAX_OFFSET = 100;

class _HomePageState extends State<HomePage> {
  List imgs = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600941041558&di=eced28021e8792a5f7236abae4a60f0c&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600941041558&di=b6a515b0b2940d420db2f1a9d55f0875&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F56%2F12%2F01300000164151121576126282411.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600941041558&di=d530d565d39448981fb12b70d422b8ba&imgtype=0&src=http%3A%2F%2Fa4.att.hudong.com%2F22%2F59%2F19300001325156131228593878903.jpg'
  ];
  var appBarAlpha = 0.0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 160,
                      child: Swiper(
                        autoplay: true,
                        loop: true,
                        itemCount: imgs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            imgs[index],
                            fit: BoxFit.fitWidth,
                          );
                        },
                        pagination: SwiperPagination(),
                      ),
                    )
                  ],
                )),
          ),
          Opacity(
            opacity: appBarAlpha, // 0 是透明  ，1是不透明
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
