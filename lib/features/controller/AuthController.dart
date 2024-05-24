import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';
import 'package:restaurant_app/features/models/location_model.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:restaurant_app/features/route/route_name.dart';
import 'package:restaurant_app/features/services/location_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  CollectionReference userCollection =
      FirebaseCollectionsConst.getUserCollection();

  final RxBool _isObsecure = true.obs;
  RxBool get isObsecure => _isObsecure;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final RxString _userLocation = ''.obs;
  RxString get userLocation => _userLocation;

  Future<bool> _isDuplicateEmail() async {
    final users = await userCollection.get();
    return users.docs
        .any((element) => element['email'] == emailController.text);
  }

  Future<void> signUpUser() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      _isLoading.value = true;

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      final currentLocation = await LocationService.getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation!.latitude, currentLocation.longitude);
      _userLocation.value = placemarks[0].street.toString();

      final location = LocationModel(
          address: _userLocation.value,
          longitude: currentLocation.longitude.toString(),
          latitude: currentLocation.latitude.toString());

      final userModel = UserModel(
          accessToken: credential.credential?.accessToken ?? '',
          token: credential.credential?.token.toString() ?? '0',
          createdAt: credential.user?.metadata.creationTime ?? DateTime.now(),
          id: '1',
          uid: credential.user?.uid ?? '',
          email: emailController.text,
          userName: userNameController.text,
          password: passwordController.text,
          location: location,
          productFavorite: []);

      await userCollection.doc(emailController.text).set(userModel.toJson());

      final userCopywith = userModel.copyWith(id: credential.user!.uid);

      final userEncode = jsonEncode(userCopywith.toJson());

      preferences.setString('user', userEncode);

      Get.showSnackbar(GetSnackBar(
        title: 'Daftar Berhasil',
        message: 'Pendaftaran Akun Berhasil',
        duration: Duration(seconds: 2),
      )).future.then((value) => Get.offAllNamed(RouteName.mainScreen));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.showSnackbar(GetSnackBar(
          title: 'Ups... Sepertinya Ada Masalah',
          message: 'Password Terlalu Lemah',
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(GetSnackBar(
          title: 'Ups... Sepertinya Ada Masalah',
          message: 'Daftar akun gagal, Email sudah Terdaftar',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e, st) {
      print('$e, $st');
      Get.showSnackbar(GetSnackBar(
        title: 'Ups... Sepertinya Ada Masalah',
        message: 'Daftar akun gagal, $e',
        duration: Duration(seconds: 2),
      ));
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signInUser() async {
    final preferences = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      final userDocs = await userCollection.doc(emailController.text).get();

      final userEncode = jsonEncode(userDocs.data());

      preferences.setString('user', userEncode);

      Get.offAllNamed(RouteName.mainScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.showSnackbar(GetSnackBar(
          title: 'Ups... Sepertinya Ada Masalah',
          message: 'Data Pengguna Tidak Ditemukan',
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == 'wrong-password') {
        Get.showSnackbar(GetSnackBar(
          title: 'Ups... Sepertinya Ada Masalah',
          message: 'Password Salah',
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == 'invalid-email') {
        Get.showSnackbar(GetSnackBar(
          title: 'Ups... Sepertinya Ada Masalah',
          message: 'Email Salah',
          duration: Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Ups... Sepertinya Ada Masalah',
          message: 'Kredensial Salah',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e, st) {
      print('$e, $st');
      Get.showSnackbar(GetSnackBar(
        title: 'Ups... Sepertinya Ada Masalah',
        message: 'Tidak bisa masuk, $e',
        duration: Duration(seconds: 2),
      ));
    }
  }

  void changeIsObsecure() {
    _isObsecure.value = !_isObsecure.value;
  }
}
