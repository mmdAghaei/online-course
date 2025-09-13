import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/profile_api.dart';
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
                color: Color.fromARGB(255, 255, 183, 183),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
            Text(
              box.read("userData")["first_name"] +
                  " " +
                  box.read("userData")["last_name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
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
              width: 275.w,
              height: 44.w,
              child: TextFieldWidget(
                // textEditingController: TextEditingController(
                //   text: box.read("userData")["first_name"],
                // )
                // ,
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
                // textEditingController: TextEditingController(
                //   text: box.read("userData")["last_name"],
                // ),
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
                // textEditingController: TextEditingController(
                //   text: box.read("userData")["last_name"],
                // ),
                textEditingController: profileApiController.role,
                hintText: "نقش",
                icon: const Icon(Icons.person, size: 24),
                keyboardType: TextInputType.name,
                obscureText: false,
                textInputFormatters: [],
              ),
            ),
            // Container(
            //   width: 275.w,
            //   height: 44.w,
            //   child: TextFieldWidget(
            //     textEditingController: TextEditingController(
            //       text: box.read("userData")["phone"],
            //     ),
            //     hintText: "شماره تلفن",
            //     icon: const Icon(Icons.call, size: 24),
            //     keyboardType: TextInputType.number,
            //     obscureText: false,
            //     textInputFormatters: [
            //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            //     ],
            //   ),
            // ),
            // Container(
            //   width: 275.w,
            //   height: 44.w,
            //   child: TextFieldWidget(
            //     textEditingController: TextEditingController(),
            //     hintText: 'رمز عبور',
            //     icon: const Icon(Icons.password, size: 24),
            //     keyboardType: TextInputType.text,
            //     obscureText: true,
            //     textInputFormatters: [],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
