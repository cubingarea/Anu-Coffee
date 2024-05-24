import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/controller/product_Controller.dart';
import 'package:restaurant_app/features/cart/widget/cart_widget.dart';
import 'package:restaurant_app/features/constant/const_color.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pesanan"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Obx(() {
                  final orderedProducts = _productController.ProductList.where(
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
                          child: ListCart(
                            imageUrl: product.productImage,
                            menuTitle: product.productName,
                            price: product.price,
                            productController: _productController,
                            index:
                                _productController.ProductList.indexOf(product),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }),
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
                  // Tambahkan logika untuk menavigasi ke halaman OrderScreen
                  Get.to(OrderScreen());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(buttonColor),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 119, vertical: 12),
                  ),
                ),
                child: Text(
                  "Pesan",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
