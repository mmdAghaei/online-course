import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/models/part-model.dart';
import 'package:podcast/feature/media/media-screen.dart';

class SectionDetailsScreen extends StatelessWidget {
  const SectionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.arguments.parts);
    print("-------------------00");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments.title,
          style: TextStyle(
            fontSize: 20.sp,
            color: Theme.of(context).extension<CustomColors>()!.colorText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 16.w,
              bottom: 16.w,
              right: 16.w,
              top: 10.w,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "مبلغ دوره: ${Get.arguments.price.toString()}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: Theme.of(
                          context,
                        ).extension<CustomColors>()!.colorText,
                        fontFamily: Fonts.Vazir.fontFamily,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "تعداد پارت ها: ${Get.arguments.partCount}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: Theme.of(
                          context,
                        ).extension<CustomColors>()!.colorText,
                        fontFamily: Fonts.Vazir.fontFamily,
                      ),
                    ),
                  ],
                ),
                devider(),
                StaggeredList(
                  children: Get.arguments.parts.map<Widget>((PartModel entry) {
                    return InkWell(
                      onTap: () {
                        print(entry.mediaFile);
                        Get.to(
                          // MediaPage(
                          //   url: entry.mediaFile,
                          //   keyBase64:
                          //       "hTs6TXJpB5zwz207Zplcd+3ugXDL98sT7qGKFuc+5kI=",
                          // ),
                          PlayerPage(url: entry.mediaFile),
                        );
                      },
                      child: Container(
                        width: 327.w,
                        height: 90.w,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 228, 236, 255),
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 67.w,
                              height: 67.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.w),
                              ),
                              child: Icon(Icons.video_collection_rounded),
                            ),
                            Text(
                              entry.title,
                              style: TextStyle(
                                fontFamily: Fonts.VazirBlack.fontFamily,
                                fontSize: 17.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
