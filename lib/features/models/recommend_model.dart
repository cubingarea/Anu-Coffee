class ProductModel2 {
  final String label;
  final String imageUrl;
  final String price;
  final String description;
  ProductModel2(
      {required this.imageUrl,
      required this.label,
      required this.price,
      required this.description});
  factory ProductModel2.fromJson(Map<String, dynamic> json) => ProductModel2(
        imageUrl: json['imageUrl'],
        label: json['label'],
        price: json['price'],
        description: json['description'],
      );
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'label': label,
      'price': price,
      'description': description,
    };
  }

  ProductModel2 copyWith({
    String? imageUrl,
    String? label,
    String? price,
    String? description,
  }) {
    return ProductModel2(
        imageUrl: imageUrl ?? this.imageUrl,
        label: label ?? this.label,
        price: price ?? this.price,
        description: description ?? this.description);
  }
}
