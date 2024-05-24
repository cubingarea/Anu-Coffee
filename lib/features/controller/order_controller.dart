import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/constant/const_firebase_collect.dart';
import 'package:restaurant_app/features/models/location_model.dart';
import 'package:restaurant_app/features/models/order_model.dart';
import 'package:restaurant_app/features/models/user_model.dart';
import 'package:restaurant_app/features/services/notif_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  CollectionReference userCollection =
      FirebaseCollectionsConst.getUserCollection();

  CollectionReference orderCollection =
      FirebaseCollectionsConst.getOrderCollection();

  final Rx<OrderModel> _orderModel = OrderModel(
          uid: '',
          email: '',
          createdAt: 0,
          expiredAt: 0,
          status: '',
          userName: '',
          locationModel:
              LocationModel(address: '', longitude: '', latitude: ''),
          orderId: '')
      .obs;

  final RxBool _isLoadingGetUser = false.obs;
  RxBool get isLoadingGetUser => _isLoadingGetUser;

  Rx<UserModel> _userModel = UserModel(
      id: '',
      uid: '',
      accessToken: '',
      token: '',
      email: '',
      userName: '',
      password: '',
      location: LocationModel(address: '', longitude: '', latitude: ''),
      createdAt: DateTime.now(),
      productFavorite: []).obs;

  Rx<UserModel> get userModel => _userModel;

  Future<UserModel> getCurrentUser() async {
    _isLoadingGetUser.value = true;
    try {
      final preferences = await SharedPreferences.getInstance();
      final user = preferences.getString('user');
      final userDecode = jsonDecode(user!);
      _userModel.value = UserModel.fromJson(userDecode);
      return _userModel.value;
    } catch (err) {
      print('ERROR GET CURRENT USER $err');
      return _userModel.value;
    } finally {
      _isLoadingGetUser.value = false;
    }
  }

  Future<void> checkStatusOrder() async {
    try {
      final user = await getCurrentUser();
      final allDataOrder = await orderCollection
          .where("email", isEqualTo: user.email)
          .where("status", isEqualTo: "Order Successful")
          .get();
      for (final dataOrder in allDataOrder.docs) {
        final data = dataOrder.data() as Map<String, dynamic>;
        final dateNow = DateTime.now();
        final expiredAt =
            DateTime.fromMillisecondsSinceEpoch(data["expiredAt"]);
        if (dateNow.isAfter(expiredAt)) {
          dataOrder.reference.update({"status": "fail"});
        }
      }
    } catch (e) {
      print("ERROR FROM CHECK STATUS ORDER $e");
    }
  }

  Future<void> createOrder() async {
    try {
      final user = await getCurrentUser();
      _orderModel.value = OrderModel(
          uid: user.uid,
          email: user.email,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          expiredAt: DateTime.now().millisecondsSinceEpoch + (15 * 60 * 1000),
          status: "Order Successful",
          userName: user.userName,
          locationModel: _userModel.value.location,
          orderId: null);
      DocumentReference orderRef =
          await orderCollection.add(_orderModel.value.toMap());
      _orderModel.value = _orderModel.value.copyWith(orderId: orderRef.id);
      await orderRef.update({'orderId': _orderModel.value.orderId});
      orderCollection.add(_orderModel.value.toMap());
      NotificationService.showNotif(
        'Pesanan berhasil dibuat!',
        'Silahkan menunggu pesanan anda',
      );
    } catch (e, st) {
      print('ERROR FROM CREATE ORDER $e $st');
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    getCurrentUser();
    await checkStatusOrder();
    super.onInit();
  }
}
