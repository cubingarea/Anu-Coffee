import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/home_controller.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key});

  final _homeController = Get.put(homeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _homeController.categoryList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () =>
              Get.toNamed(_homeController.categoryList[index]['route']!),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                      _homeController.categoryList[index]['imageUrl']!),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  _homeController.categoryList[index]['label']!,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
