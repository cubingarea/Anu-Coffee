import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';
import 'package:restaurant_app/features/models/favorite_model.dart';
import 'package:restaurant_app/features/models/product_model.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController {
  final RxBool _isGrid = false.obs;
  RxBool get isGrid => _isGrid;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final RxList<ProductModel> _favoriteProduct = <ProductModel>[].obs;
  RxList<ProductModel> get favoriteproduct => _favoriteProduct;

  CollectionReference userCollection =
      FirebaseCollectionsConst.getUserCollection();
  CollectionReference productCollection =
      FirebaseCollectionsConst.getProductCollection();

  UserModel? userModel;

  Future<void> getFavoriteProduct() async {
    _favoriteProduct.clear();
    _isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final userPrefs = jsonDecode(prefs.getString("user")!);
      final user = await userCollection.doc(userPrefs["email"]).get();
      final userData = user.data() as Map<String, dynamic>;
      List<String> favList = List<String>.from(userData["productFavorite"]);

      final querySnapshot = await productCollection
          .where(FieldPath.documentId, whereIn: favList)
          .get();
      for (final product in querySnapshot.docs) {
        _favoriteProduct
            .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
      }
    } catch (err) {
      print('error from get favorite data $err');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<UserModel> getCurrentUserl() async {
    final prefs = await SharedPreferences.getInstance();
    final userPrefs = jsonDecode(prefs.getString("user")!);
    final user = await userCollection.doc(userPrefs["email"]).get();
    userModel = UserModel.fromJson(user.data() as Map<String, dynamic>);
    return userModel!;
  }

  void toggleIsGrid() {
    _isGrid.toggle();
  }

  Future<void> removeFromFav(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userPrefs = jsonDecode(prefs.getString("user")!);
      final user = await userCollection.doc(userPrefs["email"]).get();
      // final userData = user.data() as Map<String, dynamic>;
      List<String> favList = List.from(user["productFavorite"]);
      favList.remove(productId);
      await userCollection
          .doc(user["email"])
          .update({"productFavorite": favList});
      await getCurrentUserl();
      await getFavoriteProduct();
    } catch (err) {
      print('error from remove fav');
    }
  }
  // void addToFav(int index) {
  // late String message;
  // final favorite = favoriteList[index].copyWith(
  //   isFavorite: !favoriteList[index].isFavorite,
  // );
  // favoriteList[index] = favorite;
  // if (favorite.isFavorite) {
  //   message = '${favorite.menuTitle} Berhasil Ditambahkan ke Favorit';
  // } else {
  //   message = '${favorite.menuTitle} Dihapus dari Favorit';
  // }
  // Get.showSnackbar(
  //   GetSnackBar(
  //     message: message,
  //     duration: Duration(seconds: 2),
  //   ),
  // );
  // }

  final RxList<FavoriteModel> favoriteList = [
    FavoriteModel(
        imageUrl: 'assets/img/espresso2.jpg',
        menuTitle: 'Espresso',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/brownies.jpg',
        menuTitle: 'Brownies Cake',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/chocolate2.jpg',
        menuTitle: 'Chocolate',
        price: '25000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/rainbow.jpg',
        menuTitle: 'Rainbow Cake',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/espresso2.jpg',
        menuTitle: 'Espresso',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/americano.jpg',
        menuTitle: 'Americano',
        price: '25000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/vanillalatte.jpg',
        menuTitle: 'Vanilla Latte',
        price: '25000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/espresso.jpg',
        menuTitle: 'Cappucino',
        price: '25000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/matcha2.jpg',
        menuTitle: 'Ice Matcha',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/chocolate2.jpg',
        menuTitle: 'Chocolate',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/thaitea.jpg',
        menuTitle: 'Thai Tea',
        price: '15000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/milktea.jpg',
        menuTitle: 'Milk Tea',
        price: '15000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/orange.jpg',
        menuTitle: 'Orange Juice',
        price: '15000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/apple.jpg',
        menuTitle: 'Apple Juice',
        price: '15000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/mango.jpg',
        menuTitle: 'Mango Juice',
        price: '15000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/berry.jpg',
        menuTitle: 'Berry Beri Juice',
        price: '15000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/rainbow.jpg',
        menuTitle: 'Rainbow cake',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/brownies.jpg',
        menuTitle: 'Brownies',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/redvelvet.jpg',
        menuTitle: 'Red Velvet',
        price: '20000',
        isFavorite: false),
    FavoriteModel(
        imageUrl: 'assets/img/lemoncake.jpg',
        menuTitle: 'Lemon Drizzle',
        price: '20000',
        isFavorite: false),
  ].obs;

  @override
  void onInit() async {
    _isLoading.value = true;
    // TODO: implement onInit
    super.onInit();
    await getCurrentUserl();
    await getFavoriteProduct();
    _isLoading.value = false;
  }
}
