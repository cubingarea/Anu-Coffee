import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/favorite_controller.dart';
import 'package:restaurant_app/features/route/route_name.dart';

class ListCard extends StatelessWidget {
  ListCard({super.key, required this.favoriteController, required this.index});

  final int index;
  final FavoriteController favoriteController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.detailScreen, arguments: {
          'product_id': favoriteController.favoriteproduct[index].productId,
        });
      },
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: secondaryColor,
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    favoriteController.favoriteproduct[index].productImage,
                    width: 118,
                    height: 118,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favoriteController.favoriteproduct[index].productName,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    "Rp.${favoriteController.favoriteproduct[index].price}",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () => favoriteController.removeFromFav(
                    favoriteController.favoriteproduct[index].productId),
                icon: Icon(
                  favoriteController.userModel!.productFavorite.contains(
                          favoriteController.favoriteproduct[index].productId)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  size: 26,
                  color: Color(0xffFF0000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
