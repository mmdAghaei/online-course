import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:podcast/data/models/user-model.dart';

class FabController extends GetxController {
  var isOpen = false.obs;
  final ValueNotifier<bool> openCloseDial = ValueNotifier<bool>(false);

  void toggle(bool v) {
    isOpen.value = v;
    openCloseDial.value = v;
  }

  @override
  void onClose() {
    openCloseDial.dispose();
    super.onClose();
  }
}

class HomeController extends GetxController {
  RxList<UserModel> userList = [
    UserModel(
      firstName: "امین",
      lastName: "محمدی",
      phone: "09123456789",
      rule: "مدیر سیستم",
    ),
    UserModel(
      firstName: "سارا",
      lastName: "رحیمی",
      phone: "09129876543",
      rule: "کاربر عادی",
    ),
    UserModel(
      firstName: "رضا",
      lastName: "اکبری",
      phone: "09351234567",
      rule: "نویسنده",
    ),
    UserModel(
      firstName: "فاطمه",
      lastName: "زارعی",
      phone: "09131112233",
      rule: "مشتری",
    ),
    UserModel(
      firstName: "محمد",
      lastName: "کریمی",
      phone: "09124445566",
      rule: "اپراتور",
    ),
  ].obs;
}
