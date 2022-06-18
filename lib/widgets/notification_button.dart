import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/provider/productProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/user.dart';
import '../screens/cartscreen.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('cart').snapshots();
    // int Index = lstCart.length;
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        List<CartModel>? snapShot;
        snapShot = snapshot.data!.docs
            .map((i) => CartModel(
                  id: i['id'],
                  idUser: i['user'],
                  idProduct: i['idProduct'],
                  quantity: i['quantity'].toDouble(),
                  isBuy: i['isBuy'],
                ))
            .toList();
        snapShot = snapShot
            .where((i) => i.idUser == currentUser?.uid && i.isBuy == false)
            .toList();

        if (snapShot.length > 0) {
          return Badge(
            position: BadgePosition(end: 3, top: 8),
            badgeContent: Text(
              // productProvider.getNotificationIndex.toString(),
              snapShot.length.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            badgeColor: Colors.red,
            child: IconButton(
              icon: Icon(Icons.shopping_bag_rounded, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: Cart()));
                // productProvider.resetNotification();
              },
            ),
          );
        } else {
          return IconButton(
            icon: Icon(Icons.shopping_bag_rounded, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: Cart()));
            },
          );
        }
      },
    );
  }
}
