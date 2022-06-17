import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/user.dart';
import 'package:elaptop/screens/checkout.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/mySingleCartproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../widgets/myHistoryProduct.dart';

class HistoryScreen extends StatefulWidget {
  // final CartModel? cart;
  // Cart({this.cart});

  @override
  State<HistoryScreen> createState() => _CartState();
}

class _CartState extends State<HistoryScreen> {
  int count = 0;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    List<UserModel> snapShot =
        Provider.of<List<UserModel>>(context, listen: true);
    List<UserModel> user =
        snapShot.where((element) => element.userId == currentUser.uid).toList();
    // print('LOGGER_USERCURRENT: ${user[0].userId}');
    //filter list cart by current userId
    List<CartModel> lstCart =
        Provider.of<List<CartModel>>(context, listen: true)
            .where((element) =>
                (element.idUser == user[0].userId && element.isBuy == true))
            .toList();

    // cart.products!.map((e) => print('logger: $e'));
    // print('logger: ${lstCart[0].quantity}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('History',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato')),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: Home()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          // NotificationButton(),
        ],
      ),
//* Body
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: MediaQuery.of(context).size.height * (710 / 812),
        child: ListView(
          children: lstCart.length > 0
              ? lstCart
                  .map(
                    (item) => MySingleHistoryProduct(
                        cart: item, isInCartScreen: true),
                  )
                  .toList()
              : <Widget>[
                  Container(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Empty',
                          style: TextStyle(color: Colors.black12, fontSize: 60),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
        ),
      ),
    );
  }
}
