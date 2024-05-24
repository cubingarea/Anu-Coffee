import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';
import 'package:restaurant_app/features/models/location_model.dart';
import 'package:restaurant_app/features/models/product_model.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homeController extends GetxController {
  CollectionReference userCollection =
      FirebaseCollectionsConst.getUserCollection();

  CollectionReference productCollection =
      FirebaseCollectionsConst.getProductCollection();

  Future<void> getFavoriteProduct() async {
    try {
      final data = await productCollection
          .where("product_type", isEqualTo: "favorite")
          .get();
      for (final product in data.docs) {
        _favoriteProductList
            .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
      }
    } catch (err, st) {
      print('ERROR FROM GET FAVORITE PRODUCT $err $st');
    }
  }

  Future<void> getRecommendedProduct() async {
    try {
      final data = await productCollection
          .where("product_type", isEqualTo: "rekomendasi")
          .get();
      for (final product in data.docs) {
        _recommendedProductList
            .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
      }
    } catch (err) {
      print('ERROR FROM GET RECOMMENDED PRODUCT $err');
    }
  }

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

  final RxList<ProductModel> _favoriteProductList = <ProductModel>[].obs;
  RxList<ProductModel> get favoriteProductList => _favoriteProductList;

  final RxList<ProductModel> _recommendedProductList = <ProductModel>[].obs;
  RxList<ProductModel> get recommendedProductList => _recommendedProductList;

  final RxBool _isLoadingGetUser = false.obs;
  RxBool get isLoadingGetUser => _isLoadingGetUser;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final categoryList = [
    {
      'imageUrl': 'assets/icon/coffee.png',
      'label': 'Coffee',
      'route': '/coffee-screen',
    },
    {
      'imageUrl': 'assets/icon/boba.png',
      'label': 'Drink',
      'route': '/drink-screen',
    },
    {
      'imageUrl': 'assets/icon/juice.png',
      'label': 'Juice',
      'route': '/juice-screen',
    },
    {
      'imageUrl': 'assets/icon/cake.png',
      'label': 'Cake',
      'route': '/cake-screen',
    },
  ];

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

  Future<void> runGetProduct() async {
    _isLoading.value = true;
    try {
      await getFavoriteProduct();
      await getRecommendedProduct();
    } catch (err, st) {
      print('eror get data, $err $st');
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
    await getCurrentUser();
    await runGetProduct();
  }
}
