import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/user.dart';
import 'package:elaptop/screens/checkout.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/mySingleCartproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _CartState extends State<Cart> {
  int count = 0;
  @override
  initState() {
    super.initState();
  }

//todo new Builder
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('cart').snapshots();
    Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('User').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.hasError) {
          return Container();
        }

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return LinearProgressIndicator();
        // }
        if (snapshot1.hasData) {
          User currentUser = FirebaseAuth.instance.currentUser!;
          List<UserModel>? snapShotUser;
          snapShotUser = snapshot1.data?.docs
              .map((i) => UserModel(
                    userId: i['UserId'],
                    userName: i['UserName'],
                    userEmail: i['UserEmail'],
                    userGender: i['UserGender'],
                    userPhoneNumber: i['phone'],
                    address: i['address'],
                    userImage: i['userImage'],
                  ))
              .toList();
          UserModel user = snapShotUser!
              .where((element) => element.userId == currentUser.uid)
              .toList()[0];
          return StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container();
                }
                if (snapshot.hasData) {
                  List<CartModel>? snapShot;
                  snapShot = snapshot.data?.docs
                      .map((i) => CartModel(
                            id: i['id'],
                            idUser: i['user'],
                            idProduct: i['idProduct'],
                            quantity: i['quantity'].toDouble(),
                            isBuy: i['isBuy'],
                          ))
                      .toList();
                  snapShot = snapShot != null
                      ? snapShot
                          .where((i) =>
                              i.idUser == currentUser.uid && i.isBuy == false)
                          .toList()
                      : snapShot;
                  if ((snapshot.data?.docs.length ?? 0) > 0) {
                    return Scaffold(
                      key: _scaffoldKey,
                      bottomNavigationBar: Container(
                        height: 70,
                        width: 100,
                        color: Color.fromARGB(61, 147, 185, 250),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
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
                              (user.address != null && user.address != '')
                                  ? (snapShot != null && snapShot.length > 0)
                                      ? Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: CheckOut()),
                                        )
                                      : {
                                          _scaffoldKey.currentState!
                                              .showSnackBar(
                                            SnackBar(
                                              content: Container(
                                                height: 30,
                                                child: Text(
                                                  'Your Cart is "Empty"',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Lato',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              duration: Duration(seconds: 5),
                                              backgroundColor: Color.fromARGB(
                                                  171, 255, 82, 82),
                                            ),
                                          )
                                        }
                                  : {
                                      _scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            height: 30,
                                            child: Text(
                                              'Your profile is missing "Address"',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Lato',
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          duration: Duration(seconds: 5),
                                          backgroundColor:
                                              Color.fromARGB(171, 255, 82, 82),
                                        ),
                                      )
                                    };
                              // user.address == ''
                              //     ? print('logger: ${user.address}')
                              //     : print('looger: co ne  ${user.address}');
                            },
                          ),
                        ),
                      ),
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text('Cart',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontFamily: 'Lato')),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        leading: IconButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.leftToRightWithFade,
                                    child: Home()));
                          },
                          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                        ),
                        actions: <Widget>[],
                      ),
//* Body
                      body: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        height:
                            MediaQuery.of(context).size.height * (710 / 812),
                        child: ListView(
                          children: (snapShot?.length ?? 0) > 0
                              ? snapShot!
                                  .map(
                                    (item) => MySingleCartProduct(
                                        cart: item, isInCartScreen: true),
                                  )
                                  .toList()
                              : <Widget>[
                                  Container(
                                    height: 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Empty',
                                          style: TextStyle(
                                              color: Colors.black12,
                                              fontSize: 60),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                        ),
                      ),
                    );
                  } else {
                    return LinearProgressIndicator();
                  }
                } else {
                  return LinearProgressIndicator();
                }
              });
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}
