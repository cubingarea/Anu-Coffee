import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/detail_controller.dart';
import 'package:restaurant_app/features/detail/widget/detail_widget.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  final DetailController detailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Obx(
          () {
            if (detailController.isLoading.isTrue) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            return SingleChildScrollView(
              child: DetailWidget(
                productModel: detailController.productModel.value,
              ),
            );
          },
        ),
      ),
    );
  }
}
