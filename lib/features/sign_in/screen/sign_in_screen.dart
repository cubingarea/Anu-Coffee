import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/AuthController.dart';
import 'package:restaurant_app/features/route/route_name.dart';
import 'package:restaurant_app/features/sign_in/widget/textlogin.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final AuthController authController = Get.find();

  get isPassword => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFE6CCB2),
      appBar: AppBar(
        title: Text(
          "Anu Coffee",
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
                        "Login",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextLoginWidget(
                      label: 'Email',
                      hintText: 'Masukkan Email Anda',
                      textEditingController: authController.emailController,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextLoginWidget(
                      label: 'Password',
                      hintText: 'Masukkan Password Anda',
                      isPassword: true,
                      textEditingController: authController.passwordController,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(340, 50),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          await authController.signInUser();
                          // NotificationService.showNotif(
                          //   'Login Berhasil',
                          //   'Selamat Datang di Anu Coffee',
                          // );
                          Get.snackbar(
                              "Login Berhasil", "Selamat Datang di Anu Coffee");
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(RouteName.signUpScreen),
                      child: Text(
                        "Belum Punya Akun?",
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
