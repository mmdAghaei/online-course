import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/course/course-api-controller.dart';
import 'package:podcast/data/api/home/home-api-controller.dart';
import 'package:podcast/feature/panel%20admin/course/add/add-edit-course.dart';
import 'package:podcast/feature/panel%20admin/course/section/add/add-edit-section.dart';

class SectionListScreen extends StatelessWidget {
  const SectionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseApiController courseApiController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "لیست بخش ها",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            AddEditSectionScreen(),
            arguments: {"title": "اضافه کردن بخش"},
          );
        },
        child: Icon(CupertinoIcons.add),
      ),
      body: StaggeredList(
        children: courseApiController.listCourseSesson
            .toList()
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              final course = entry.value;
              return CourseSessonCard(courseSessonModel: course, index: index);
            })
            .toList(),
      ),
    );
  }
}
