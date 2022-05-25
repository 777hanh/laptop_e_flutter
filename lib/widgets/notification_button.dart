import 'package:elaptop/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider? productProvider = Provider.of<ProductProvider>(context);
    int Index = productProvider.getNotificationIndex;
    return Index > 0
        ? Badge(
            position: BadgePosition(end: 3, top: 8),
            badgeContent: Text(
              productProvider.getNotificationIndex.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            badgeColor: Colors.red,
            child: IconButton(
              // icon: Icon(Icons.notifications_none, color: Colors.black),
              icon: Icon(Icons.shopping_bag_rounded, color: Colors.black),
              onPressed: () {
                print('heheheheheeheh');
              },
            ))
        : IconButton(
            icon: Icon(Icons.shopping_bag_rounded, color: Colors.black),
            onPressed: () {
              print('huhuhuhuhuhu');
            },
          );
  }
}
