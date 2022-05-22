import 'package:elaptop/models/product.dart';
import 'package:elaptop/screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  final Product? product;
  final int? quantity;
  Cart({this.product, this.quantity});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int count = 0;
  @override
  initState() {
    count = widget.quantity!;
    super.initState();
  }

  Widget _SingleCartProduct(Product product, quantity) {
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
                    // image: AssetImage('assets/images/lap/${product.image}'),
                    image: NetworkImage('${product.image}'),
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
                      Text(product.title, maxLines: 2,),
                      Text(
                        // '${price}₫',
                        NumberFormat.currency(
                                locale: 'vi', symbol: 'đ', decimalDigits: 0)
                            .format(product.price),
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
                                          if (count > 1) {
                                            // quantity = quantity - 1;
                                            // count = quantity;
                                            count--;
                                          }
                                        });
                                        print(count);
                                      }),
                                  Text(
                                    count.toString(),
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
                                      // print(quantity);
                                      setState(() {
                                        // quantity = quantity + 1;
                                        // count = quantity;
                                        count++;
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
            child: Text('Continous',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => CheckOut(
                    product: widget.product,
                  ),
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
          children: [
            _SingleCartProduct(widget.product!, widget.quantity!),
            _SingleCartProduct(widget.product!, widget.quantity!),
            _SingleCartProduct(widget.product!, widget.quantity!),
            _SingleCartProduct(widget.product!, widget.quantity!),
            _SingleCartProduct(widget.product!, widget.quantity!),
            _SingleCartProduct(widget.product!, widget.quantity!),
          ],
        ),
      ),
    );
  }
}
