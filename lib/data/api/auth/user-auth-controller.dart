import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:podcast/data/api/auth/device-info-controller.dart';
import 'package:podcast/data/api/auth/user-auth.dart';
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
  final DeviceInfoController deviceInfoController = Get.find();
  Future<bool> login() async {
    try {
      final response = await _authApi.login(
        phone: phoneController.text,
        password: passwordController.text,
        app_version: deviceInfoController.appVersion.toString(),
        device_name: deviceInfoController.deviceModel.toString(),
        ip_address: deviceInfoController.ip.toString(),
        os: deviceInfoController.os.toString(),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("موفق", "وارد شدید");
        box.write("userData", response.body);
        Get.offAll(Routes());
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
      } else if (response.statusCode == 400) {
        Get.snackbar("خطا", response.body["message"]);
        return false;
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
        app_version: deviceInfoController.appVersion.toString(),
        device_name: deviceInfoController.deviceModel.toString(),
        ip_address: deviceInfoController.ip.toString(),
        os: deviceInfoController.os.toString(),
      );

      if (response.statusCode == 201) {
        Get.snackbar("موفق", response.body["message"]);
        // response.body["message"]
        Get.offAll(Routes());
        print(response.body);
        box.write("userData", response.body);
        return true;
      } else if (response.statusCode == 401) {
        Get.snackbar("خطا", "کد وارد شده نامعتبر است");
        return false;
      } else if (response.statusCode == 410) {
        Get.snackbar("خطا", "کد وارد شده منقضی شده است");
        return false;
      } else if (response.statusCode == 409) {
        Get.snackbar("خطا", "شماره موبایل تکراری است");
        return false;
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
