import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/data/api/courses-api.dart';
import 'package:podcast/data/api/home-api.dart';
import 'package:podcast/data/api/profile_api.dart';
import 'package:podcast/data/api/user-auth.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/routes/routes.dart';

final box = GetStorage();
String ip = "192.168.1.7";

void main() async {
  await GetStorage.init();
  Get.put(UserAuthApi());
  Get.put(CoursesApi());
  Get.put(HomeApi());
  Get.put(ProfileApi());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Podcast',
        transitionDuration: Duration(milliseconds: 700),
        locale: Locale('fa', 'IR'),
        theme: AppThemes.lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: AppThemes.darkTheme,
        home: box.read("userData") != null ? Routes() : EnterScreen(),
      ),
    );
  }
}
