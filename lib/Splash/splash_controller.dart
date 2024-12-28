import 'dart:async';

import 'package:get/get.dart';

/// Handles splash screen logic
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed('/home');
    });
  }
}
