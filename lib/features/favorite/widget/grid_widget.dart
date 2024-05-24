import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/favorite_controller.dart';
import 'package:restaurant_app/features/route/route_name.dart';

class GridCard extends StatelessWidget {
  GridCard({super.key, required this.favoriteController, required this.index});

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
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: secondaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    favoriteController.favoriteproduct[index].productImage,
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              favoriteController.favoriteproduct[index].productName,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "RP.${favoriteController.favoriteproduct[index].price}",
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topRight,
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
