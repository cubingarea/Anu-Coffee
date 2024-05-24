import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/search_controller.dart';
import 'package:restaurant_app/features/route/route_name.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchFeatureController _searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) async =>
                    _searchController.searchProduct(value),
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: secondaryColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color(0xff575B5C),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                if (_searchController.isLoading.isTrue) {
                  const Expanded(
                      child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ));
                }

                if (_searchController.isLoading.isFalse &&
                    _searchController.searchProducts.isNotEmpty) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: _searchController.searchProducts.length,
                    itemBuilder: (context, index) {
                      final product = _searchController.searchProducts[index];
                      return ListTile(
                        onTap: () => Get.toNamed(RouteName.detailScreen,
                            arguments: {"product_id": product["product_id"]}),
                        title: Text(
                          product["product_name"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        leading: Container(
                          width: 108,
                          height: 108,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                  product["product_image"],
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        subtitle: Text(
                          "Rp. ${product["price"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      );
                    },
                  ));
                }
                return const Expanded(
                  child: Center(
                    child: Text(
                      "Cari Menu Yang Anda Inginkan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
