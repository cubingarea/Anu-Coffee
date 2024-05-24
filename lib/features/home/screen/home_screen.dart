import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:restaurant_app/features/controller/home_controller.dart';
import 'package:restaurant_app/features/home/widget/category_widge.dart';
import 'package:restaurant_app/features/home/widget/favorite_widget.dart';
import 'package:restaurant_app/features/home/widget/header_widget.dart';
import 'package:restaurant_app/features/home/widget/recommended_widget.dart';
import 'package:restaurant_app/features/home/widget/search_widget.dart';
import 'package:restaurant_app/features/route/route_name.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _homeController = Get.put(homeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            if (_homeController.isLoading.isTrue) {
              return SizedBox(
                height: Get.size.height,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () {
                          if (_homeController.isLoadingGetUser.isTrue) {
                            return const SizedBox();
                          }
                          return HeaderWidget(
                            userModel: _homeController.userModel.value,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SearchWidget(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CategoryWidget(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Menu Favorit",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 155.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                _homeController.favoriteProductList.length,
                            itemBuilder: (context, index) {
                              final data =
                                  _homeController.favoriteProductList[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(RouteName.detailScreen,
                                      arguments: {
                                        'product_id': data.productId,
                                      });
                                },
                                child: FavoriteWidget(
                                    imageUrl: data.productImage,
                                    label: data.productName,
                                    price: data.price),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rekomendasi",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              _homeController.recommendedProductList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final data =
                                _homeController.recommendedProductList[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(RouteName.detailScreen, arguments: {
                                  'product_id': data.productId,
                                });
                              },
                              child: recommendedWidget(
                                  label: data.productName,
                                  imageUrl: data.productImage,
                                  price: data.price),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
