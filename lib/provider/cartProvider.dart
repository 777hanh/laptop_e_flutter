import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  //get user id
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;

  Future<String> getUidAuth() async {
    String userId = await auth.currentUser!.uid.toString();
    uid = userId;
    return userId;
  }

  String get getUserId {
    return uid!;
  }
  //

//cart
  CartModel? cartProduct;
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');
  //add product to cart
  Future<void> addProductToCart(String idProduct, double quantity) async {
    final docRef = FirebaseFirestore.instance.collection('cart').doc();
    getUidAuth();
    print('logger2: ${docRef.id}');
    await docRef.set({
      'idProduct': idProduct,
      'quantity': quantity,
      // 'user': getUserId,
      'user': 'demouserid',
      'id': docRef.id.toString()
    });
  }

  //update product to cart
  Future<void> updateProductCart(String id, double quantity) async {
    getUidAuth();
    await cartCollection.doc(id).update({'quantity': quantity});
  }

  //delete product to cart
  Future<void> deleteProductCart(String id) async {
    getUidAuth();
    await cartCollection.doc(id).delete();
  }
}
