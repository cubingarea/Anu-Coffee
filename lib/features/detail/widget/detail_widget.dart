import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/detail_controller.dart';
import 'package:restaurant_app/features/models/product_model.dart';

class DetailWidget extends StatelessWidget {
  DetailWidget({super.key, required this.productModel});
  final ProductModel productModel;
  final DetailController detailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18)),
                  image: DecorationImage(
                      image: NetworkImage(productModel.productImage),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    productModel.productName,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      size: 36.0,
                      color: buttonColor,
                    ),
                  ),
                  Obx(
                    () => detailController.isLoadingFavorite.isTrue
                        ? const SizedBox()
                        : InkWell(
                            onTap: () => detailController
                                .handleFavorite(productModel.productId),
                            child: Icon(
                              detailController.userModel!.productFavorite
                                      .contains(productModel.productId)
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 36.0,
                              color: Color(0xffff0000),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
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
                  'Rp. ${productModel.price}',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  productModel.productDescription,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            )),

        // InkWell(
        //   child: Container(
        //     margin: EdgeInsets.symmetric(horizontal: 36),
        //     padding: EdgeInsets.all(16),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(18),
        //         color: CardColor),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           children: [
        //             Image.asset(
        //               "assets/icon/promo.png",
        //               height: 32,
        //               width: 32,
        //             ),
        //             const SizedBox(
        //               width: 10.0,
        //             ),
        //             Text(
        //               "Gunakan Voucher",
        //               style: TextStyle(
        //                 fontSize: 13.0,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //         const Icon(
        //           Icons.chevron_right,
        //           size: 24.0,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 22.0,
        // ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 36),
        //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(18), color: CardColor),
        //   child: Row(
        //     children: [
        //       Container(
        //         height: 110,
        //         width: 110,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(18),
        //             image: DecorationImage(
        //                 image: AssetImage(productModel.imageUrl),
        //                 fit: BoxFit.cover)),
        //       ),
        //       const SizedBox(
        //         width: 5.0,
        //       ),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               productModel.label,
        //               style: TextStyle(
        //                 fontSize: 16.0,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10.0,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Obx(
        //                   () => Container(
        //                     height: 34,
        //                     width: 34,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(8),
        //                       border: Border.all(color: primaryColor),
        //                     ),
        //                     child: Center(
        //                       child: Text(
        //                         '${detailController.itemCount}',
        //                         style: TextStyle(
        //                           fontSize: 16.0,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 Row(
        //                   children: [
        //                     InkWell(
        //                       onTap: () =>
        //                           detailController.incrementItem(),
        //                       child: Container(
        //                         height: 34,
        //                         width: 34,
        //                         decoration: BoxDecoration(
        //                             borderRadius:
        //                                 BorderRadius.circular(8),
        //                             color: primaryColor),
        //                         child: const Icon(
        //                           Icons.add,
        //                           size: 24.0,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       width: 8.0,
        //                     ),
        //                     InkWell(
        //                       onTap: () =>
        //                           detailController.decrementItem(),
        //                       child: Container(
        //                         height: 34,
        //                         width: 34,
        //                         decoration: BoxDecoration(
        //                             borderRadius:
        //                                 BorderRadius.circular(8),
        //                             color: primaryColor),
        //                         child: const Icon(
        //                           Icons.remove,
        //                           size: 24.0,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ],
        //             ),
        //             const SizedBox(
        //               height: 8.0,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   "Total",
        //                   style: TextStyle(
        //                     fontSize: 12.0,
        //                   ),
        //                 ),
        //                 Obx(() => Text(
        //                       'Rp.${detailController.totalPrice(productModel).value}',
        //                       style: TextStyle(
        //                         fontSize: 13.0,
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     )),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 20.0,
        // ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 36),
        //   child: ElevatedButton(
        //     onPressed: () => Get.toNamed(RouteName.orderScreen, arguments: {
        //       'data': detailController.productModel.value.toJson(),
        //       'totalPrice': detailController
        //           .totalPrice(detailController.productModel.value)
        //           .value,
        //       'totalItem': detailController.itemCount.value
        //     }),
        //     style: ButtonStyle(
        //         backgroundColor: MaterialStatePropertyAll(primaryColor),
        //         shape: MaterialStatePropertyAll(
        //           RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(18),
        //           ),
        //         ),
        //         padding: MaterialStatePropertyAll(
        //             EdgeInsets.symmetric(horizontal: 119, vertical: 12))),
        //     child: Text(
        //       "Pesan",
        //       style: TextStyle(
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.white),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
