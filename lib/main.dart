import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/data/api/comment/comment-api.dart';
import 'package:podcast/data/api/course/courses-api.dart';
import 'package:podcast/data/api/course/section/section-api.dart';
import 'package:podcast/data/api/home/home-api.dart';
import 'package:podcast/data/api/news/news-api.dart';
import 'package:podcast/data/api/panel/panel-admin-api.dart';
import 'package:podcast/data/api/profile_api.dart';
import 'package:podcast/data/api/auth/user-auth.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/routes/routes.dart';

final box = GetStorage();
// String ip = "http://5.10.248.48:9876";
String ip = "http://192.168.1.28:8000";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // box.remove("userData");
  // print(box.read("userData")["user_type"]);
  Get.put(SectionApi());
  Get.put(UserAuthApi());
  Get.put(CoursesApi());
  Get.put(PanelAdminApi());
  Get.put(CommentApi());
  Get.put(HomeApi());
  Get.put(ProfileApi());
  Get.put(NewsApi());
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
