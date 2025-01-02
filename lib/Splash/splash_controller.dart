import 'package:get/get.dart';
import 'dart:async';

/// Handles splash screen logic
class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('SplashController is initialized');
  }

  @override
  void onReady() {
    super.onReady();

    Timer(const Duration(seconds: 3), () {
      print('SplashController is ready');
      Get.offAllNamed('/home');
    });
  }
}
