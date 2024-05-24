import 'package:flutter/material.dart';
import 'package:restaurant_app/features/constant/const_color.dart';

class coffeeGrid extends StatelessWidget {
  const coffeeGrid(
      {super.key,
      required this.imageUrl,
      required this.label,
      required this.price,
      required this.index});

  final String imageUrl;
  final String label;
  final String price;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 20),
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
                  imageUrl,
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
            label,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "RP.${price}",
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
