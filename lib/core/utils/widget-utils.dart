import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/data/api/panel/panel-admin-controller.dart';
import 'package:podcast/data/models/course-section-model.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/data/models/user-model.dart';
import 'package:podcast/feature/setting/setting-controller.dart';
// import 'package:url_launcher/url_launcher.dart';

class ButtonApp extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;

  final dynamic onTap;
  const ButtonApp({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.onTap,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: Fonts.Vazir.fontFamily,
          fontSize: 21.sp,
          color: foregroundColor,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> textInputFormatters;
  final TextEditingController textEditingController;
  final bool? readOnly;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.keyboardType,
    required this.textInputFormatters,
    required this.textEditingController,
    this.readOnly,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  bool get _isPasswordField =>
      widget.hintText == "رمز عبور" || widget.hintText == "تکرار رمز عبور";

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      keyboardType: widget.keyboardType,
      style: TextStyle(fontSize: 14.sp, fontFamily: Fonts.Vazir.fontFamily),
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: false,
      readOnly: widget.readOnly ?? false,
      obscureText: _isPasswordField ? _obscureText : widget.obscureText,
      cursorHeight: 14,
      inputFormatters: widget.textInputFormatters,
      cursorRadius: const Radius.circular(2),
      cursorColor: const Color(0xFF0F172A),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF7F7F7F),
          fontSize: 14.sp,
          fontFamily: Fonts.VazirBold.fontFamily,
        ),
        prefixIcon: widget.icon,
        suffixIcon: _isPasswordField
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF7F7F7F),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(color: Color(0x80DFDFDF), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(500),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xFFFF0000)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xFFFF0000)),
        ),
      ),
    );
  }
}

class PillToggleDemo extends StatefulWidget {
  const PillToggleDemo({super.key});
  @override
  State<PillToggleDemo> createState() => _PillToggleDemoState();
}

class _PillToggleDemoState extends State<PillToggleDemo> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final width = min(820.0, screenW - 40.0);
    final height = 72.0;

    const outerBg = Color(0xFFEEF1F2);
    const outerBorder = Color(0xFFE1E4E6);
    const selectorBorder = Color(0xFFE8ECEF);
    const textUnselected = Color(0xFFBFC7CA);

    return GestureDetector(
      onTap: () => setState(() => isLogin = !isLogin),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: outerBg,
                borderRadius: BorderRadius.circular(height / 2),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.black.withOpacity(0.02),
                  //   blurRadius: 8,
                  //   offset: const Offset(0, 4),
                  // ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(height / 2),
                    onTap: () => setState(() => isLogin = true),
                    child: Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 160),
                        opacity: isLogin ? 0.0 : 1.0,
                        child: const Text(
                          'ورود',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: textUnselected,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(height / 2),
                    onTap: () => setState(() => isLogin = false),
                    child: Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 160),
                        opacity: isLogin ? 1.0 : 0.0,
                        child: const Text(
                          'ثبت نام',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: textUnselected,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AnimatedAlign(
              alignment: isLogin ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOut,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: width * 0.48,
                  height: height - 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular((height - 8) / 2),
                    border: Border.all(color: selectorBorder, width: 3),
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.black.withOpacity(0.06),
                      //   blurRadius: 10,
                      //   offset: const Offset(0, 6),
                      // ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular((height - 8) / 2),
                    onTap: () => setState(() => isLogin = !isLogin),
                    child: Center(
                      child: Text(
                        isLogin ? 'ورود' : 'ثبت نام',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardCourse extends StatelessWidget {
  final CoursesModel coursesModel;
  const CardCourse({super.key, required this.coursesModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.w,
      margin: EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomColors>()!.card,
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 101.w),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 91.w,
              height: 91.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: coursesModel.image != null
                      ? NetworkImage(coursesModel.image ?? "")
                      : AssetImage("assets/photo_2025-08-22_19-11-50.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.w),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            coursesModel.title,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).extension<CustomColors>()!.title,
                              fontSize: 14.sp,
                              fontFamily: Fonts.VazirBold.fontFamily,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            coursesModel.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).extension<CustomColors>()!.desc,
                              fontSize: 11.sp,
                              fontFamily: Fonts.VazirMedium.fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        coursesModel.buyStatus != ""
                            ? Container(
                                height: 17.w,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.center,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  coursesModel.buyStatus,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).extension<CustomColors>()!.stateText,
                                    fontSize: 8.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              faToEnNumbers(
                                coursesModel.disCount == "0"
                                    ? coursesModel.price
                                    : coursesModel.finalPrice,
                              ),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: Fonts.VazirMedium.fontFamily,
                                color: Theme.of(
                                  context,
                                ).extension<CustomColors>()!.price,
                              ),
                            ),
                            Text(
                              faToEnNumbers(
                                coursesModel.disCount == "0"
                                    ? ""
                                    : coursesModel.price,
                              ),
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 11.sp,
                                fontFamily: Fonts.VazirMedium.fontFamily,
                                color: Theme.of(
                                  context,
                                ).extension<CustomColors>()!.priceoff,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String faToEnNumbers(String input) {
  const Map<String, String> mapping = {
    '0': '۰',
    '1': '۱',
    '2': '۲',
    '3': '۳',
    '4': '۴',
    '5': '۵',
    '6': '۶',
    '7': '۷',
    '8': '۸',
    '9': '۹',
  };

  String result = input;
  mapping.forEach((en, fa) {
    result = result.replaceAll(en, fa);
  });
  return result;
}

class CourseSessonCard extends StatelessWidget {
  final int index;
  final CourseSectionModel courseSessonModel;
  const CourseSessonCard({
    super.key,
    required this.courseSessonModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 48.w,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffF0F4FD),
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 33.w,
                height: 33.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: Color(0xffF0F4FD),
                    fontSize: 13.sp,
                    fontFamily: Fonts.VazirBold.fontFamily,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                courseSessonModel.title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontFamily: Fonts.VazirBold.fontFamily,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              courseSessonModel.state,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class devider extends StatelessWidget {
  const devider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: 327.w,
      height: 1,
      color: Theme.of(context).extension<CustomColors>()!.desc,
    );
  }
}

class SettingCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final dynamic function;
  final bool Switch;
  final String? subTitle;

  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    this.function,
    this.Switch = false,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 31.w,
                  height: 31.w,
                  decoration: const BoxDecoration(
                    color: Color(0xffF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: icon,
                ),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: Fonts.VazirBold.fontFamily,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            Switch
                ? Obx(
                    () => CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: settingController.isOn.value,
                      onChanged: (bool value) {
                        settingController.toggleOn();
                      },
                    ),
                  )
                : Row(
                    children: [
                      subTitle == null
                          ? const SizedBox()
                          : Text(
                              subTitle.toString(),
                              style: TextStyle(
                                color: const Color(0xffA7A8B1),
                                fontSize: 15.sp,
                                fontFamily: Fonts.VazirBold.fontFamily,
                              ),
                            ),
                      SizedBox(width: 10.w),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 16.w,
                          color: const Color(0xffC8CCD1),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class AutoImageSlider extends StatefulWidget {
  const AutoImageSlider({
    super.key,
    required this.images,
    this.width = 341,
    this.height = 159,
    this.borderRadius = 16,
    this.interval = const Duration(seconds: 3),
    this.slideDuration = const Duration(milliseconds: 450),
  });

  final List<String> images;
  final double width;
  final double height;
  final double borderRadius;
  final Duration interval;
  final Duration slideDuration;

  @override
  State<AutoImageSlider> createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _index);
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted || widget.images.isEmpty) return;
      _index = (_index + 1) % widget.images.length;
      _controller.animateToPage(
        _index,
        duration: widget.slideDuration,
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.images.length,
          itemBuilder: (context, i) {
            return Image.asset(
              widget.images[i],
              fit: BoxFit.cover,
              width: widget.width,
              height: widget.height,
            );
          },
        ),
      ),
    );
  }
}

Future<void> _sendSMS() async {
  final Uri smsUri = Uri(
    scheme: 'sms',
    path: '09218959972',
    queryParameters: <String, String>{'body': 'سلام، این یک پیام تست است'},
  );

  // if (await canLaunchUrl(smsUri)) {
  //   await launchUrl(smsUri);
  // } else {
  //   throw 'نمیشه SMS باز کرد';
  // }
}

Future<void> _makeCall() async {
  final Uri telUri = Uri(scheme: 'tel', path: '09218959972');

  // if (await canLaunchUrl(telUri)) {
  //   await launchUrl(telUri);
  // } else {
  //   throw 'نمیشه تماس گرفت';
  // }
}

Future<void> _sendEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'mohammedaghaei401@gmail.com',
    queryParameters: <String, String>{
      'subject': 'سلام',
      'body': 'این متن ایمیل تستی است',
    },
  );

  // if (await canLaunchUrl(emailUri)) {
  //   await launchUrl(emailUri);
  // } else {
  //   throw 'نمیشه ایمیل باز کرد';
  // }
}

class CardCall extends StatefulWidget {
  final IconData iconData;
  final Color color;
  final dynamic onTap;
  final String title;
  final Color colorCirc;
  const CardCall({
    super.key,
    required this.iconData,
    required this.color,
    this.onTap,
    required this.title,
    required this.colorCirc,
  });

  @override
  State<CardCall> createState() => _CardCallState();
}

class _CardCallState extends State<CardCall> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.w),
      onTap: () {
        if (widget.title == "پیامک") {
          _sendSMS();
        } else if (widget.title == "ایمیل") {
          _sendEmail();
        } else if (widget.title == "تماس") {
          _makeCall();
        }
      },
      child: Container(
        width: 92.w,
        height: 92.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: widget.color, width: 2),
          boxShadow: [
            BoxShadow(color: widget.color.withOpacity(.3), blurRadius: 20.w),
          ],
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: widget.colorCirc,
                borderRadius: BorderRadius.circular(150),
              ),
              child: Icon(widget.iconData, size: 25.w, color: widget.color),
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: widget.color,
                fontSize: 12.sp,
                fontFamily: Fonts.VazirMedium.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel userModel;
  const UserCard({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    PanelAdminController panelAdminController = Get.find();
    return Container(
      width: double.infinity,
      height: 60.w,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color.fromARGB(255, 192, 192, 192),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 41.w,
            height: 41.w,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModel.firstName + " " + userModel.lastName,
                style: TextStyle(
                  fontFamily: Fonts.VazirMedium.fontFamily,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 3),
              Text(
                userModel.phone,
                style: TextStyle(
                  fontFamily: Fonts.VazirMedium.fontFamily,
                  fontSize: 10.sp,
                  color: Color(0xff777777),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(userModel.userType == "admin" ? "ادمین" : "کاربر عادی"),
                IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "سوال",
                      middleText: "آیا مطمئن هستید تایپ کاربر عوض شود",
                      textConfirm: "بله",
                      textCancel: "خیر",
                      onConfirm: () {
                        panelAdminController.ChangeUsers(userModel.phone);

                        Get.back();
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                  icon: Icon(Icons.change_circle_outlined, size: 20.w),
                ),
                IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "سوال",
                      middleText: "آیا مطمئن هستید؟",
                      textConfirm: "بله",
                      textCancel: "خیر",
                      onConfirm: () {
                        panelAdminController.RemoveUsers(userModel.phone);

                        Get.back();
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 23.w,
                    color: Color(0xffFF0000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
