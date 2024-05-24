class CakeModel {
  final String label;
  final String imageUrl;
  final String price;
  final String description;
  CakeModel(
      {required this.imageUrl,
      required this.label,
      required this.price,
      required this.description});
  factory CakeModel.fromJson(Map<String, dynamic> json) => CakeModel(
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

  CakeModel copyWith(
      {String? imageUrl, String? label, String? price, String? description}) {
    return CakeModel(
        imageUrl: imageUrl ?? this.imageUrl,
        label: label ?? this.label,
        price: price ?? this.price,
        description: description ?? this.description);
  }
}
