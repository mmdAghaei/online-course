import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/feature/panel%20admin/news/add/add-news-controller.dart';

class AddNewsScreen extends StatelessWidget {
  const AddNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddNewsController addNewsController = Get.put(AddNewsController());
    if (Get.arguments["data"] != null) {
      addNewsController.title.text = Get.arguments["data"].title;
      addNewsController.description.text = Get.arguments["data"].content;
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
            onPressed: () {},
            icon: Icon(Icons.save_alt_outlined, color: Colors.green),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 15,
            children: [
              Obx(() {
                String? selectedPath =
                    addNewsController.selectedImagePath.value;
                String? serverImage = Get.arguments["data"]?.image;

                return InkWell(
                  onTap: () => addNewsController.pickImage(),
                  child: Container(
                    width: 305.w,
                    height: 305.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      image: (selectedPath != null && selectedPath.isNotEmpty)
                          ? DecorationImage(
                              image: FileImage(File(selectedPath)),
                              fit: BoxFit.cover,
                            )
                          : (serverImage != null && serverImage.isNotEmpty)
                          ? DecorationImage(
                              image: NetworkImage(serverImage),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child:
                        (selectedPath == null || selectedPath.isEmpty) &&
                            (serverImage == null || serverImage.isEmpty)
                        ? Icon(
                            Icons.add_photo_alternate,
                            size: 50.w,
                            color: Colors.white,
                          )
                        : null,
                  ),
                );
              }),

              SizedBox(
                width: 305.w,
                child: TextFieldWidget(
                  textEditingController: addNewsController.title,
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
                      controller: addNewsController.description,
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
            ],
          ),
        ),
      ),
    );
  }
}
