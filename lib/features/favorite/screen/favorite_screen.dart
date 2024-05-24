import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/favorite_controller.dart';
import 'package:restaurant_app/features/favorite/widget/grid_widget.dart';
import 'package:restaurant_app/features/favorite/widget/list_card.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavoriteController _favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Favorite Anda",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: 170,
                        height: 3,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: () => _favoriteController.toggleIsGrid(),
                      icon: Icon(
                        _favoriteController.isGrid.isFalse
                            ? Icons.grid_view
                            : Icons.list,
                        size: 32,
                        color: buttonColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 31.0,
              ),
              Obx(
                () {
                  if (_favoriteController.isGrid.isTrue) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _favoriteController.favoriteproduct.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 230,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16),
                      itemBuilder: (context, index) {
                        return GridCard(
                          favoriteController: _favoriteController,
                          index: index,
                        );
                      },
                    );
                  }
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _favoriteController.favoriteproduct.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListCard(
                          favoriteController: _favoriteController,
                          index: index,
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
