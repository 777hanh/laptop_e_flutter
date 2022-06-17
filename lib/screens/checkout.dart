import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/product.dart';
import 'package:elaptop/models/user.dart';
import 'package:elaptop/provider/cartProvider.dart';
import 'package:elaptop/screens/cartscreen.dart';
import 'package:elaptop/screens/thanksScreen.dart';
import 'package:elaptop/widgets/mySingleCartproduct.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  double discount = 10;
  double shipping = 60000;
  bool exit = false;
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double total(List<CartModel> cartlst) {
    double totalPrice = 0;
    List<Product> allProductsList =
        Provider.of<List<Product>>(context, listen: true).toList();
    for (int i = 0; i < cartlst.length; i++) {
      totalPrice += allProductsList
              .where((j) => j.id == cartlst[i].idProduct)
              .toList()[0]
              .price *
          cartlst[i].quantity!;
    }
    // print('logger: ${totalPrice}');
    return totalPrice;
  }

  completeBuy(List<CartModel> cartlst) {
    CartProvider? cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    for (int i = 0; i < cartlst.length; i++) {
      cartProvider.completeBuyProductCart(cartlst[i].id!);
      // print('${cartlst[i].id!}');
    }
  }

  Widget _buildBottomDetailPrice(String startName, double endName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(startName,
            style: TextStyle(
              fontSize: 18,
            )),
        Text(
          // '${price}₫',
          NumberFormat.currency(locale: 'vi', symbol: 'đ', decimalDigits: 0)
              .format(endName),
          style: TextStyle(
            color: Color(0xff9b96d6),
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomDetail(String startName, String endName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(startName,
            style: TextStyle(
              fontSize: 18,
            )),
        Text(
          endName,
          style: TextStyle(
            color: Color(0xff9b96d6),
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser;
    try {
      currentUser = FirebaseAuth.instance.currentUser;
    } catch (e) {
      FirebaseAuth.instance.currentUser!.reload();
      currentUser = FirebaseAuth.instance.currentUser;
    }
    List<UserModel> snapShot =
        Provider.of<List<UserModel>>(context, listen: true);
    List<UserModel> user = snapShot
        .where((element) => element.userId == currentUser!.uid)
        .toList();
    // print('LOGGER_USERCURRENT: ${user[0].userId}');
    //filter list cart by current userId
    List<CartModel> lstCart =
        Provider.of<List<CartModel>>(context, listen: true)
            .where((element) =>
                element.idUser == user[0].userId && element.isBuy == false)
            .toList();

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
            child: Text('Buy',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              completeBuy(lstCart);
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ThanksScreen()),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Check Out',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato')),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget.exit = !widget.exit;
            });
            Navigator.pop(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: Cart()),
            );
          },
          icon: Icon(
              widget.exit == false
                  ? Icons.arrow_back_ios
                  : Icons.arrow_forward_ios,
              color: Colors.black),
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
//* body
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(context).size.width * (10.677 / 375),
                  vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          children: lstCart
                              .map((item) => MySingleCartProduct(
                                    cart: item,
                                    isInCartScreen: false,
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildBottomDetailPrice(
                                'Your Price',
                                total(lstCart),
                              ),
                              _buildBottomDetail(
                                  'Discount', widget.discount.toString() + '%'),
                              _buildBottomDetailPrice(
                                  'Shipping', widget.shipping),
                              _buildBottomDetailPrice(
                                  'Total',
                                  total(lstCart) +
                                      widget.shipping -
                                      (total(lstCart) * widget.discount / 100)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
