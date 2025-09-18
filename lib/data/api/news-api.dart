import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class NewsApi extends GetConnect {
  Future<Response> GetAllNews() async {
    return post(
      "$ip/all_announcements",
      {},
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }
}
