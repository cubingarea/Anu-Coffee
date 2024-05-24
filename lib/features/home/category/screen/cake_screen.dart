import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/category_controller.dart';
import 'package:restaurant_app/features/home/category/widget/cake_grid.dart';
import 'package:restaurant_app/features/route/route_name.dart';

class CakeScreen extends StatelessWidget {
  CakeScreen({super.key});
  final _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    // Fetch only cake products
    _categoryController.getCakeProduct();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cake",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make appbar transparent
        elevation: 0, // Remove appbar shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff603813), Color(0xffB29F94)], // Gradient colors
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (_categoryController.isLoading.isTrue) {
              return SizedBox(
                height: Get.size.height,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                children: [
                  GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _categoryController.CategoryProductList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 230,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16),
                    itemBuilder: (context, index) {
                      final data =
                          _categoryController.CategoryProductList[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.detailScreen, arguments: {
                            'product_id': data.productId,
                          });
                        },
                        child: cakeGrid(
                            imageUrl: data.productImage,
                            label: data.productName,
                            price: data.price,
                            index: index),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
