import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class PanelAdminApi extends GetConnect {
  Future<Response> GetUsers() async {
    return post("$ip/user_list", {});
  }

  Future<Response> DeleteUser(String phone) async {
    return post("$ip/remove_user", {
      "phone": phone,
    }, contentType: "application/x-www-form-urlencoded");
  }

  Future<Response> ChangeUser(String phone) async {
    return post("$ip/change_user", {
      "phone": phone,
    }, contentType: "application/x-www-form-urlencoded");
  }

  Future<Response> AllCourseAdmin(String phone) async {
    return post(
      "$ip/change_user",
      {},
      
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
