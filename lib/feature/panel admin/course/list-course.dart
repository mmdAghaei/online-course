import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/course/course-api-controller.dart';
import 'package:podcast/data/api/home/home-api-controller.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/feature/course%20about/course-about.dart';
import 'package:podcast/feature/panel%20admin/course/add/add-edit-course.dart';
import 'package:shimmer/shimmer.dart';

class ListCourseScreen extends StatelessWidget {
  const ListCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CourseApiController courseApiController = Get.put(CourseApiController());
    HomeApiController homeApiController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "لیست دوره ها",
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
              if (courseApiController.listCourse.isEmpty) {
                return Column(
                  children: List.generate(4, (index) {
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
                        // CoursesModel coursesModel =
                        //     await homeApiController.GetDetails(course.id);

                        Get.to(
                          AddEditCourseScreen(),
                          arguments: {"title": "ویرایش", "data": course},
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
