import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/theme/app-theme.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/data/api/panel/panel-admin-controller.dart';
import 'package:podcast/feature/my%20course/my-course-controller.dart';
import 'package:podcast/feature/panel%20admin/course/add/add-edit-course-controller.dart';
import 'package:podcast/feature/panel%20admin/course/section/section-list.dart';

class AddEditCourseScreen extends StatelessWidget {
  const AddEditCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditCourseController editCourseController = Get.put(
      EditCourseController(),
    );
    final PanelAdminController panelAdminController = Get.find();
    final ImageController imageController = Get.put(ImageController());
    Widget _buildPillToggle() {
      return Obx(() {
        final isLogin = editCourseController.isLogin.value;
        return Container(
          width: 312.w,
          height: 44.w,
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: editCourseController.setLogin,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isLogin
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      "فعال",
                      style: TextStyle(
                        color: isLogin ? Colors.white : const Color(0xFF0F172A),
                        fontFamily: Fonts.VazirBold.fontFamily,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: editCourseController.setRegister,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !isLogin
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      "غیرفعال",
                      style: TextStyle(
                        color: !isLogin
                            ? Colors.white
                            : const Color(0xFF0F172A),
                        fontFamily: Fonts.VazirBold.fontFamily,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments["title"] ?? "",
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: Fonts.VazirBold.fontFamily,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.red),
          ),
          IconButton(
            onPressed: () {
              if (Get.arguments["title"] == "اضافه کردن دوره") {
                panelAdminController.createCourse(
                  editCourseController.isLogin.value,
                );
              }
            },
            icon: Icon(Icons.save_alt_outlined, color: Colors.green),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 15,
            children: [
              Obx(
                () => InkWell(
                  onTap: () => panelAdminController.pickImage(),
                  child: Container(
                    width: 305.w,
                    height: 305.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: FileImage(
                          File(
                            panelAdminController.selectedImagePath.value ?? "",
                          ),
                        ),
                        // Get.arguments["data"].image != null
                        //     ? NetworkImage(Get.arguments["data"].image ?? "")
                        //     : AssetImage(
                        //         "assets/photo_2025-08-22_19-11-50.jpg",
                        //       ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: imageController.selectedImagePath.value != null
                        ? Image.file(
                            File(imageController.selectedImagePath.value!),
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.add_photo_alternate,
                            size: 50.w,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: 305.w,
                child: TextFieldWidget(
                  textEditingController: panelAdminController.title,
                  hintText: "عنوان",
                  icon: Icon(Icons.person, size: 24),
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  textInputFormatters: [],
                ),
              ),
              Container(
                width: 305.w,
                padding: EdgeInsets.fromLTRB(18, 14, 18, 52),
                decoration: BoxDecoration(
                  // color: Theme.of(context).extension<CustomColors>()!.card,
                  border: Border.all(color: Color(0x80DFDFDF), width: 2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: panelAdminController.description,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      minLines: 1,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "توضیحات",
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 6),
                      ),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 305.w,
                child: TextFieldWidget(
                  textEditingController: panelAdminController.price,
                  hintText: "قیمت (تومان)",
                  icon: Icon(Icons.price_change, size: 24),
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  textInputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              SizedBox(
                width: 305.w,
                child: TextFieldWidget(
                  textEditingController: panelAdminController.discount,
                  hintText: "تخفیف",
                  icon: Icon(Icons.discount, size: 24),
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  textInputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              _buildPillToggle(),
              Container(
                width: 305.w,
                height: 45.w,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(SectionListScreen());
                  },
                  child: Text(
                    "ویرایش فصل ها",
                    style: TextStyle(
                      fontFamily: Fonts.Vazir.fontFamily,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
