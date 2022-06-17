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
    User currentUser = FirebaseAuth.instance.currentUser!;
    List<UserModel> snapShot =
        Provider.of<List<UserModel>>(context, listen: true);
    List<UserModel> user =
        snapShot.where((element) => element.userId == currentUser.uid).toList();
    List<CartModel> lstCart =
        Provider.of<List<CartModel>>(context, listen: true)
            .where((element) =>
                element.idUser == user[0].userId && element.isBuy == false)
            .toList();
    ProductProvider? productProvider = Provider.of<ProductProvider>(context);
    // int Index = productProvider.getNotificationIndex;
    int Index = lstCart.length;
    return Index > 0
        ? Badge(
            position: BadgePosition(end: 3, top: 8),
            badgeContent: Text(
              // productProvider.getNotificationIndex.toString(),
              Index.toString(),
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
                productProvider.resetNotification();
              },
            ))
        : IconButton(
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
}
