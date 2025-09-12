import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class HomeApi extends GetConnect {
  Future<Response> GetCourseAndNews(String phone) async {
    return post(
      "http://$ip:8000/home_screen",
      {"phone": phone},
      contentType: "application/x-www-form-urlencoded",
    );
  }
}
