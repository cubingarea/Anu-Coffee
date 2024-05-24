import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailController());
  }
}
