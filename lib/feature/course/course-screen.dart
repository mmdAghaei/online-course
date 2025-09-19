import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/course-api-controller.dart';
import 'package:podcast/data/api/home-api-controller.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/feature/buy%20section/buy-screen.dart';
import 'package:podcast/feature/course%20about/course-about.dart';
import 'package:shimmer/shimmer.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeApiController homeApiController = Get.put(HomeApiController());
    CourseApiController courseApiController = Get.put(CourseApiController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "دوره ها",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          courseApiController.onInit();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 5,
              bottom: 120.w,
            ),
            child: Obx(() {
              if (homeApiController.listCourse.isEmpty) {
                return Column(
                  children: List.generate(10, (index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 120.w,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    );
                  }),
                );
              } else {
                return StaggeredList(
                  children: courseApiController.listCourse.map((course) {
                    return InkWell(
                      onTap: () async {
                        CoursesModel coursesModel =
                            await homeApiController.CourseDetails(course.id);
                        Get.to(
                          CourseAboutScreen(coursesModel: coursesModel),
                          transition: Transition.downToUp,
                          arguments: coursesModel,
                        );
                      },
                      child: CardCourse(coursesModel: course),
                    );
                  }).toList(),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
