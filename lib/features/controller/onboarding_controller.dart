import 'package:get/get.dart';
import 'package:restaurant_app/features/route/route_name.dart';
import 'package:restaurant_app/features/services/location_services.dart';

class OnboardingController extends GetxController {
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  final imagesOnboarding = [
    'assets/img/espresso.jpg',
    'assets/img/matcha.jpg',
    'assets/img/chocolate.jpg',
  ];

  RxInt indexImage = 0.obs;

  void handleGetStarted() async {
    _isLoading.value = true;
    final location = await LocationService.getCurrentPosition();
    _isLoading.value = false;
    if (location != null) {
      Get.offAllNamed(RouteName.signUpScreen);
    } else {
      return;
    }
  }
}
