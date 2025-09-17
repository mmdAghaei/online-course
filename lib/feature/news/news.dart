import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/news-api-controller.dart';
import 'package:podcast/feature/news%20about/news-about-screen.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsApiController newsApiController = Get.put(NewsApiController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'اطلاعیه ها و اخبار',
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          newsApiController.onInit();
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
              if (newsApiController.newsList.isEmpty) {
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
                  children: newsApiController.newsList.map((index) {
                    return InkWell(
                      onTap: () {
                        Get.to(NewsAboutScreen(newsModel: index));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100.w,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).extension<CustomColors>()!.card,
                          borderRadius: BorderRadius.circular(16.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 101.w,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: 91.w,
                                height: 91.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: index.image != null
                                        ? NetworkImage(index.image ?? "")
                                        : AssetImage(
                                            "assets/photo_2025-08-22_19-11-50.jpg",
                                          ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12.w),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            index.title,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .extension<CustomColors>()!
                                                  .title,
                                              fontSize: 14.sp,
                                              fontFamily:
                                                  Fonts.VazirBold.fontFamily,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          SizedBox(
                                            width: 120.w,
                                            child: Text(
                                              index.content,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .extension<CustomColors>()!
                                                    .desc,
                                                fontSize: 11.sp,
                                                fontFamily: Fonts
                                                    .VazirMedium
                                                    .fontFamily,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
