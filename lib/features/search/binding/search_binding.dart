import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(searchFeatureController());
  }
}
