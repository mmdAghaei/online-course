import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/widget-utils.dart';

class SectionDetailsScreen extends StatelessWidget {
  const SectionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.arguments.parts);
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
                  image: NetworkImage(""),
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
                      icon: Icon(Icons.arrow_back, color: Colors.white),
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
                padding: EdgeInsets.only(
                  left: 16.w,
                  bottom: 16.w,
                  right: 16.w,
                  top: 40.w,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: ListView(
                  controller: controller,
                  children: [
                    Text(
                      Get.arguments.title,
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
                          Get.arguments.partCount,
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
                      Get.arguments.partCount,
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: Theme.of(
                          context,
                        ).extension<CustomColors>()!.colorText,
                        fontFamily: Fonts.Vazir.fontFamily,
                      ),
                    ),
                    devider(),
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
