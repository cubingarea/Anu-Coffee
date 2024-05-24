import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/cart/screen/cart_screen.dart';
import 'package:restaurant_app/features/constant/const_color.dart';
import 'package:restaurant_app/features/favorite/screen/favorite_screen.dart';
import 'package:restaurant_app/features/home/screen/home_screen.dart';
import 'package:restaurant_app/features/profile/screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  final RxInt _indexBottomNavBar = 0.obs;
  RxInt get indexBottomNavBar => _indexBottomNavBar;

  void changeIndex(int val) {
    _indexBottomNavBar.value = val;
  }

  final List<BottomNavigationBarItem> ListBottomNav = [
    BottomNavigationBarItem(
      backgroundColor: CardColor,
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      backgroundColor: CardColor,
      label: 'Favorite',
      icon: Icon(Icons.favorite),
    ),
    BottomNavigationBarItem(
      backgroundColor: CardColor,
      label: 'Keranjang',
      icon: Icon(Icons.shopping_bag),
    ),
    BottomNavigationBarItem(
      backgroundColor: CardColor,
      label: 'Profile',
      icon: Icon(Icons.person),
    ),
  ];
  final List<Widget> bodyMain = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  Future<void> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    print('USER FROM PREFS $user');
    FirebaseAuth.instance.currentUser;
  }

  @override
  void onInit() async {
    await getCurrentUser();
    super.onInit();
  }
}
