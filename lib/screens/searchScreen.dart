import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/widgets/myCardProduct.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../models/product.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // const SearchScreen({Key? key}) : super(key: key);
  List<Product> demoProductItems = demoProduct;

  List<Product>? snapShot = [];

  String searchText = '';

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
            snapShot = snapshot.data!.docs
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

            snapShot = snapShot!
                .where((element) => element.title
                    .toLowerCase()
                    .contains(searchText.toLowerCase()))
                .toList();

            // print('print-me: ${snapShot}');
            return new Container(
              height: MediaQuery.of(context).size.height * (620 / 812),
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
            'Search',
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      //* search
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        width: 350,
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 250,
                                height: 80,
                                child: TextFormField(
                                  onChanged: (value) {
                                    searchText = value;
                                  },
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Search here . . .',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                height: 50,
                                child: ElevatedButton(
                                    child:
                                        Icon(Icons.search, color: Colors.black),
                                    onPressed: () async {
                                      snapShot = await snapShot!
                                          .where((element) => element.title
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase()))
                                          .toList();
                                      print('logger: ${snapShot}');
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
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
