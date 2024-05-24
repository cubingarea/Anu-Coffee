import 'package:flutter/material.dart';
import 'package:restaurant_app/features/models/user_model.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hai, ${userModel.userName}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 24.0,
                  color: Color(0xffff0000),
                ),
                Text(
                  userModel.location.address,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Selamat Datang di Anu Coffee",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
