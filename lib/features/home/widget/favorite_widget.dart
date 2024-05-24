import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/features/constant/const_color.dart';

class FavoriteWidget extends StatelessWidget {
  FavoriteWidget(
      {super.key,
      required this.imageUrl,
      required this.label,
      required this.price});

  final String imageUrl;
  final String label;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 155,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp.${price}',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
