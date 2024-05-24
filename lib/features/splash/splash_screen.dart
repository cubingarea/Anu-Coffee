import 'package:flutter/material.dart';
import 'package:restaurant_app/features/constant/const_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        body: Center(
          child: Image.asset(
            "assets/icon/anucoffee.png",
            width: 200.0,
            height: 200.0,
            fit: BoxFit.fill,
          ),
        ));
  }
}
