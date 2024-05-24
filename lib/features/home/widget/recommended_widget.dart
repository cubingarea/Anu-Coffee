import 'package:flutter/material.dart';
import 'package:restaurant_app/features/constant/const_color.dart';

class recommendedWidget extends StatelessWidget {
  const recommendedWidget({
    super.key,
    required this.label,
    required this.imageUrl,
    required this.price,
  });

  final String label;
  final String imageUrl;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 160,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 115,
            height: 140,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                Text(
                  'Rp.${price}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: CardColor),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: CardColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
