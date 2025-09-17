import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/course-api-controller.dart';
import 'package:podcast/data/api/home-api-controller.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/feature/auth/register-controller.dart';
import 'package:podcast/feature/course%20about/course-about.dart';
import 'package:podcast/feature/my%20course/my-course-controller.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  @override
  final MyCourseController myCourseController = Get.put(MyCourseController());
  final CourseApiController courseApiController = Get.put(
    CourseApiController(),
  );
  HomeApiController homeApiController = Get.find();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildPillToggle(),
              Obx(() {
                if (myCourseController.isBuy.value == true) {
                  return StaggeredList(
                    children: courseApiController.listBuyCourse.map((course) {
                      return InkWell(
                        onTap: () async {
                          CoursesModel coursesModel =
                              await homeApiController.CourseDetails(course.id);
                          Get.to(
                            CourseAboutScreen(coursesModel: coursesModel),
                            transition: Transition.downToUp,
                            arguments: course,
                          );
                        },
                        child: CardCourse(coursesModel: course),
                      );
                    }).toList(),
                  );
                } else {
                  return StaggeredList(
                    children: courseApiController.listSaveCourse.map((course) {
                      return InkWell(
                        onTap: () async {
                          CoursesModel coursesModel =
                              await homeApiController.CourseDetails(course.id);
                          Get.to(
                            CourseAboutScreen(coursesModel: coursesModel),
                            transition: Transition.downToUp,
                            arguments: course,
                          );
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
      ),
    );
  }
}
