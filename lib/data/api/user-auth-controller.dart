import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:podcast/data/api/user-auth.dart';
import 'package:podcast/feature/varification/varification-screen.dart';
import 'package:podcast/main.dart';
import 'package:podcast/routes/routes.dart';

class UserAuthController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final UserAuthApi _authApi = Get.find<UserAuthApi>();

  Future<bool> login() async {
    try {
      final response = await _authApi.login(
        phone: phoneController.text,
        password: passwordController.text,
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        Get.snackbar("موفق", "وارد شدید");
        box.write("userData", response.body);
        print(box.read("userData"));
        Get.to(Routes());
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

  Future<bool> signUp() async {
    try {
      final response = await _authApi.signUp(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        phone: phoneController.text,
      );

      if (response.statusCode == 200) {
        Get.snackbar("موفق", response.body["message"]);
        Get.to(
          () => const VarificationScreen(),
          arguments: phoneController.text,
        );
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

  Future<bool> verifyEmail(String code) async {
    try {
      final response = await _authApi.verifyEmail(
        code: code,
        username: phoneController.text,
      );

      if (response.statusCode == 200) {
        Get.snackbar("موفق", response.body["message"]);
        Get.to(Routes());

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
