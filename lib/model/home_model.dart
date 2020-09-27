import 'package:flutterappxiecheng/model/common_model.dart';
import 'package:flutterappxiecheng/model/config_model.dart';
import 'package:flutterappxiecheng/model/sales_box_model.dart';

import 'grid_nav_model.dart';

class HomeModel {
  Config config;
  List<CommonModel> bannerList;
  List<CommonModel> localNavList;
  GridNavModel gridNav;
  List<CommonModel> subNavList;
  SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    this.localNavList = localNavList;
    this.bannerList = bannerList;
    this.subNavList = subNavList;
    this.config = Config.fromJson(json['config']);
    this.gridNav = GridNavModel.fromJson(json['gridNav']);
    this.salesBox = SalesBoxModel.fromJson(json['salesBox']);
  }


  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = new  Map<String,dynamic>();
    if(config != null){
      data['config'] = config.toJson();
    }
    data['bannerList'] = bannerList == null? '' : bannerList.map((e) => e.toJson()).toList();
    data['localNavList'] = localNavList == null? '' : localNavList.map((e) => e.toJson()).toList();
    data['gridNav'] = gridNav == null? '' : gridNav.toJson();

    data['subNavList'] = subNavList == null? '' : subNavList.map((e) => e.toJson()).toList();
    data['salesBox'] = salesBox == null? '' : salesBox.toJson();
    return data;
  }
}
