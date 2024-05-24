class DrinkModel {
  final String label;
  final String imageUrl;
  final String price;
  final String description;
  DrinkModel(
      {required this.imageUrl,
      required this.label,
      required this.price,
      required this.description});
  factory DrinkModel.fromJson(Map<String, dynamic> json) => DrinkModel(
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

  DrinkModel copyWith(
      {String? imageUrl, String? label, String? price, String? description}) {
    return DrinkModel(
        imageUrl: imageUrl ?? this.imageUrl,
        label: label ?? this.label,
        price: price ?? this.price,
        description: description ?? this.description);
  }
}
