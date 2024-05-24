import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';
import 'package:restaurant_app/features/controller/favorite_controller.dart';
import 'package:restaurant_app/features/models/product_model.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailController extends GetxController {
  final RxInt _itemCount = 1.obs;
  RxInt get itemCount => _itemCount;

  final FavoriteController _favoriteController = Get.find();

  String _productId = '0';
  CollectionReference productCollection =
      FirebaseCollectionsConst.getProductCollection();
  CollectionReference userCollection =
      FirebaseCollectionsConst.getUserCollection();

  Rx<ProductModel> _productModel = ProductModel(
          price: '0',
          productId: '',
          productImage: '',
          productName: '',
          productType: ProductType.other,
          productDescription: '')
      .obs;
  Rx<ProductModel> get productModel => _productModel;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  final RxBool _isLoadingFavorite = false.obs;
  RxBool get isLoadingFavorite => _isLoadingFavorite;

  UserModel? userModel;

  RxInt totalPrice(ProductModel productModel) {
    return (_itemCount * int.parse(productModel.price)).toInt().obs;
  }

  void incrementItem() {
    _itemCount.value++;
  }

  void decrementItem() {
    if (_itemCount.value > 1) {
      _itemCount.value--;
    }
  }

  Future<void> _updateDataFavorite() async {
    await _favoriteController.getFavoriteProduct();
    await _favoriteController.getCurrentUserl();
  }

  Future<void> addToFav(
      String productId, Map<String, dynamic> user, String userEmail) async {
    try {
      List<String> favList = List.from(user["productFavorite"]);
      favList.add(productId);
      await userCollection.doc(userEmail).update({"productFavorite": favList});
      await _updateDataFavorite();
    } catch (err) {
      print('error from add fav');
    }
  }

  Future<void> removeFromFav(
      String productId, Map<String, dynamic> user, String userEmail) async {
    try {
      List<String> favList = List.from(user["productFavorite"]);
      favList.remove(productId);
      await userCollection.doc(userEmail).update({"productFavorite": favList});
    } catch (err) {
      print('error from remove fav');
    }
  }

  void handleFavorite(String productId) async {
    _isLoadingFavorite.value = true;
    final prefs = await SharedPreferences.getInstance();
    final userPrefs = jsonDecode(prefs.getString("user")!);
    final user = await userCollection.doc(userPrefs["email"]).get();
    final userData = user.data() as Map<String, dynamic>;
    List<String> favList = List.from(userData["productFavorite"]);
    if (favList.contains(productId)) {
      await removeFromFav(productId, userData, userPrefs["email"]);
    } else {
      await addToFav(productId, userData, userPrefs["email"]);
    }
    await getCurrentUser();
    await _updateDataFavorite();
    _isLoadingFavorite.value = false;
  }

  Future<UserModel> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userPrefs = jsonDecode(prefs.getString("user")!);
    final user = await userCollection.doc(userPrefs["email"]).get();
    final userData = user.data() as Map<String, dynamic>;
    userModel = UserModel.fromJson(userData);
    return userModel!;
  }

  Future<void> getDetailProduct() async {
    _isLoading.value = true;
    try {
      final response = await productCollection.doc(_productId).get();
      _productModel.value =
          ProductModel.fromJson(response.data() as Map<String, dynamic>);
    } catch (err) {
      print('ERROR FORM GET DATA $err');
    } finally {
      _isLoading.value = false;
    }
  }

  void runGetDetailProduct() async {
    final args = Get.arguments as Map<String, dynamic>;
    await getCurrentUser();
    if (args.isNotEmpty) {
      if (args.containsKey("product_id")) {
        _productId = args["product_id"];
      }
      await getDetailProduct();
    }
  }

  @override
  void onInit() {
    _isLoading.value = true;
    runGetDetailProduct();
    // TODO: implement onInit
    super.onInit();
  }
}
