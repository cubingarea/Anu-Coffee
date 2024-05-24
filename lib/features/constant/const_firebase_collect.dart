import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollectionsConst {
  static CollectionReference getUserCollection() {
    return FirebaseFirestore.instance.collection('users');
  }

  static CollectionReference getProductCollection() {
    return FirebaseFirestore.instance.collection("products");
  }

  static CollectionReference getOrderCollection() {
    return FirebaseFirestore.instance.collection("orders");
  }
}
