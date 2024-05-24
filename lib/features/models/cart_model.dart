import 'package:get/get.dart';

class CartModel {
  final String imageUrl;
  final String menuTitle;
  final String price;
  final RxInt quantity;

  CartModel({
    required this.imageUrl,
    required this.menuTitle,
    required this.price,
    int quantity = 0,
  }) : quantity = quantity.obs;
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        imageUrl: json['imageUrl'],
        menuTitle: json['menuTitle'],
        price: json['price'],
        quantity: json['quantity'],
      );
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'menuTitle': menuTitle,
      'price': price,
      'quantity': quantity,
    };
  }

  CartModelcopyWith({
    String? imageUrl,
    String? menuTitle,
    String? price,
  }) {
    return CartModel(
      imageUrl: imageUrl ?? this.imageUrl,
      menuTitle: menuTitle ?? this.menuTitle,
      price: price ?? this.price,
    );
  }
}
