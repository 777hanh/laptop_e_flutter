import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';

class CheckOut extends StatefulWidget {
  final Product? product;
  final int? quantity;
  CheckOut({this.product, this.quantity});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Widget _SingleCartProduct() {
    return Container(
      height: 140,
      width: double.infinity,
      child: Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                height: 130,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    // image: AssetImage('assets/images/lap/${widget.product!.image}'),
                    image: NetworkImage('${widget.product!.image}'),
                  ),
                ),
              ),
              Container(
                height: 130,
                width: 200,
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product!.title, maxLines: 2),
                      Text(
                        // '${price}₫',
                        NumberFormat.currency(
                                locale: 'vi', symbol: 'đ', decimalDigits: 0)
                            .format(widget.product!.price),
                        style: TextStyle(
                          color: Color(0xff9b96d6),
                          fontFamily: 'Lato',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F7F9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Quentity'),
                                  Text('1'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
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
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
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
                        _SingleCartProduct(),
                        _SingleCartProduct(),
                        _SingleCartProduct(),
                        _SingleCartProduct(),
                        _SingleCartProduct(),
                        _SingleCartProduct(),
                        SizedBox(height: 20),
                        Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildBottomDetailPrice('Your Price', 19700000),
                              _buildBottomDetail('Discount', '0%'),
                              _buildBottomDetailPrice('Shipping', 60000),
                              _buildBottomDetailPrice('Total', 19760000),
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
