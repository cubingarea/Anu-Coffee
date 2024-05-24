import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/route/route_name.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        onTap: () => Get.toNamed(RouteName.searchScreen),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
          suffixIcon: const Icon(
            Icons.search,
            size: 24.0,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
