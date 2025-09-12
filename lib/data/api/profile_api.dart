import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class ProfileApi extends GetConnect {
  Future<Response> EditProfile(
    String phone,
    String first_name,
    String last_name,
  ) async {
    return post(
      "http://$ip:8000/edit_profile",
      {"phone": phone, "first_name": first_name, "last_name": last_name},
      contentType: "application/x-www-form-urlencoded",
    );
  }
}

class ProfileApiController extends GetxController {
  final ProfileApi _profileApi = Get.find<ProfileApi>();
  final firstName = TextEditingController(
    text: box.read("userData")["first_name"],
  );
  final lastName = TextEditingController(
    text: box.read("userData")["last_name"],
  );

  Future<bool> EditProfile() async {
    try {
      final response = await _profileApi.EditProfile(
        box.read("userData")["phone"],
        firstName.text,
        lastName.text,
      );

      if (response.statusCode == 200) {
        Get.snackbar("موفق", "ثبت شد");
        box.write("userData", response.body);
        print(box.read("userData"));
        return true;
      } else {
        Get.snackbar(
          "خطا",
          response.body.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar("Exception", "$e");
      return false;
    }
  }
}
