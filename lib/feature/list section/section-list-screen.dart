import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/course/course-api-controller.dart';
import 'package:podcast/data/api/course/section/section-api-controller.dart';
import 'package:podcast/data/api/home/home-api-controller.dart';
import 'package:podcast/data/models/course-section-model.dart';
import 'package:podcast/feature/section%20details/section-details-screen.dart';

class SectionListScreen extends StatelessWidget {
  const SectionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseApiController courseApiController = Get.find();
    final SectionApiController sectionApiController = Get.put(
      SectionApiController(),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StaggeredList(
          children: courseApiController.listCourseSesson
              .toList()
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final course = entry.value;
                return InkWell(
                  borderRadius: BorderRadius.circular(16.w),
                  onTap: () async {
                    final CourseSectionModel courseSectionModel =
                        await sectionApiController.SectionDetails(
                          course.id,
                          Get.arguments,
                        );
                    Get.to(
                      SectionDetailsScreen(),
                      transition: Transition.downToUp,
                      arguments: courseSectionModel,
                    );
                  },
                  child: CourseSessonCard(
                    courseSessonModel: course,
                    index: index,
                  ),
                );
              })
              .toList(),
        ),
      ),
    );
  }
}
