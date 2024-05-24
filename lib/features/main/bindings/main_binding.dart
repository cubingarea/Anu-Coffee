import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/favorite_controller.dart';
import 'package:restaurant_app/features/controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController());
    Get.put(MainController());
  }
}
