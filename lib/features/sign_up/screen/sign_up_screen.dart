import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/AuthController.dart';
import 'package:restaurant_app/features/route/route_name.dart';
import 'package:restaurant_app/features/sign_up/widget/textform_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final authC = Get.put(AuthController());
  get isPassword => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text(
          "Silahkan Daftar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make appbar transparent
        elevation: 0, // Remove appbar shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff603813), Color(0xffB29F94)], // Gradient colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormWidget(
                        label: 'Username',
                        hintText: 'Masukkan Username',
                        textEditingController: authC.userNameController),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormWidget(
                        label: 'email',
                        hintText: 'Masukkan Email',
                        textEditingController: authC.emailController),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormWidget(
                      label: 'Password',
                      hintText: 'Masukkan Password',
                      textEditingController: authC.passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Obx(
                      () => TextFormWidget(
                          label: 'Alamat',
                          hintText: authC.userLocation.isEmpty
                              ? 'Alamat diisi otomatis'
                              : authC.userLocation.value),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(340, 50),
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async => await authC.signUpUser(),
                          child: Text(
                            authC.isLoading.isTrue ? 'Loading...' : 'Daftar',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () => Get.offAllNamed(RouteName.signInScreen),
                      child: Text(
                        "Sudah punya akun?",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
