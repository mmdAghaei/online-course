import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/animation.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/devices/device-list-api.dart';
import 'package:shimmer/shimmer.dart';

class DevicesListScreen extends StatelessWidget {
  const DevicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceListApiController deviceListApiController = Get.put(
      DeviceListApiController(),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (deviceListApiController.deviceList.isEmpty) {
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
                  children: deviceListApiController.deviceList.map((index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100.w,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).extension<CustomColors>()!.card,
                        borderRadius: BorderRadius.circular(16.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 30.w,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 65.w,
                            height: 65.w,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Color(0xffE9F3FC),
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                index.os,
                                style: TextStyle(
                                  fontFamily: Fonts.VazirMedium.fontFamily,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                index.ipAddress,
                                style: TextStyle(
                                  fontFamily: Fonts.VazirMedium.fontFamily,
                                  fontSize: 10.sp,
                                  color: Color(0xff777777),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                toJalaliDate(index.createdAt),
                                style: TextStyle(
                                  fontFamily: Fonts.VazirMedium.fontFamily,
                                  fontSize: 10.sp,
                                  color: Color(0xff777777),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // IconButton(
                                //   onPressed: () {

                                //   },
                                //   icon: Icon(
                                //     Icons.delete,
                                //     size: 23.w,
                                //     color: Color(0xffFF0000),
                                //   ),
                                // ),
                                Container(
                                  width: 80.w,
                                  height: 31.w,
                                  margin: EdgeInsets.only(left: 15),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "سوال",
                                        middleText: "آیا مطمئن هستید؟",
                                        textConfirm: "بله",
                                        textCancel: "خیر",
                                        onConfirm: () {
                                          deviceListApiController.RemoveDeviceList(
                                            index.id,
                                          );
                                          Get.back();
                                        },
                                        onCancel: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                    child: Text(
                                      "خروج",
                                      style: TextStyle(
                                        fontFamily: Fonts.Vazir.fontFamily,
                                        fontSize: 12.sp,
                                        color: const Color.fromARGB(
                                          255,
                                          255,
                                          0,
                                          0,
                                        ),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Theme.of(
                                          context,
                                        ).extension<CustomColors>()!.card,
                                      ),
                                      shape:
                                          MaterialStateProperty.all<
                                            RoundedRectangleBorder
                                          >(
                                            RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.red,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
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
