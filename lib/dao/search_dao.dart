import 'package:dio/dio.dart';
import 'package:flutterappxiecheng/model/search_model.dart';

const Search_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';


class SearchDao{
  static Future<SearchModel> fetch(String keyword) async{
    Response response = await Dio().get(Search_URL + keyword);

    if(response.statusCode == 200){
       //只有当输入的内容与服务端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(response.data);
      model.keyword = keyword;
      return model;
    }else{
      print("响应数据failed");
      throw Exception('Failed to fetch search_page.json');
    }
  }
}