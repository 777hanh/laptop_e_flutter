import 'package:elaptop/models/product.dart';
import 'package:elaptop/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MySingleCartProduct extends StatelessWidget {
  // const SingleCartProduct({Key? key}) : super(key: key);
  String idProduct;
  dynamic quantity;
  MySingleCartProduct({required this.idProduct, required this.quantity});

  @override
  Widget build(BuildContext context) {
    //get product by id
    List<Product> _product = Provider.of<List<Product>>(context, listen: true)
        .where((element) => element.id == idProduct)
        .toList();
    return Container(
      height: 140,
      width: double.infinity,
      child: Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.bottomCenter,
                    child: Detail(_product[0]),
                  ));
                },
                child: Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('${_product[0].image}'),
                    ),
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
                      Text(
                        _product[0].title,
                        maxLines: 2,
                      ),
                      Text(
                        // '${price}₫',
                        NumberFormat.currency(
                                locale: 'vi', symbol: 'đ', decimalDigits: 0)
                            .format(_product[0].price),
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
                                      onTap: () {}),
                                  Text(
                                    quantity.toString(),
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
                                    onTap: () {},
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
