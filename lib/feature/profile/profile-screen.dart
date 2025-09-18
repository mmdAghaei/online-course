import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/profile_api.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/main.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileApiController profileApiController = Get.put(ProfileApiController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پروفایل",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15.w,
          children: [
            Container(
              width: 74.w,
              height: 74.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 119, 119, 119),
                borderRadius: BorderRadius.circular(150),
              ),
              child: Icon(Icons.person, size: 50.w, color: Colors.white),
            ),
            Text(
              box.read("userData")["first_name"] +
                  " " +
                  box.read("userData")["last_name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: Fonts.VazirBold.fontFamily,
              ),
            ),
            Container(
              width: 104.w,
              height: 31.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(500),
              ),
              child: ElevatedButton(
                onPressed: () {
                  profileApiController.EditProfile();
                },
                child: Text(
                  "ویرایش",
                  style: TextStyle(
                    fontFamily: Fonts.Vazir.fontFamily,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).primaryColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 104.w,
              height: 31.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(500),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "سوال",
                    middleText: "آیا مطمئن هستید میخواهید خارج شوید",
                    textConfirm: "بله",
                    textCancel: "خیر",
                    onConfirm: () {
                      box.write("userData", null);
                      Get.offAll(EnterScreen());
                      // Get.back();
                    },
                    onCancel: () {
                      Get.back();
                    },
                  );
                },
                child: Text(
                  "خروج",
                  style: TextStyle(
                    fontFamily: Fonts.Vazir.fontFamily,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 275.w,
              height: 44.w,
              child: TextFieldWidget(
                textEditingController: profileApiController.firstName,
                hintText: "نام",
                icon: const Icon(Icons.person, size: 24),
                keyboardType: TextInputType.name,
                obscureText: false,
                textInputFormatters: [],
              ),
            ),
            Container(
              width: 275.w,
              height: 44.w,
              child: TextFieldWidget(
                textEditingController: profileApiController.lastName,
                hintText: "نام خانوادگی",
                icon: const Icon(Icons.person, size: 24),
                keyboardType: TextInputType.name,
                obscureText: false,
                textInputFormatters: [],
              ),
            ),
            Container(
              width: 275.w,
              height: 44.w,
              child: TextFieldWidget(
                textEditingController: profileApiController.role,
                hintText: "نقش",
                icon: const Icon(Icons.person, size: 24),
                keyboardType: TextInputType.name,
                obscureText: false,
                textInputFormatters: [],
                readOnly: true,
              ),
            ),
            Container(
              width: 275.w,
              height: 44.w,
              child: TextFieldWidget(
                readOnly: true,
                textEditingController: profileApiController.phone,
                hintText: "شماره",
                icon: const Icon(Icons.person, size: 24),
                keyboardType: TextInputType.name,
                obscureText: false,
                textInputFormatters: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
