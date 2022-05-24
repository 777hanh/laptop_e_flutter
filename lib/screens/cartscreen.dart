import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/product.dart';
import 'package:elaptop/screens/checkout.dart';
import 'package:elaptop/screens/detail.dart';
import 'package:elaptop/widgets/mySingleCartproduct.dart';
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
    CartModel cart = Provider.of<CartModel>(context, listen: true);
    // cart.products!.map((e) => print('logger: $e'));
    // print('logger: ${cart.products!.length}');
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
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
//* Body
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * (710 / 812),
        child: ListView(
          children: cart.products!
              .map((item) => MySingleCartProduct(
                  idProduct: item['idProduct'], quantity: item['quantity']))
              .toList(),
        ),
      ),
    );
  }
}
