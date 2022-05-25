import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/product.dart';
import 'package:elaptop/provider/authProvider.dart';
import 'package:elaptop/provider/cartProvider.dart';
import 'package:elaptop/provider/productProvider.dart';
import 'package:elaptop/provider/products-provider.dart';
import 'package:elaptop/screens/checkout.dart';
import 'package:elaptop/screens/detail.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/mySingleCartproduct.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  // final CartModel? cart;
  // Cart({this.cart});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int count = 0;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // CartProvider? cartProvider = Provider.of<CartProvider>(context);
    // ProductProvider productProvider = Provider.of<ProductProvider>(context);
    // print('LOGGER 1: ${authProvider.getUserId}');
    List<CartModel> lstCart =
        Provider.of<List<CartModel>>(context, listen: true).toList();

    // cart.products!.map((e) => print('logger: $e'));
    // print('logger: ${lstCart}');
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        color: Color.fromARGB(61, 147, 185, 250),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: RaisedButton(
            color: Colors.blueAccent,
            child: Text('Continous',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              // cartProvider.getUidAuth();
              // print('${cartProvider.getUserId}');
              // cartProvider.addProductToCart('kqKUEDDfNzrfxQijOhdc', 1);
              // productProvider.addNotification("Notification");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => CheckOut(),
                ),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato')),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
//* Body
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * (710 / 812),
        child: ListView(
          children: lstCart
              .map((item) =>
                  MySingleCartProduct(cart: item, isInCartScreen: true))
              .toList(),
        ),
      ),
    );
  }
}
