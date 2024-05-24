// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:restaurant_app/features/models/location_model.dart';

class OrderModel {
  String? orderId;
  String? uid;
  String email;
  String? userName;
  LocationModel? locationModel;
  int createdAt;
  int expiredAt;
  String status;
  OrderModel({
    required this.orderId,
    required this.uid,
    required this.email,
    required this.userName,
    required this.locationModel,
    required this.createdAt,
    required this.expiredAt,
    required this.status,
  });

  OrderModel copyWith({
    String? orderId,
    String? uid,
    String? email,
    String? userName,
    LocationModel? locationModel,
    int? createdAt,
    int? expiredAt,
    String? status,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      locationModel: locationModel ?? this.locationModel,
      createdAt: createdAt ?? this.createdAt,
      expiredAt: expiredAt ?? this.expiredAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'uid': uid,
      'email': email,
      'userName': userName,
      'locationModel': locationModel?.toJson(),
      'createdAt': createdAt,
      'expiredAt': expiredAt,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] as String,
      userName: map['userName'] != null ? map['userName'] as String : null,
      locationModel: map['locationModel'] != null
          ? LocationModel.fromJson(map['locationModel'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] as int,
      expiredAt: map['expiredAt'] as int,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, uid: $uid, email: $email, userName: $userName, locationModel: $locationModel, createdAt: $createdAt, expiredAt: $expiredAt, status: $status)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.uid == uid &&
        other.email == email &&
        other.userName == userName &&
        other.locationModel == locationModel &&
        other.createdAt == createdAt &&
        other.expiredAt == expiredAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        locationModel.hashCode ^
        createdAt.hashCode ^
        expiredAt.hashCode ^
        status.hashCode;
  }
}
