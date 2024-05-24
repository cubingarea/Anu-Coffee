import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/product_Controller.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:restaurant_app/features/order/widget/list_order.dart';

class OrderWidget extends StatelessWidget {
  OrderWidget({super.key, required this.userModel});
  final _productController = Get.put(ProductController());
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alamat Section
              Row(
                children: [
                  Image.asset(
                    "assets/icon/location.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alamat Anda",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userModel.userName,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userModel.location.address,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // Catatan dan Ganti Alamat Buttons

              const SizedBox(height: 20.0),
              // Delivery Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 11, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18), color: CardColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icon/delivery.png",
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              "Delivery",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icon/clock.png",
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              "18 mnt",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // Pesanan Anda Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pesanan Anda",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Obx(() {
                      final orderedProducts =
                          _productController.ProductList.where(
                              (product) => product.quantity.value > 0).toList();
                      if (orderedProducts.isEmpty) {
                        return Center(
                          child: Text("Belum ada pesanan"),
                        );
                      } else {
                        return Column(
                          children: orderedProducts.map((product) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListOrder(
                                imageUrl: product.productImage,
                                menuTitle: product.productName,
                                price: product.price,
                                productController: _productController,
                                index: _productController.ProductList.indexOf(
                                    product),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
