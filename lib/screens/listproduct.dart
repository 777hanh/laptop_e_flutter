import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/myCardProduct.dart';
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

  Widget getProducWidget(List<Product> products, context) {
//* Slelect data of List Product
    switch (name) {
      case 'Acer':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 1)
            .toList();
        break;
      case 'Asus':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 2)
            .toList();
        break;
      case 'Dell':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 3)
            .toList();
        break;
      case 'HP':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 4)
            .toList();
        break;
      case 'Lenovo':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 5)
            .toList();
        break;
      case 'Mac':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 6)
            .toList();
        break;
      case 'Microsoft':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 7)
            .toList();
        break;
      case 'Samsung':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((item) => item.idCategory == 8)
            .toList();
        break;
      case 'Popular Product':
        snapShot = Provider.of<List<Product>>(context, listen: true)
            .where((element) => element.isPopular)
            .toList();
        break;
      default:
        snapShot = Provider.of<List<Product>>(context, listen: true);
    }
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
              // Navigator.of(context).pushReplacement(PageTransition(
              //   type: PageTransitionType.fade,
              //   alignment: Alignment.bottomCenter,
              //   child: Home(),
              // ));
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
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
                      getProducWidget(demoProductItems, context),
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
