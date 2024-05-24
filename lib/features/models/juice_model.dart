class JuiceModel {
  final String label;
  final String imageUrl;
  final String price;
  final String description;
  JuiceModel(
      {required this.imageUrl,
      required this.label,
      required this.price,
      required this.description});
  factory JuiceModel.fromJson(Map<String, dynamic> json) => JuiceModel(
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

  JuiceModel copyWith(
      {String? imageUrl, String? label, String? price, String? description}) {
    return JuiceModel(
        imageUrl: imageUrl ?? this.imageUrl,
        label: label ?? this.label,
        price: price ?? this.price,
        description: description ?? this.description);
  }
}
