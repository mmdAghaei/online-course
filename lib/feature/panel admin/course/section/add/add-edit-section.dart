import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/core/utils/widget-utils.dart';
import 'package:podcast/feature/panel%20admin/course/part/list-part.dart';
import 'package:podcast/feature/panel%20admin/course/section/section-list.dart';

class AddEditSectionScreen extends StatelessWidget {
  const AddEditSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments["title"],
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            SizedBox(
              width: 305.w,
              child: TextFieldWidget(
                textEditingController: TextEditingController(),
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
                textEditingController: TextEditingController(),
                hintText: "قیمت (ریال)",
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
                textEditingController: TextEditingController(),
                hintText: "تخفیف",
                icon: Icon(Icons.discount, size: 24),
                keyboardType: TextInputType.number,
                obscureText: false,
                textInputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            Container(
              width: 305.w,
              height: 45.w,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(ListPartScreen());
                },
                child: Text(
                  "ویرایش پارت ها",
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
    );
  }
}
