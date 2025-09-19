import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/main.dart';

class PanelAdminApi extends GetConnect {
  Future<Response> GetUsers() async {
    return post(
      "$ip/user_list",
      {},
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> DeleteUser(String phone) async {
    return post(
      "$ip/remove_user",
      {"phone": phone},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> ChangeUser(String phone) async {
    return post(
      "$ip/change_user",
      {"phone": phone},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> AllCourseAdmin() async {
    return get(
      "$ip/all_courses_admin/",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> CreateCourse(
    String title,
    String description,
    String price,
    String discount,
    bool published,
  ) async {
    return post("$ip/create_course", {});
  }
}
