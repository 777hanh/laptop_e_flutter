import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/cart.dart';

class Cart_Provider {
  List<CartModel> cartDataList = [];
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Stream<List<CartModel>> get allCart {
    return cartCollection
        // .where('user', isEqualTo: 'demouserid')
        // .where('user', isEqualTo: getUserId.toString())
        .snapshots()
        .map((snapshot) {
      return _ListAllCartFromSnapShot(snapshot);
    });
  }

  List<CartModel> _ListAllCartFromSnapShot(QuerySnapshot snapshot) {
    List<CartModel> newList = [];
    snapshot.docs.asMap().forEach((index, element) {
      CartModel cart = CartModel(
        id: element['id'],
        idUser: element['user'],
        idProduct: element['idProduct'],
        quantity: element['quantity'].toDouble(),
        isBuy: element['isBuy'],
        // dateBuy: element['dateBuy'],
        // timeBuy: element['timeBuy'],
      );
      newList.add(cart);
    });
    return newList;
  }
}
