import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/cart.dart';
import 'package:rxdart/rxdart.dart';
import 'package:elaptop/provider/cartProvider.dart';
import 'package:elaptop/provider/productProvider.dart';
import 'package:elaptop/screens/cartscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class SingleProduct extends StatefulWidget {
  final Product? product;
  SingleProduct({required this.product});
  bool isSeeMore = false;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

int maxLineOfDescription = 3;

//* format description
String formatString(String? str) {
  List<String> lstSTR = str!.split('\\n');
  String newStr = '';
  if (lstSTR.length > 1) {
    newStr = lstSTR[0];
    for (int i = 1; i < lstSTR.length; i++) {
      newStr = newStr + '\n' + lstSTR[i];
    }
  } else {
    newStr = lstSTR[0];
  }
  // print(newStr);
  return newStr;
}

void CheckIsProductInCart(String idProduct, context, List<CartModel> lstCart,
    double quantity, String currentUser) {
  List<CartModel> lstCheck = lstCart
      .where((item) =>
          item.idProduct == idProduct &&
          item.idUser == currentUser &&
          item.isBuy == false)
      .toList();
  CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
  if (lstCheck.length > 0) {
    cartProvider.addProductCartIsExistInCart(idProduct, quantity, currentUser);
  } else {
    cartProvider.addProductToCart(idProduct, quantity, currentUser);
  }
}

class _SingleProductState extends State<SingleProduct> {
  int count = 1;
  List<Product>? snapShotProduct;
  List<CartModel>? snapShotCart;
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    //******** */
    //******** */
    Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    Stream<QuerySnapshot> _cartsStream =
        FirebaseFirestore.instance.collection('cart').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshotProduct) {
          if (snapshotProduct.hasError) {
            return Container();
          }
          // if (snapshotProduct.connectionState == ConnectionState.waiting) {
          //   return Container();
          // }
          if ((snapshotProduct.data?.docs.length ?? 0) > 0) {
            this.snapShotProduct = snapshotProduct.data?.docs
                .map((i) => Product(
                    image: i['image'],
                    id: i['id'],
                    description: i['description'],
                    price: i['price'].toDouble(),
                    title: i['name'],
                    isPopular: i['isPopular'],
                    idCategory: i['idCategory']))
                .toList()
                .where((i) => i.id == widget.product?.id)
                .toList();
            // return Container();
            return StreamBuilder<QuerySnapshot>(
              stream: _cartsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshotCart) {
                if (snapshotCart.hasError) {
                  return Container();
                }
                if ((snapshotProduct.data?.docs.length ?? 0) > 0) {
                  this.snapShotCart = snapshotCart.data?.docs
                      .map((i) => CartModel(
                            id: i['id'],
                            idUser: i['user'],
                            idProduct: i['idProduct'],
                            quantity: i['quantity'].toDouble(),
                            isBuy: i['isBuy'],
                          ))
                      .toList();
                  // print('LOGGER CART ${this.snapShotCart?.length}');
                  // print('LOGGGEER PRODUCT ${this.snapShotProduct?.length}');
                  return ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 260,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  // image: AssetImage(
                                  //     "assets/images/lap/${widget.product!.image}"),
                                  image:
                                      NetworkImage("${widget.product!.image}"),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.center),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width *
                                    (20 / 375)),
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width *
                                    (20 / 375)),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //* Title of Product
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              (20 / 375)),
                                      child: Text(
                                        widget.product!.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    //* is Product favourite
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                (15 / 375)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (64 / 375),
                                        decoration: BoxDecoration(
                                          color: widget.product!.isFavourite
                                              ? Color(0xFFFFE6E6)
                                              : Color(0xFFF5F6F9),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/Heart Icon_2.svg",
                                          color: widget.product!.isFavourite
                                              ? Color(0xFFFF4848)
                                              : Color(0xFFDBDEE4),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              (16 / 375),
                                        ),
                                      ),
                                    ),
                                    //* description of Product
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                (20 / 375),
                                        right:
                                            MediaQuery.of(context).size.width *
                                                (20 / 375),
                                      ),
                                      child: Text(
                                        formatString(
                                            widget.product!.description),
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.justify,
                                        maxLines: widget.isSeeMore ? 40 : 3,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                (20 / 375),
                                        vertical: 10,
                                      ),
                                      //* button seemore
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.isSeeMore =
                                                !widget.isSeeMore;
                                          });
                                          print(widget.isSeeMore);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              widget.isSeeMore
                                                  ? "Collapse <"
                                                  : "See more >",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //* button add to cart
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              (20 / 375)),
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              (20 / 375)),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF6F7F9),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Quantity',
                                              style: TextStyle(
                                                  fontFamily: 'Lato')),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              color: Colors.blue[200],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                GestureDetector(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        if (count > 1) {
                                                          count = count - 1;
                                                        }
                                                      });
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
                                                    color: Colors.white,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      count = count + 1;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (20 / 375)),
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (20 / 375)),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (40 / 375),
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (15 / 375),
                                              ),
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    (56 / 812),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    primary: Colors.white,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    CheckIsProductInCart(
                                                      widget.product!.id,
                                                      context,
                                                      this.snapShotCart!,
                                                      count.toDouble(),
                                                      currentUser!.uid,
                                                    );
                                                    productProvider
                                                        .addNotification(
                                                            "Notification");
                                                    Navigator.pushReplacement(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .leftToRight,
                                                            child: Cart()));
                                                  },
                                                  child: Text(
                                                    'Add To Cart',
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              (18 / 375),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return LinearProgressIndicator();
                }
              },
            );
          } else {
            return Container();
          }
        });
  }
}
