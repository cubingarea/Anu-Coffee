import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/order_controller.dart';
import 'package:restaurant_app/features/controller/product_Controller.dart';
import 'package:restaurant_app/features/models/product_model.dart';
import 'package:restaurant_app/features/order/widget/order_widget.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({
    Key? key,
    this.productModel,
    this.totalPrice,
    this.totalItem,
  }) : super(key: key);

  final ProductModel? productModel;
  final int? totalPrice;
  final int? totalItem;
  final _productController = Get.put(ProductController());
  final _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pesan",
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            size: 36,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if (_orderController.isLoadingGetUser.isTrue) {
                  return const SizedBox();
                }
                return OrderWidget(
                  userModel: _orderController.userModel.value,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() => Text(
                      "Rp.${_productController.totalPrice().value}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  await _orderController.createOrder();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(buttonColor),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 119, vertical: 12))),
                child: Text(
                  "Order",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
