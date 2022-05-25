import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/product.dart';
import 'package:elaptop/widgets/mySingleCartproduct.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
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
    double discount = 10;
    double shipping = 60000;
    List<CartModel> lstCart =
        Provider.of<List<CartModel>>(context, listen: true);

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
            onPressed: () {},
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
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(height: 20),
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
                                  'Discount', discount.toString() + '%'),
                              _buildBottomDetailPrice('Shipping', shipping),
                              _buildBottomDetailPrice(
                                  'Total',
                                  total(lstCart) +
                                      shipping -
                                      (total(lstCart) * discount / 100)),
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
