import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/home-api-controller.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/feature/course%20about/course-about.dart';
import 'package:podcast/feature/course/course-screen.dart';
import 'package:podcast/feature/home/slider-news.dart';
import 'package:podcast/feature/news/news.dart';
import 'package:podcast/feature/profile/profile-screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeApiController homeApiController = Get.put(HomeApiController());

    final List<String> images = [
      'assets/190519_orig 2.png',
      'assets/190519_orig 2.png',
      'assets/190519_orig 2.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "آکادمی باران",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(500),
            onTap: () {
              Get.to(ProfileScreen(), transition: Transition.leftToRight);
            },
            child: Container(
              width: 37.w,
              height: 37.w,
              margin: const EdgeInsets.only(left: 15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Group 760.png"),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w),
        child: RefreshIndicator(
          onRefresh: () async {
            homeApiController.onInit();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StaggeredList(
              itemDuration: const Duration(milliseconds: 420),
              staggerDelay: const Duration(milliseconds: 110),
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 159.w,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      aspectRatio: 341 / 159,
                    ),
                    items: images.map((path) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          path,
                          fit: BoxFit.cover,
                          width: 341,
                          height: 159,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 330.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'اطلاعیه ها و اخبار',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).extension<CustomColors>()!.colorText,
                                  fontSize: 19.sp,
                                  fontFamily: Fonts.VazirBold.fontFamily,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(500),
                                onTap: () {
                                  Get.to(NewsScreen());
                                },
                                child: Text(
                                  'دیدن همه',
                                  style: TextStyle(
                                    color: const Color(0xFF8E8E8E),
                                    fontSize: 13.sp,
                                    fontFamily: Fonts.VazirBold.fontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          if (homeApiController.listNews.isEmpty) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 180.w,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            );
                          } else {
                            return NewsSlider(
                              items: homeApiController.listNews,
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'دوره ها',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).extension<CustomColors>()!.colorText,
                          fontSize: 19.sp,
                          fontFamily: Fonts.VazirBold.fontFamily,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const CourseScreen());
                        },
                        borderRadius: BorderRadius.circular(500),
                        child: Text(
                          'دیدن همه',
                          style: TextStyle(
                            color: const Color(0xFF8E8E8E),
                            fontSize: 13.sp,
                            fontFamily: Fonts.VazirBold.fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Obx(() {
                  if (homeApiController.listCourse.isEmpty) {
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
                      children: homeApiController.listCourse.take(4).map((
                        course,
                      ) {
                        return InkWell(
                          onTap: () async {
                            CoursesModel coursesModel =
                                await homeApiController.GetDetails(course.id);
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

                SizedBox(height: 110.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
