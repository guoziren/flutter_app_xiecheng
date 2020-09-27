import 'package:flutterappxiecheng/model/common_model.dart';

///活动入口模型
class SalesBoxModel {
String icon;
String moreUrl;
CommonModel bigCard1;
CommonModel bigCard2;
CommonModel smallCard1;
CommonModel smallCard2;
CommonModel smallCard3;
CommonModel smallCard4;

  SalesBoxModel({
    this.icon,
    this.moreUrl,
    this.bigCard1,
    this.bigCard2,
    this.smallCard1,
    this.smallCard2,
    this.smallCard3,
    this.smallCard4,
  });

   SalesBoxModel.fromJson(Map<String, dynamic> json) {
      this.icon= json['icon'];
      this.moreUrl= json['moreUrl'];
      this.bigCard1= CommonModel.fromJson(json['bigCard1']);
      this.bigCard2= CommonModel.fromJson(json['bigCard2']);
      this.smallCard1= CommonModel.fromJson(json['smallCard1']);
      this.smallCard2= CommonModel.fromJson(json['smallCard2']);
      this.smallCard3= CommonModel.fromJson(json['smallCard3']);
      this.smallCard4= CommonModel.fromJson(json['smallCard4']);

  }


Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['icon'] = this.icon;
  data['moreUrl'] = this.moreUrl;
  if(bigCard1 != null){
    data['bigCard1'] = bigCard1.toJson();
  }
  if(bigCard2 != null){
    data['bigCard1'] = bigCard2.toJson();
  }
  if(smallCard1 != null){
    data['smallCard1'] = smallCard1.toJson();
  }
  if(smallCard2 != null){
    data['smallCard2'] = smallCard2.toJson();
  }
  if(smallCard3 != null){
    data['smallCard3'] = smallCard3.toJson();
  }
  if(smallCard4 != null){
    data['smallCard4'] = smallCard4.toJson();
  }
  return data;
}
}
