import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController mainc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: mainc.indexBottomNavBar.value,
            onTap: (value) => mainc.changeIndex(value),
            backgroundColor: navbarColor,
            selectedItemColor: buttonColor,
            unselectedItemColor: Colors.black,
            selectedFontSize: 16,
            items: mainc.ListBottomNav),
      ),
      body: Obx(() => mainc.bodyMain[mainc.indexBottomNavBar.value]),
    );
  }
}
