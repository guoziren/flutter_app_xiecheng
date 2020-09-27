




import 'package:flutterappxiecheng/model/common_model.dart';

class GridNavModel{
   GridNavItem hotel;
   GridNavItem flight;
   GridNavItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});

   GridNavModel.fromJson(Map<String, dynamic> json) {

        hotel= GridNavItem.fromJson(json['hotel']);
        flight= GridNavItem.fromJson(json['flight']);
        travel= GridNavItem.fromJson(json['travel']);

  }
   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();

     if (hotel != null) {
       data['hotel'] = hotel.toJson();
     }
     if (flight != null) {
       data['flight'] = flight.toJson();
     }
     if (travel != null) {
       data['travel'] = travel.toJson();
     }

     return data;
   }
}


class GridNavItem{
  String startColor;
  String endColor;
  CommonModel mainItem;
  CommonModel item1;
  CommonModel item2;
  CommonModel item3;
  CommonModel item4;

  GridNavItem({this.startColor, this.endColor, this.mainItem, this.item1,
      this.item2, this.item3, this.item4});


   GridNavItem.fromJson(Map<String, dynamic> json) {
     this.startColor = json['startColor'];
     this.endColor = json['endColor'];
     this.mainItem = CommonModel.fromJson(json['mainItem']);
     this.item1 = CommonModel.fromJson(json['item1']);
     this.item2 = CommonModel.fromJson(json['item2']);
     this.item3 = CommonModel.fromJson(json['item3']);
     this.item4 = CommonModel.fromJson(json['item4']);
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    if(this.mainItem != null){
      data['mainItem'] = this.mainItem.toJson();
    }
    if(this.item1 != null){
      data['item1'] = this.item1.toJson();
    }
    if(this.item2 != null){
      data['item2'] = this.item2.toJson();
    }
    if(this.item3 != null){
      data['item3'] = this.item3.toJson();
    }
    if(this.item4 != null){
      data['item4'] = this.item4.toJson();
    }
    return data;
  }
}