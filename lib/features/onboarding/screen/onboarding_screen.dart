import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              onboardingController.indexImage.value = value;
            },
            itemCount: onboardingController.imagesOnboarding.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  color: secondaryColor,
                  image: DecorationImage(
                      image: AssetImage(
                          onboardingController.imagesOnboarding[index]),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 114,
            right: 114,
            child: Column(
              children: [
                Obx(
                  () => ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 9, horizontal: 18)),
                        minimumSize: MaterialStatePropertyAll(
                          Size(200, 60),
                        ),
                        backgroundColor: MaterialStatePropertyAll(buttonColor),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)))),
                    onPressed: () => onboardingController.handleGetStarted(),
                    child: Text(
                      onboardingController.isLoading.isTrue
                          ? 'Loading...'
                          : 'Mulai',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: bgColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    onboardingController.imagesOnboarding.length,
                    (index) => Obx(
                      () => Container(
                        width: 45,
                        height: 5,
                        color: onboardingController.indexImage.value == index
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
