class FavoriteModel {
  final String imageUrl;
  final String menuTitle;
  final String price;
  final bool isFavorite;
  FavoriteModel({
    required this.imageUrl,
    required this.menuTitle,
    required this.price,
    required this.isFavorite,
  });

  FavoriteModel copyWith({
    String? imageUrl,
    String? menuTitle,
    String? price,
    bool? isFavorite,
  }) {
    return FavoriteModel(
        imageUrl: imageUrl ?? this.imageUrl,
        menuTitle: menuTitle ?? this.menuTitle,
        price: price ?? this.price,
        isFavorite: isFavorite ?? this.isFavorite);
  }
}
