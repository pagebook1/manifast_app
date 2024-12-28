import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:manifast_app/Journal/journal_view.dart';

import 'Home/home_controller.dart';
import 'Home/home_view.dart';
import 'Manifest/manifest_controller.dart';
import 'Manifest/manifest_view.dart';
import 'Refferal/referral_view.dart';
import 'Shop/shop_view.dart';
import 'Splash/spash_view.dart';
import 'Splash/splash_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manifast App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashPage(),
          binding: BindingsBuilder(() {
            Get.put(SplashController());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: BindingsBuilder(() {
            Get.put(HomeController());
          }),
        ),
        GetPage(
          name: '/manifest',
          page: () => const ManifestPage(),
          binding: BindingsBuilder(() {
            Get.put(ManifestController());
          }),
        ),
        GetPage(name: '/journal', page: () => const JournalPage()),
        GetPage(name: '/shop', page: () => const ShopPage()),
        GetPage(name: '/referrals', page: () => const ReferralPage()),
      ],
    );
  }
}
