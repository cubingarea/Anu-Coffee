import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:restaurant_app/features/cart/widget/cart_widget.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/product_Controller.dart';
import 'package:restaurant_app/features/route/route_name.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Keranjang",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 125,
                      height: 3,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _productController.ProductList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = _productController.ProductList[index];
                        return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListCart(
                                imageUrl: data.productImage,
                                menuTitle: data.productName,
                                price: data.price,
                                productController: _productController,
                                index: index));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                onPressed: () {
                  if (_productController.totalPrice().value == 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Pesanan belum dapat diproses:(",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          content:
                              Text("Anda belum menambahkan item ke keranjang."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Get.toNamed(RouteName.orderScreen);
                  }
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
                  "Pesan",
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
