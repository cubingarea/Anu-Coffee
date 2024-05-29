import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/controller/AuthController.dart';
import 'package:restaurant_app/features/controller/profile_controller.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:restaurant_app/features/route/route_name.dart';
// import 'package:restaurant_app/features/services/notif_service.dart';

class TextProfile extends StatefulWidget {
  final UserModel userModel;

  TextProfile({super.key, required this.userModel});

  @override
  _TextProfileState createState() => _TextProfileState();
}

class _TextProfileState extends State<TextProfile> {
  final _profileController = Get.put(ProfileController());
  final authC = Get.put(AuthController());

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.userModel.userName);
    _emailController = TextEditingController(text: widget.userModel.email);
    _passwordController =
        TextEditingController(text: widget.userModel.password);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get isPassword => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            width: 70,
            height: 3,
            color: primaryColor,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "Username",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Masukkan Username Anda',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "Email",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          TextFormField(
            controller: _emailController,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Masukkan Email Anda',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "Password",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Obx(() {
            return TextFormField(
              controller: _passwordController,
              obscureText: _profileController.isObsecure.isTrue,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: _profileController.toggleObscure,
                  icon: Icon(_profileController.isObsecure.isTrue
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                hintText: 'Enter your password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryColor),
                ),
              ),
            );
          }),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(340, 50),
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await _profileController.updateUser(
                      userName: _usernameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    // NotificationService.showNotif(
                    //   'Username/Password berhasil diubah',
                    //   'Silahkan Login Kembali',
                    // );
                    Get.snackbar('Username/Password berhasil diubah',
                        'Silahkan Login Kembali');
                    Get.offAllNamed(RouteName.signInScreen);
                  },
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () async => await _profileController.signOut(),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
