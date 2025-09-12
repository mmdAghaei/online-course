import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var isOn = false.obs;
  var themeMode = false.obs;

  void toggleOn() {
    isOn.value = !isOn.value;
  }

  RxInt currentPage = 0.obs;

  void toggleTheme() {
    themeMode.value = !themeMode.value;
  }

  void setPage(int index) {
    currentPage.value = index;
  }

  void toggleThemeMode() {
    themeMode.value = !themeMode.value;
  }
}
