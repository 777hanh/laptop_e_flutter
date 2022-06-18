import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/myCardProduct.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ListProduct extends StatelessWidget {
  // const ListProduct({Key? key}) : super(key: key);
  List<Product>? snapShot;
  String? name;
  ListProduct({this.snapShot, this.name});
  List<Product> demoProductItems = demoProduct;

  Widget getProducWidget(context) {
    Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .orderBy('name', descending: false)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // return Text('Something went wrong');
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }

          if (snapshot.data!.docs.length > 0) {
            this.snapShot = snapshot.data!.docs
                .map((i) => Product(
                    image: i['image'],
                    id: i['id'],
                    description: i['description'],
                    price: i['price'].toDouble(),
                    title: i['name'],
                    isPopular: i['isPopular'],
                    idCategory: i['idCategory']))
                .toList();
            //* Slelect data of List Product
            switch (name) {
              case 'Acer':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 1)
                    .toList();
                break;
              case 'Asus':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 2)
                    .toList();
                break;
              case 'Dell':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 3)
                    .toList();
                break;
              case 'HP':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 4)
                    .toList();
                break;
              case 'Lenovo':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 5)
                    .toList();
                break;
              case 'Mac':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 6)
                    .toList();
                break;
              case 'Microsoft':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 7)
                    .toList();
                break;
              case 'Samsung':
                snapShot = snapShot!
                    .where((element) => element.idCategory == 8)
                    .toList();
                break;
              case 'Popular Product':
                snapShot =
                    snapShot!.where((element) => element.isPopular).toList();
                break;
              default:
                snapShot;
            }
            // print('print-me: ${snapShot}');
            return new Container(
              height: MediaQuery.of(context).size.height * (660 / 812),
              child: GridView.count(
                  childAspectRatio: 0.72,
                  crossAxisCount: 2,
                  children: snapShot!
                      .map(
                        (item) => new MyCardProduct(
                          name: item.title,
                          price: item.price,
                          image: item.image,
                          product: item,
                        ),
                      )
                      .toList()),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            name != null ? name! : '',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            NotificationButton(),
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // _buildProduct(context),
                      getProducWidget(context),
                      // getProductSnapshot(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
