import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class HomeApi extends GetConnect {
  Future<Response> GetCourseAndNews() async {
    return post(
      "$ip/home_screen",
      {},
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }
}
