import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Controls whether the side menu is open
  var isMenuOpen = false.obs;

  late AnimationController menuAnimationController;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Slide from left (-1.0) to 0.0
    slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(menuAnimationController);
  }

  void toggleMenu() {
    if (isMenuOpen.value) {
      menuAnimationController.reverse();
      isMenuOpen.value = false;
    } else {
      menuAnimationController.forward();
      isMenuOpen.value = true;
    }
  }

  @override
  void dispose() {
    menuAnimationController.dispose();
    super.dispose();
  }
}
