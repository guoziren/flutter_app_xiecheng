





import 'package:dio/dio.dart';
import 'package:flutterappxiecheng/model/home_model.dart';

const HOME_URL = 'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/home_page.json';






class HomeDao{
  static Future<HomeModel> fetch() async{
    Response response = await Dio().get(HOME_URL);

    if(response.statusCode == 200){
//      print("响应数据${response.data}");
      return HomeModel.fromJson(response.data);
    }else{
      print("响应数据failed");
      throw Exception('Failed to fetch home_page.json');
    }
  }
}