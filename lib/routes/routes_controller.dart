import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/feature/course/course-screen.dart';
import 'package:podcast/feature/home/home-screen.dart';
import 'package:podcast/feature/my%20course/my-course-screen.dart';
import 'package:podcast/feature/setting/setting-screen.dart';

class RoutesController extends GetxController {
  RxInt currentIndex = 2.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  Widget get currentPage {
    switch (currentIndex.value) {
      case 0:
        return SettingScreen();
      case 1:
        return MyCourseScreen();
      case 2:
        return HomeScreen();
      default:
        return HomeScreen();
    }
  }
}
