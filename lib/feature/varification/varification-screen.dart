import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/user-auth-controller.dart';
import 'package:podcast/feature/varification/varification_controller.dart';

class VarificationScreen extends StatelessWidget {
  const VarificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserAuthController userAuthController = Get.put(UserAuthController());
    final VarificationController varificationController = Get.put(
      VarificationController(),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 110.w,
            child: Text(
              "تایید شماره تماس",
              style: TextStyle(
                fontFamily: Fonts.VazirBold.fontFamily,
                color: Colors.white,
                fontSize: 40.sp,
              ),
            ),
          ),
          Positioned(
            top: 225.w,
            child: Text(
              "ما برای شما کد ارسال کردیم.\nلطفاً صندوق ورودی خود را بررسی کرده و کد را وارد کنید تا حساب \nکاربری شما تأیید شود.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Fonts.Vazir.fontFamily,
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
          Positioned(
            top: 310.w,
            left: 0,
            right: 0,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(varificationController.length, (index) {
                  return Container(
                    width: 45,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xff678A92),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: varificationController.textControllers[index],
                      focusNode: varificationController.focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged:
                          (val) => varificationController.onChanged(val, index),
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            top: 374.w,
            child: Obx(() {
              final sec = varificationController.remainingSeconds.value;
              if (sec > 0) {
                final minutes = (sec ~/ 60).toString().padLeft(2, '0');
                final seconds = (sec % 60).toString().padLeft(2, '0');
                return Text(
                  "$seconds : $minutes",
                  style: TextStyle(
                    fontFamily: Fonts.VazirBold.fontFamily,
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                );
              } else {
                return TextButton(
                  onPressed: () {
                    varificationController.resendCode();
                  },
                  child: Text(
                    "ارسال مجدد",
                    style: TextStyle(
                      fontFamily: Fonts.VazirBold.fontFamily,
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                );
              }
            }),
          ),
          Positioned(
            bottom: 0,
            child: ButtonApp(
              title: "d",
              onTap: () {
                userAuthController.verifyEmail(
                  "${varificationController.textControllers[0].text}${varificationController.textControllers[1].text}${varificationController.textControllers[2].text}${varificationController.textControllers[3].text}${varificationController.textControllers[4].text}",
                );
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
