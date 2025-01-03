//create a getx controller route for chat history.

import 'package:get/get.dart';
import 'package:manifast_app/Bindings/AppBindings.dart';
import 'package:manifast_app/Home/home_view.dart';
import 'package:manifast_app/Journal/journal_view.dart';
import 'package:manifast_app/Manifest/manifest_view.dart';
import 'package:manifast_app/Refferal/referral_view.dart';
import 'package:manifast_app/Shop/shop_view.dart';

import 'Splash/splash_view.dart';

abstract class Routes {
  // static const String upload = '/upload';
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String refferal = '/refferal';
  static const String shop = '/shop';
  static const String journal = '/journal';
  static const String manifest = '/manifest';
}

class Pages {
  static final pages = [
    // GetPage(
    //     name: Routes.login,
    //     page: () => const LoginPage(),
    //     transition: Transition.cupertino,
    //     middlewares: [LoginMiddleware()],
    //     binding: AppBindings()),
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      transition: Transition.cupertino,
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      transition: Transition.cupertino,
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.refferal,
      page: () => const ReferralPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.manifest,
      page: () => ManifestPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.shop,
      page: () => ShopPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.journal,
      page: () => JournalPage(),
      transition: Transition.cupertino,
    ),

    // GetPage(
    //   name: Routes.messageSettings,
    //   page: () => const MessageAISettings(),
    // ),
  ];
}
