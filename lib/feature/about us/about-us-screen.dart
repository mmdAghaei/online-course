import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "درباره ما",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: 1702.w,
          width: double.infinity,
          child: StaggeredList(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 375.w,
                height: 240.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'مسیر الهام‌بخش',
                          style: TextStyle(
                            color: Color(0xFFF39A9D),
                            fontSize: 20.sp,
                            fontFamily: Fonts.ExtraBold.fontFamily,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 375.w,
                      height: 199.w,
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(color: Color(0xFFF39A9D)),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'همیشه باور داشتم که زندگی زیبا یک انتخابه؛ انتخابی\nکه از یاد گرفتن، تغییر نگرش و ساختن عادت‌های\nدرست شروع می‌شه. بعد از سال‌ها تجربه در مشاوره،\nمخصوصاً با نوجوانان، به یک نتیجه‌ی بزرگ \nرسیدم: اگر آموزش رو جدی بگیریم و روی سبک زندگی کار\nکنیم، می‌تونیم خیلی زودتر و عمیق‌تر جلوی مشکلات\nرو بگیریم. برای همین، آموزش رو مقدم بر درمان\nمی‌دونم.',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: Fonts.VazirMedium.fontFamily,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 49.w,
                                height: 175.w,
                                child: SvgPicture.asset(
                                  "assets/hand.svg",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 375.w,
                height: 240.w,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'مسیر حرفه‌ای',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 20.sp,
                            fontFamily: Fonts.ExtraBold.fontFamily,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 361.w,
                        height: 199.w,
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0F172A),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(500),
                          ),
                        ),
                        child: Text(
                          'من، مهری بدخشان، سال‌هاست که در آموزش\nو پرورش به عنوان معلم فلسفه، منطق و روان‌شناسی\nکار می‌کنم و مدرک کارشناسی ارشد روان‌شناسی بالینی\nدارم. تجربه‌ی مشاوره‌ی فردی و گروهی، به‌ویژه با\nنوجوانان، همیشه بخش مهمی از زندگی من بوده و\nهنوز هر روز تشنه‌ی یادگیری‌ام.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: Fonts.VazirMedium.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 295.w,
                  height: 295.w,
                  child: SvgPicture.asset("assets/Asset_1_cleaned.svg"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20.w),
                width: 375.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'یادگیری و رشد فردی',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: Fonts.ExtraBold.fontFamily,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 361.w,
                        height: 142.w,
                        alignment: Alignment.centerRight,
                        child: Text(
                          'در بیشتر دوره‌های موفقیت، رشد فردی و سبک زندگی\nاساتید بزرگ ایران شرکت کرده‌ام و همیشه سعی \nرده‌ام خودم را به‌روز نگه دارم. مسیر یادگیری من فقط به روان‌شناسی ختم\nنمی‌شود… سال‌ها در حوزه‌ی فلسفه و عرفان و ادیان\nمطالعه داشته‌ام.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontFamily: Fonts.VazirMedium.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 375.w,
                  height: 290.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'نگاه من به زندگی',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3F6C51),
                          fontSize: 20.sp,
                          fontFamily: Fonts.ExtraBold.fontFamily,
                        ),
                      ),
                      Container(
                        width: 375.w,
                        height: 255.w,
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3F6C51),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 20.w,
                            right: 20.w,
                            left: 20.w,
                          ),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'تمام این مسیرها باعث شده به زندگی نگاه متفاوتی\nپیدا کنم؛ نگاهی که هم بر پایه‌ی علم و تجربه است و\nهم ریشه در حکمت و معنویت دارد.',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 229.w,
                                  height: 151.w,
                                  child: SvgPicture.asset(
                                    "assets/lamp.svg",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 350.w,
                height: 200.w,
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF9AA9F2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
                child: Text(
                  'این اپلیکیشن حاصل همین مسیر و همین باور است: اینجا جایی است برای یاد گرفتن، برای رشد کردن و\nبرای ساختن زندگی‌ای که در آن هم آرامش درون\nداشته باشی و هم شادی بیرون.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: Fonts.VazirMedium.fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
