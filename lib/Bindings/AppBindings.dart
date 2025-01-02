import 'package:get/get.dart';
import 'package:manifast_app/Home/home_controller.dart';
import 'package:manifast_app/Manifest/manifest_controller.dart';
import 'package:manifast_app/Splash/splash_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SplashController>()) {
      Get.lazyPut(() => SplashController());
    }
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut(() => HomeController());
    }
    if (!Get.isRegistered<ManifestController>()) {
      Get.lazyPut(() => ManifestController());
    }
  }

  // void deleteDependencies() {
  //   Get.delete<ChatController>();
  //   Get.delete<UserController>();
  // }
}
