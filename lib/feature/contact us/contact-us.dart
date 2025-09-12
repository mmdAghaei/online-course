import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/widget-utils.dart';
// import 'package:url_launcher/url_launcher.dart';

class ContactUsScren extends StatelessWidget {
  ContactUsScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            width: 329.w,
            height: 246.w,
            child: SvgPicture.asset("assets/Group.svg"),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardCall(
                color: Color(0xff8D4DCA),
                iconData: CupertinoIcons.chat_bubble,

                colorCirc: Color(0xffF1ECFE),
                title: "پیامک",
              ),
              CardCall(
                color: Color(0xff3DD078),
                iconData: Icons.email_outlined,

                colorCirc: Color(0xffE4FAEE),
                title: "ایمیل",
              ),
              CardCall(
                color: Color(0xff1B41A3),
                iconData: Icons.call_outlined,

                colorCirc: Color(0xffEAEDFF),
                title: "تماس",
              ),
            ],
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                'فضای مجازی ما',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: Fonts.VazirMedium.fontFamily,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              spacing: 10.w,
              children: [
                InkWell(onTap: () {
                  
                },
                  child: Row(
                    children: [
                      Container(
                        width: 34.w,
                        height: 34.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 163, 163, 163),
                          ),
                        ),
                        child: SvgPicture.asset(
                          "assets/instagram.svg",
                          width: 19.w,
                          height: 19.w,
                          color: Color(0xff231F20),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "اینستاگرام",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff282828),
                          fontFamily: Fonts.VazirMedium.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 34.w,
                      height: 34.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 163, 163, 163),
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/eeta.svg",
                        width: 19.w,
                        height: 19.w,
                        color: Color(0xff231F20),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "ایتا",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xff282828),
                        fontFamily: Fonts.VazirMedium.fontFamily,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 34.w,
                      height: 34.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 163, 163, 163),
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/telegram.svg",
                        width: 15.w,
                        height: 15.w,
                        color: Color(0xff231F20),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "تلگرام",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xff282828),
                        fontFamily: Fonts.VazirMedium.fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
