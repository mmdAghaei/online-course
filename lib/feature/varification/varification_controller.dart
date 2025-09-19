import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/data/api/auth/user-auth.dart';

class VarificationController extends GetxController {
  final int length = 5;
  final int initialSeconds = 10;

  final RxInt remainingSeconds = 0.obs;
  final RxBool isTimerRunning = false.obs;
  Timer? _timer;

  var code = List<String>.filled(5, '').obs;

  final List<TextEditingController> textControllers = [];
  final List<FocusNode> focusNodes = [];
  final UserAuthApi userAuthApi = Get.find<UserAuthApi>();
  @override
  void onInit() {
    super.onInit();

    remainingSeconds.value = initialSeconds;

    for (int i = 0; i < length; i++) {
      textControllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });

    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    remainingSeconds.value = initialSeconds;
    isTimerRunning.value = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value <= 0) {
        timer.cancel();
        isTimerRunning.value = false;
        remainingSeconds.value = 0;
      } else {
        remainingSeconds.value--;
      }
    });
  }

  void send(String username) async {
    var res = await userAuthApi.verifyEmail(
      code:
          "${textControllers[0].text}${textControllers[1].text}${textControllers[2].text}${textControllers[3].text}${textControllers[4].text}",
      username: username,
    );
    Get.snackbar("title", res.body["message"]);
  }

  void resendCode() {
    debugPrint('Resend code to user phone (call your API here)');

    clearAll();
    startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  void clearAll() {
    for (final c in textControllers) {
      c.clear();
    }
    for (int i = 0; i < length; i++) {
      code[i] = '';
    }
  }

  void onChanged(String value, int index) {
    if (value.length > 1) {
      value = value.substring(0, 1);
      textControllers[index].text = value;
      textControllers[index].selection = TextSelection.fromPosition(
        TextPosition(offset: textControllers[index].text.length),
      );
    }

    code[index] = value;

    if (value.isNotEmpty && index < length - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  String get fullCode => code.join();

  @override
  void onClose() {
    _timer?.cancel();
    for (final c in textControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }
}
