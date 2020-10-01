
class SearchModel{
  String keyword;
  List<SearchItem> data;
  SearchModel({this.data});

  SearchModel.fromJson(Map<String,dynamic> json){
    var dataJson = json['data'] as List;
    List<SearchItem> data = dataJson.map((item) => SearchItem.fromJson(item)).toList();
    this.data = data;
  }
}



class SearchItem{
  String word; // 关键字
  String type; // 类型，用于搜索结果item  左边的不同的图标
  String price;
  String star;
  String zonename;
  String districtname;
  String url;

  SearchItem({this.word, this.type, this.price, this.star, this.zonename,
      this.districtname, this.url});
  SearchItem.fromJson(Map<String,dynamic> json){
    this.word = json['word'];
    this.type = json['type'];
    this.price = json['price'];
    this.star = json['star'];
    this.zonename = json['zonename'];
    this.districtname =  json['districtname'];
    this.url = json['url'];
  }



}