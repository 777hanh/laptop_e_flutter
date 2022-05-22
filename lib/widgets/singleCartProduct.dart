import 'package:elaptop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleCartProduct extends StatefulWidget {
  final Product? product;
  late final int? quantity;
  SingleCartProduct({this.product, this.quantity});
  @override
  State<SingleCartProduct> createState() => _nameState();
}

class _nameState extends State<SingleCartProduct> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
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
                    fit: BoxFit.fitWidth,
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
                      Text(widget.product!.title.toString()),
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
                        width: double.infinity,
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
                              width: 120,
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (widget.quantity! > 1) {
                                            widget.quantity = widget.quantity! + 1;
                                          }
                                        });
                                      }),
                                  Text(
                                    widget.quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        widget.quantity = widget.quantity! + 1;
                                      });
                                    },
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
              ),
            ],
          ),
        ],
      )),
    );
  }
}
