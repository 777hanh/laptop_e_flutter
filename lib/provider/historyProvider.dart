import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HistoryProvider with ChangeNotifier {
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
  final CollectionReference historyCollection =
      FirebaseFirestore.instance.collection('history');
  //add product to cart
  Future<void> addProductToCart(String idProduct, double quantity) async {
    DateTime now = new DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);
    final docRef = FirebaseFirestore.instance.collection('history').doc();
    getUidAuth();
    // print('logger2: ${docRef.id}');
    await docRef.set({
      'idProduct': idProduct,
      'quantity': quantity,
      'user': getUserId,
      'date': formattedDate,
      'time': formattedTime,
      'id': docRef.id.toString()
    });
  }

  //delete product to history
  Future<void> deleteProductHistory(String id) async {
    getUidAuth();
    await historyCollection.doc(id).delete();
  }
}
