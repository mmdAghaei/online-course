import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/feature/auth/register-controller.dart';
import 'package:podcast/feature/my%20course/my-course-controller.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  @override
  final MyCourseController myCourseController = Get.put(MyCourseController());
  Widget _buildPillToggle() {
    return Obx(() {
      final isBuy = myCourseController.isBuy.value;
      return Container(
        width: 312.w,
        height: 44.w,
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: myCourseController.setLogin,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isBuy
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'خریداری شده',
                    style: TextStyle(
                      color: isBuy ? Colors.white : const Color(0xFF0F172A),
                      fontFamily: Fonts.VazirBold.fontFamily,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: myCourseController.setRegister,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !isBuy
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    "ذخیره شده ها",
                    style: TextStyle(
                      color: !isBuy ? Colors.white : const Color(0xFF0F172A),
                      fontFamily: Fonts.VazirBold.fontFamily,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            _buildPillToggle(),
            Obx(() {
              if (myCourseController.isBuy.value == true) {
                return StaggeredList(
                  children: myCourseController.buyCourses.map((course) {
                    return InkWell(
                      onTap: () {
                        // if (int.parse(course.price.replaceAll(",", "")) >
                        //     0) {
                        //   Get.to(
                        //     BuyScreen(coursesModel: course),
                        //     transition: Transition.downToUp,
                        //     arguments: course,
                        //   );
                        // } else {
                        // Get.to(
                        //   CourseAboutScreen(coursesModel: course),
                        //   transition: Transition.downToUp,
                        //   arguments: course,
                        // );
                        // }
                      },
                      child: CardCourse(coursesModel: course),
                    );
                  }).toList(),
                );
              } else {
                return StaggeredList(
                  children: myCourseController.saveCourses.map((course) {
                    return InkWell(
                      onTap: () {
                        // if (int.parse(course.price.replaceAll(",", "")) >
                        //     0) {
                        //   Get.to(
                        //     BuyScreen(coursesModel: course),
                        //     transition: Transition.downToUp,
                        //     arguments: course,
                        //   );
                        // } else {
                        // Get.to(
                        //   CourseAboutScreen(coursesModel: course),
                        //   transition: Transition.downToUp,
                        //   arguments: course,
                        // );
                        // }
                      },
                      child: CardCourse(coursesModel: course),
                    );
                  }).toList(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
