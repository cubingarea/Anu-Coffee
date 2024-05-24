import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/profile_controller.dart';
import 'package:restaurant_app/features/profile/widget/textProfile_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child:
                    TextProfile(userModel: _profileController.userModel.value)),
          ],
        )),
      ),
    );
  }
}
