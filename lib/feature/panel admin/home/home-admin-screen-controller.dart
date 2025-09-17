import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:podcast/data/models/user-model.dart';

class FabController extends GetxController {
  var isOpen = false.obs;
  final ValueNotifier<bool> openCloseDial = ValueNotifier<bool>(false);

  void toggle(bool v) {
    isOpen.value = v;
    openCloseDial.value = v;
  }

  @override
  void onClose() {
    openCloseDial.dispose();
    super.onClose();
  }
}
