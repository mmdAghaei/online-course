import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/models/courses-model.dart';

class BuyScreen extends StatelessWidget {
  final CoursesModel coursesModel;
  const BuyScreen({super.key, required this.coursesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(width: 220, height: 100),
            Container(
              width: 337.w,
              height: 347.w,
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 337.w,
                      height: 100.w,
                      child: CardCourse(coursesModel: Get.arguments),
                    ),
                    Container(
                      width: 337.w,
                      height: 2.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(color: Color(0xFFCFCFCF)),
                    ),
                    Container(
                      width: 337.w,
                      height: 73.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xDDCFCFCF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "شماره تلفن",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                                Text(
                                  "09100102",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 337.w,
                            height: 2.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Color(0xFFCFCFCF),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "شماره تلفن",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                                Text(
                                  "09100102",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 337.w,
                      height: 2.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(color: Color(0xFFCFCFCF)),
                    ),
                    Container(
                      width: 337.w,
                      height: 109.5.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xDDCFCFCF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "قیمت اصلی",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                                Text(
                                  "${faToEnNumbers(coursesModel.finalPrice == "0" ? "" : coursesModel.price)}",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 337.w,
                            height: 2.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Color(0xFFCFCFCF),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "تخفیف",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                                Text(
                                  "10%",
                                  // (-((int.parse(
                                  //                   (Get
                                  //                               .arguments
                                  //                               .priceOffers ==
                                  //                           "0"
                                  //                       ? Get.arguments.price
                                  //                       : Get
                                  //                           .arguments
                                  //                           .priceOffers),
                                  //                 ) -
                                  //                 int.parse(
                                  //                   coursesModel.priceOffers ==
                                  //                           "0"
                                  //                       ? ""
                                  //                       : coursesModel.price,
                                  //                 )) /
                                  //             int.parse(
                                  //               coursesModel.priceOffers == "0"
                                  //                   ? ""
                                  //                   : coursesModel.price,
                                  //             ) *
                                  //             100))
                                  //         .toString() +
                                  //     "%",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 337.w,
                            height: 2.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Color(0xFFCFCFCF),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "قیمت نهایی",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                                Text(
                                  "${faToEnNumbers(Get.arguments.priceOffers == "0" ? Get.arguments.price : Get.arguments.priceOffers)}",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: Fonts.VazirMedium.fontFamily,
                                    color: Color(0xff989898),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 326.w,
              height: 55.h,
              child: ButtonApp(
                title:
                    "پرداخت ${faToEnNumbers(Get.arguments.priceOffers == "0" ? Get.arguments.price : Get.arguments.priceOffers)} ریال",
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
