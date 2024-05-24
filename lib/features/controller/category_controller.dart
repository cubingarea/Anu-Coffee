import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';
import 'package:restaurant_app/features/models/product_model.dart';

class CategoryController extends GetxController {
  CollectionReference productCollection =
      FirebaseCollectionsConst.getProductCollection();

  Future<void> getJuiceProduct() async {
    try {
      final data = await productCollection
          .where("product_category", isEqualTo: "juice")
          .get();
      for (final product in data.docs) {
        _CategoryProductList.add(
            ProductModel.fromJson(product.data() as Map<String, dynamic>));
      }
    } catch (err, st) {
      print('ERROR FROM GET JUICE PRODUCT LIST $err $st');
    }
  }

  Future<void> getDrinkProduct() async {
    try {
      final data = await productCollection
          .where("product_category", isEqualTo: "drink")
          .get();
      _CategoryProductList.assignAll(data.docs
          .map((product) =>
              ProductModel.fromJson(product.data() as Map<String, dynamic>))
          .toList());
    } catch (err, st) {
      print('ERROR FROM GET DRINK PRODUCT LIST $err $st');
    }
  }

  // Future<void> getJuiceProduct() async {
  //   try {
  //     final data = await productCollection
  //         .where("product_category", isEqualTo: "juice")
  //         .get();
  //     _CategoryProductList.assignAll(data.docs
  //         .map((product) =>
  //             ProductModel.fromJson(product.data() as Map<String, dynamic>))
  //         .toList());
  //   } catch (err, st) {
  //     print('ERROR FROM GET JUICE PRODUCT LIST $err $st');
  //   }
  // }

  // Future<void> getDrinkProduct() async {
  //   try {
  //     final data = await productCollection
  //         .where("product_category", isEqualTo: "drink")
  //         .get();
  //     for (final product in data.docs) {
  //       _CategoryProductList.add(
  //           ProductModel.fromJson(product.data() as Map<String, dynamic>));
  //     }
  //   } catch (err, st) {
  //     print('ERROR FROM GET DRINK PRODUCT LIST $err $st');
  //   }
  // }

  // Future<void> getCoffeeProduct() async {
  //   try {
  //     final data = await productCollection
  //         .where("product_category", isEqualTo: "coffee")
  //         .get();
  //     for (final product in data.docs) {
  //       _CategoryProductList.add(
  //           ProductModel.fromJson(product.data() as Map<String, dynamic>));
  //     }
  //   } catch (err, st) {
  //     print('ERROR FROM GET COFFEE PRODUCT LIST $err $st');
  //   }
  // }

  Future<void> getCoffeeProduct() async {
    try {
      final data = await productCollection
          .where("product_category", isEqualTo: "coffee")
          .get();
      _CategoryProductList.assignAll(data.docs
          .map((product) =>
              ProductModel.fromJson(product.data() as Map<String, dynamic>))
          .toList());
    } catch (err, st) {
      print('ERROR FROM GET COFFEE PRODUCT LIST $err $st');
    }
  }

  // Future<void> getCakeProduct() async {
  //   try {
  //     final data = await productCollection
  //         .where("product_category", isEqualTo: "cake")
  //         .get();
  //     for (final product in data.docs) {
  //       _CategoryProductList.add(
  //           ProductModel.fromJson(product.data() as Map<String, dynamic>));
  //     }
  //   } catch (err, st) {
  //     print('ERROR FROM GET CAKE PRODUCT LIST $err $st');
  //   }
  // }

  Future<void> getCakeProduct() async {
    try {
      final data = await productCollection
          .where("product_category", isEqualTo: "cake")
          .get();
      _CategoryProductList.assignAll(data.docs
          .map((product) =>
              ProductModel.fromJson(product.data() as Map<String, dynamic>))
          .toList());
    } catch (err, st) {
      print('ERROR FROM GET CAKE PRODUCT LIST $err $st');
    }
  }

  Future<void> getProductsByCategory(String category) async {
    try {
      final data = await productCollection
          .where("product_category", isEqualTo: category)
          .get();
      _CategoryProductList.assignAll(data.docs
          .map((product) =>
              ProductModel.fromJson(product.data() as Map<String, dynamic>))
          .toList());
    } catch (err, st) {
      print('ERROR FROM GET PRODUCT LIST $err $st');
    }
  }

  Future<void> runGetProduct() async {
    _isLoading.value = true;
    try {
      await getCoffeeProduct();
      await getDrinkProduct();
      await getCakeProduct();
      await getJuiceProduct();
    } catch (err, st) {
      print('eror get data, $err $st');
    } finally {
      _isLoading.value = false;
    }
  }

  final RxList<ProductModel> _CategoryProductList = <ProductModel>[].obs;
  RxList<ProductModel> get CategoryProductList => _CategoryProductList;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _isLoading.value = true;
    try {
      // await getCoffeeProduct();
      // await getDrinkProduct();
      // await getCakeProduct();
      // await getJuiceProduct();
      // await runGetProduct();
      // await getProductsByCategory("coffee");
    } catch (err, st) {
      print('eror get data, $err $st');
    } finally {
      _isLoading.value = false;
    }
  }
}
