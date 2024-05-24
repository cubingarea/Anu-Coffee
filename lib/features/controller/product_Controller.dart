import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';
import 'package:restaurant_app/features/models/product_model.dart';

class ProductController extends GetxController {
  // CollectionReference userCollection =
  //     FirebaseCollectionsConst.getUserCollection();

  CollectionReference productCollection =
      FirebaseCollectionsConst.getProductCollection();

  Future<void> getProduct() async {
    try {
      final data = await productCollection.get();
      for (final product in data.docs) {
        _ProductList.add(
            ProductModel.fromJson(product.data() as Map<String, dynamic>));
      }
    } catch (err, st) {
      print('ERROR FROM GET PRODUCT LIST $err $st');
    }
  }

  // Rx<UserModel> _userModel = UserModel(
  //     id: '',
  //     uid: '',
  //     accessToken: '',
  //     token: '',
  //     email: '',
  //     userName: '',
  //     password: '',
  //     location: LocationModel(address: '', longitude: '', latitude: ''),
  //     createdAt: DateTime.now(),
  //     productFavorite: []).obs;

  // Rx<UserModel> get userModel => _userModel;

  Future<void> runGetProduct() async {
    _isLoading.value = true;
    try {
      await getProduct();
    } catch (err, st) {
      print('eror get data, $err $st');
    } finally {
      _isLoading.value = false;
    }
  }

  final RxList<ProductModel> _ProductList = <ProductModel>[].obs;
  RxList<ProductModel> get ProductList => _ProductList;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  void incrementItem(int index) {
    final ProductModel selectedItem = ProductList[index];
    selectedItem.quantity.value++; // Menambahkan 1 ke quantity
  }

  void decrementItem(int index) {
    final ProductModel selectedItem = ProductList[index];
    if (selectedItem.quantity.value > 0) {
      selectedItem
          .quantity.value--; // Mengurangi 1 dari quantity, tidak kurang dari 0
    }
  }

  RxInt totalPrice() {
    int total = 0;
    for (final cartItem in ProductList) {
      total += int.parse(cartItem.price) * cartItem.quantity.value;
    }
    return total.obs;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await runGetProduct();
  }
}
