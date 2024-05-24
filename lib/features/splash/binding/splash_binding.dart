import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
