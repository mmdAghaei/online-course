import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/feature/about%20us/about-us-screen.dart';
import 'package:podcast/feature/contact%20us/contact-us.dart';
import 'package:podcast/feature/my%20course/my-course-screen.dart';
import 'package:podcast/feature/panel%20admin/home/home-admin-screen.dart';
import 'package:podcast/feature/setting/setting-controller.dart';
import 'package:podcast/main.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(box.read("userData")["user_type"]);
    print("------------------------");
    SettingController settingController = Get.put(SettingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "تنظیمات",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: StaggeredList(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              SettingCard(
                icon: Icon(Icons.question_answer, color: Color(0xff757C91)),
                title: "درباره ما",
                function: () {
                  Get.to(AboutUsScreen(), transition: Transition.downToUp);
                },
              ),
              SettingCard(
                icon: Icon(Icons.bookmark, color: Color(0xff757C91)),
                title: "دوره های من",
                function: () {
                  Get.to(MyCourseScreen(), transition: Transition.downToUp);
                },
              ),
              SettingCard(
                icon: Icon(Icons.person, color: Color(0xff757C91)),
                title: "تماس با ما",
                function: () {
                  Get.to(ContactUsScren(), transition: Transition.downToUp);
                },
              ),

              // box.read("userData")["user_type"] == "admin"
              //     ? SettingCard(
              //         icon: Icon(
              //           Icons.admin_panel_settings,
              //           color: Color(0xff757C91),
              //         ),
              //         title: "پنل ادمین",
              //         function: () {
              //           Get.to(
              //             HomeAdminScreen(),
              //             transition: Transition.downToUp,
              //           );
              //         },
              //       )
              //     : SizedBox(),
              // SettingCard(
              //   icon: Icon(Icons.question_answer, color: Color(0xff757C91)),
              //   title: "سوالات متداول",
              // ),
              // SettingCard(
              //   icon: Icon(Icons.rule, color: Color(0xff757C91)),
              //   title: "قوانین و مقررات",
              // ),
              Container(
                width: 327.w,
                height: 1,
                color: Color.fromARGB(255, 151, 151, 151),
              ),
              Obx(
                () => SettingCard(
                  icon: Icon(Icons.color_lens, color: Color(0xff757C91)),
                  title: "تم برنامه",
                  subTitle: settingController.themeMode.value
                      ? "تاریک"
                      : "روشن",
                  function: () {
                    Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    );
                    settingController.toggleThemeMode();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
