





import 'package:dio/dio.dart';

const HOME_URL = 'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/home_page.json';






class HomeDao{
  static Future<HomeModel> fetch() async{
    Response response = await Dio().get(HOME_URL);
  }
}