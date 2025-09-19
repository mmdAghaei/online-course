import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/panel/panel-admin-controller.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/data/models/user-model.dart';
import 'package:podcast/feature/panel%20admin/course/add/add-edit-course.dart';
import 'package:podcast/feature/panel%20admin/course/list-course.dart';
import 'package:podcast/feature/panel%20admin/home/home-admin-screen-controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PanelAdminController panelAdminController = Get.put(PanelAdminController());
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 70,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.white.withOpacity(0.9),
        ),
        children: [
          FloatingActionButton.small(
            onPressed: () {
              Get.to(ListCourseScreen());
            },
            tooltip: "لیست دوره ها",
            child: Icon(Icons.list),
          ),

          FloatingActionButton.small(
            onPressed: () {
              Get.to(
                AddEditCourseScreen(),
                arguments: {
                  "title": "اضافه کردن دوره",
                  "data": CoursesModel(
                    id: "",
                    title: "",
                    description: "",
                    buyStatus: "",
                    price: "",
                    finalPrice: "",
                  ),
                },
              );
            },
            tooltip: "اضافه کردن دوره",
            child: Icon(Icons.add),
          ),
          FloatingActionButton.small(
            onPressed: () {},
            tooltip: "اضافه کردن اطلاعیه و اخبار",
            child: Icon(Icons.newspaper),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "پنل ادمین",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "لیست اعضا",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: Fonts.VazirBold.fontFamily,
                  ),
                ),
              ),
            ),

            Obx(() {
              if (panelAdminController.userList.isEmpty) {
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
                  children: panelAdminController.userList.map((index) {
                    return UserCard(userModel: index);
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
