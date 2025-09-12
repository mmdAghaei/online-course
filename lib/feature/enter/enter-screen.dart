import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/feature/auth/register-screen.dart';

class EnterScreen extends StatelessWidget {
  const EnterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "آکادمی باران",
          style: TextStyle(
            color: Colors.white,
            fontFamily: Fonts.ExtraBold.fontFamily,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: StaggeredList(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300.w,
              height: 256.w,
              child: Lottie.asset(
                "assets/animation/Artboard_no_watermark_v2.json",
                repeat: false,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: StaggeredList(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 375.w,
                    child: Text(
                      'یادگیری آسان و\nبدون محدودیت زمانی',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontFamily: Fonts.ExtraBold.fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 375.w,
                    child: Text(
                      "اینجا کمکت می کنیم با هم رشد کنیم\nرشد درخشان با مهری بدخشان",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: Fonts.Vazir.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 326.w,
              height: 55.w,
              child: ButtonApp(
                title: "شروع",
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onTap: () {
                  Get.to(RegisterScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
