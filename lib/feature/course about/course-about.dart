import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/home-api-controller.dart';
import 'package:podcast/data/models/course-section-model.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/feature/course%20about/comment-controller.dart';
import 'package:podcast/feature/course%20about/comment-widget.dart';

class CourseAboutScreen extends StatelessWidget {
  final CoursesModel coursesModel;
  const CourseAboutScreen({super.key, required this.coursesModel});

  @override
  Widget build(BuildContext context) {
    final List<String> allUsers = ['علی', 'مینا', 'ادمین', 'سارا', 'رضا'];

    late List<Comment> comments;
    final CommentsController ctrl = Get.put(CommentsController());
    final HomeApiController homeApiController = Get.find();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 349.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: coursesModel.image != null
                      ? NetworkImage(coursesModel.image ?? "")
                      : AssetImage("assets/photo_2025-08-22_19-11-50.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(.9),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(color: Colors.black.withOpacity(0.3)),

          Positioned(
            top: 42.w,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return Container(
                padding: EdgeInsets.only(left: 16.w, bottom: 16.w, right: 16.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: ListView(
                  controller: controller,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.w,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          coursesModel.buyStatus,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.w),

                    Text(
                      coursesModel.title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(
                          context,
                        ).extension<CustomColors>()!.colorText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.w),

                    Row(
                      children: [
                        Text(
                          "تعداد فصل ها: ${coursesModel.sectionCount ?? "0"}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),

                    devider(),
                    Text(
                      coursesModel.description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.5,
                        fontFamily: Fonts.Vazir.fontFamily,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    devider(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "فصل ها",
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).extension<CustomColors>()!.colorText,
                              fontSize: 19.sp,

                              fontFamily: Fonts.VazirBold.fontFamily,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(500),
                            child: Text(
                              'دیدن همه',
                              style: TextStyle(
                                color: Color(0xFF8E8E8E),
                                fontSize: 13.sp,
                                fontFamily: Fonts.VazirBold.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StaggeredList(
                      children: homeApiController.listCourseSesson
                          .toList()
                          .asMap()
                          .entries
                          .take(4)
                          .map((entry) {
                            final index = entry.key;
                            final course = entry.value;
                            return CourseSessonCard(
                              courseSessonModel: course,
                              index: index,
                            );
                          })
                          .toList(),
                    ),
                    devider(),
                    Text(
                      "نظرات و پرسش پاسخ",
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).extension<CustomColors>()!.colorText,
                        fontSize: 19.sp,

                        fontFamily: Fonts.VazirBold.fontFamily,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(18, 14, 18, 52),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).extension<CustomColors>()!.card,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextField(
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  minLines: 1,
                                  maxLines: 4,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'نظر شما...',
                                    hintTextDirection: TextDirection.rtl,
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            left: 18,
                            bottom: 14,
                            child: SizedBox(
                              width: 80.w,
                              height: 30.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  ctrl.addComment(
                                    Comment(
                                      id: 'c${ctrl.comments.length + 1}',
                                      author: 'کاربر جدید',
                                      timeString: 'الان',
                                      message: 'یک کامنت تستی',
                                    ),
                                  );
                                },
                                child: Text(
                                  "ارسال",
                                  style: TextStyle(
                                    fontFamily: Fonts.Vazir.fontFamily,
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).primaryColor,
                                  ),
                                  shape:
                                      MaterialStateProperty.all<
                                        RoundedRectangleBorder
                                      >(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            500,
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
                    SizedBox(height: 20),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: ctrl.comments.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, idx) {
                            return CommentCard(comment: ctrl.comments[idx]);
                          },
                        ),
                      ),
                    ),
                    // ChatCommentThread(
                    //   userName: "محمد",
                    //   userTime: "۲ روز پیش",
                    //   userMessage: "هفتاد درصد ما چیشد؟",
                    //   adminMessage: "هفتاد درصد؟فکرررر نکنم",
                    //   adminName: "ادمین",
                    //   adminTime: "۷۰ روز پیش",
                    // ),
                    // SizedBox(height: 40),
                    // ChatCommentThread(
                    //   userName: "محمد",
                    //   userTime: "۲ روز پیش",
                    //   userMessage: "هفتاد درصد ما چیشد؟",
                    //   adminMessage: "هفتاد درصد؟فکرررر نکنم",
                    //   adminName: "ادمین",
                    //   adminTime: "۷۰ روز پیش",
                    // ),
                    // SizedBox(height: 40),
                    // ChatCommentThread(
                    //   userName: "محمد",
                    //   userTime: "۲ روز پیش",
                    //   userMessage: "هفتاد درصد ما چیشد؟",
                    //   adminMessage: "هفتاد درصد؟فکرررر نکنم",
                    //   adminName: "ادمین",
                    //   adminTime: "۷۰ روز پیش",
                    // ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
