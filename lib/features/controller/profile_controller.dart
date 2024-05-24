import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/models/location_model.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:restaurant_app/features/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final RxBool _isObsecure = true.obs;
  RxBool get isObsecure => _isObsecure;

  Rx<UserModel> _userModel = UserModel(
      id: '',
      uid: '',
      accessToken: '',
      token: '',
      email: '',
      userName: '',
      password: '',
      location: LocationModel(address: '', longitude: '', latitude: ''),
      createdAt: DateTime.now(),
      productFavorite: []).obs;

  Rx<UserModel> get userModel => _userModel;

  final RxBool _isLoadingGetUser = false.obs;
  RxBool get isLoadingGetUser => _isLoadingGetUser;

  Future<UserModel> getCurrentUser() async {
    _isLoadingGetUser.value = true;
    try {
      final preferences = await SharedPreferences.getInstance();
      final user = preferences.getString('user');
      final userDecode = jsonDecode(user!);
      _userModel.value = UserModel.fromJson(userDecode);
      return _userModel.value;
    } catch (err) {
      print('ERROR GET CURRENT USER $err');
      return _userModel.value;
    } finally {
      _isLoadingGetUser.value = false;
    }
  }

  Future<void> updateUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;

      if (user != null) {
        String email = user.email ?? '';
        print("USER : $email");
        await user.updatePassword(password);

        print('Password updated successfully');
      }

      DocumentSnapshot userDoc = await userCollection.doc(email).get();

      if (userDoc.exists) {
        // Document exists, proceed with update
        await userCollection.doc(email).update({
          'userName': userName,
          'email': email,
          'password': password,
        });
        print('User updated successfully');
        // Update local state and shared preferences
        _userModel.value = _userModel.value.copyWith(
          userName: userName,
          email: email,
          password: password,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(_userModel.value.toJson()));
      } else {
        print('Error: No document found for user email $email');
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.signOut();
      await prefs.clear();
      Get.offAllNamed(RouteName.signInScreen);
    } catch (e) {
      print('ERROR FROM SIGN OUT $e');
    }
  }

  void toggleObscure() {
    _isObsecure.value = !_isObsecure.value;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCurrentUser();
  }
}
