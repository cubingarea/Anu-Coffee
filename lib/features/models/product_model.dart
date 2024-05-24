import 'package:get/get.dart';

enum ProductType { rekomendasi, favorite, other }

class ProductModel {
  final String productName;
  final String price;
  final String productImage;
  final String productId;
  final String productDescription;
  final ProductType productType;
  final RxInt quantity;

  ProductModel({
    required this.price,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.productType,
    int quantity = 0,
  }) : quantity = quantity.obs;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      price: json["price"],
      productId: json["product_id"],
      productImage: json["product_image"],
      productName: json["product_name"],
      productDescription: json["product_description"],
      quantity: json['quantity'] ?? 0,
      productType: ProductType.values.firstWhere(
          (element) => element.toString() == json["product_type"],
          orElse: () => ProductType.favorite),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "product_id": productId,
      "product_name": productName,
      "product_image": productImage,
      "product_description": productDescription,
      "quantity": quantity,
      "product_type": productType.toString(),
    };
  }
}
