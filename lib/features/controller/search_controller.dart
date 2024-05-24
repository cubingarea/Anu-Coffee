import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';

class searchFeatureController extends GetxController {
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  RxList<Map<String, dynamic>> _searchProducts = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> get searchProducts => _searchProducts;

  CollectionReference productCollection =
      FirebaseCollectionsConst.getProductCollection();

  Future<void> searchProduct(String query) async {
    _searchProducts.clear();
    try {
      _isLoading.value = true;

      final newQuery = query
          .split(" ")
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(" ");

      final data = await productCollection
          .where("product_name", isGreaterThanOrEqualTo: newQuery)
          .where("product_name", isLessThan: "${newQuery}z")
          .get();

      for (final product in data.docs) {
        _searchProducts.add(product.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error Search Product $e");
    } finally {
      _isLoading.value = false;
    }
  }
}
