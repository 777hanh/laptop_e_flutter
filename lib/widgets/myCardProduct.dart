import 'package:elaptop/models/product.dart';
import 'package:elaptop/screens/detail.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:page_transition/page_transition.dart';

class MyCardProduct extends StatelessWidget {
  final String? id;
  final String? name;
  final String? image;
  final double? price;
  Product product;
  MyCardProduct({this.name, this.price, this.image, this.id, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.bottomCenter,
                    child: Detail(product),
                  ));
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                height: 250,
                width: 180,
                // color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 130,
                      width: 160,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            // image: AssetImage("assets/images/lap/${image}"),
                            image: NetworkImage("${image}"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.center),
                      ),
                    ),
    //*inforOfProduct
                    Text(
                      // '${price}₫',
                      NumberFormat.currency(
                              locale: 'vi', symbol: 'đ', decimalDigits: 0)
                          .format(price),
                      style: TextStyle(
                        color: Color(0xff9b96d6),
                        fontFamily: 'Lato',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        name.toString(),
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
