import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class ProfileApi extends GetConnect {
  Future<Response> EditProfile(String first_name, String last_name) async {
    return post(
      "$ip/edit_profile",
      {"first_name": first_name, "last_name": last_name},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer " + box.read("userData")["token"],
      },
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
  final role = TextEditingController(text: box.read("userData")["user_type"]);
  final phone = TextEditingController(text: box.read("userData")["phone"]);

  Future<bool> EditProfile() async {
    try {
      final response = await _profileApi.EditProfile(
        firstName.text,
        lastName.text,
      );

      if (response.statusCode == 200) {
        Get.snackbar("موفق", "ثبت شد");
        // box.write("userData", response.body);
        final boxs = box.read("userData");
        boxs["first_name"] = firstName.text;
        boxs["last_name"] = lastName.text;
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
