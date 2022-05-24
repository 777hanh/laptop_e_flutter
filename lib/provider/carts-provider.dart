import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/cart.dart';
import 'package:flutter/material.dart';

class Cart_Provider {
  List<CartModel> cartDataList = [];
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Stream<CartModel> get allCart {
    return cartCollection
        .where('user', isEqualTo: 'demouserid')
        .snapshots()
        .map((snapshot) {
      return _CartFromSnapShot(snapshot);
    });
  }

  CartModel _CartFromSnapShot(QuerySnapshot snapshot) {
    CartModel? cart;
    snapshot.docs.asMap().forEach((index, element) {
      cart = CartModel(
        id: element.id,
        idUser: element['user'],
        products: element['products'],
      );
    });
    return cart!;
  }
}
