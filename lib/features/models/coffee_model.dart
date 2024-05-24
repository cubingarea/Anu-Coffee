class CoffeeModel {
  final String label;
  final String imageUrl;
  final String price;
  final String description;
  CoffeeModel(
      {required this.imageUrl,
      required this.label,
      required this.price,
      required this.description});
  factory CoffeeModel.fromJson(Map<String, dynamic> json) => CoffeeModel(
      imageUrl: json['imageUrl'],
      label: json['label'],
      price: json['price'],
      description: json['description']);
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'label': label,
      'price': price,
      'description': description
    };
  }

  CoffeeModel copyWith(
      {String? imageUrl, String? label, String? price, String? description}) {
    return CoffeeModel(
        imageUrl: imageUrl ?? this.imageUrl,
        label: label ?? this.label,
        price: price ?? this.price,
        description: description ?? this.description);
  }
}
