import 'package:restaurant_app/features/models/location_model.dart';

class UserModel {
  final String id;
  final String uid;
  final String accessToken;
  final String token;
  final String email;
  final String userName;
  final String password;
  final LocationModel location;
  final DateTime createdAt;
  final List<dynamic> productFavorite;

  UserModel({
    required this.id,
    required this.uid,
    required this.accessToken,
    required this.token,
    required this.email,
    required this.userName,
    required this.password,
    required this.location,
    required this.createdAt,
    required this.productFavorite,
  });

  UserModel copyWith({
    String? id,
    String? uid,
    String? accessToken,
    String? token,
    String? email,
    String? userName,
    String? password,
    LocationModel? location,
    DateTime? createdAt,
    List<dynamic>? productFavorite,
  }) {
    return UserModel(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        accessToken: accessToken ?? this.accessToken,
        token: token ?? this.token,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        location: location ?? this.location,
        createdAt: createdAt ?? this.createdAt,
        productFavorite: productFavorite ?? this.productFavorite);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        uid: json['uid'],
        accessToken: json['accessToken'],
        token: json['token'],
        email: json['email'],
        userName: json['userName'],
        password: json['password'],
        location: LocationModel.fromJson(json['location']),
        createdAt: DateTime.parse(json['createdAt']),
        productFavorite: json['productFavorite']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'accessToken': accessToken,
      'token': token,
      'email': email,
      'userName': userName,
      'password': password,
      'location': location.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'productFavorite': productFavorite,
    };
  }
}
