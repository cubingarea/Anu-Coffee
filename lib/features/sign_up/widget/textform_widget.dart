import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/AuthController.dart';

class TextFormWidget extends StatelessWidget {
  TextFormWidget(
      {super.key,
      required this.label,
      required this.hintText,
      this.isPassword,
      this.textEditingController});
  final String label;
  final String hintText;
  final bool? isPassword;
  final TextEditingController? textEditingController;
  final authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Obx(() {
          return TextFormField(
            controller: textEditingController,
            obscureText: authC.isObsecure.isTrue && isPassword != null,
            decoration: InputDecoration(
              suffixIcon: isPassword != null
                  ? IconButton(
                      onPressed: () => authC.changeIsObsecure(),
                      icon: Icon(authC.isObsecure.isTrue
                          ? Icons.visibility
                          : Icons.visibility_off))
                  : const SizedBox(),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: buttonColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: buttonColor),
              ),
            ),
          );
        }),
      ],
    );
  }
}
