import 'package:elaptop/screens/home.dart';
import 'package:elaptop/screens/listproduct.dart';
import 'package:elaptop/widgets/myCardBrand.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListBrand extends StatelessWidget {
  const ListBrand({Key? key}) : super(key: key);

  Widget _buildBrand(context) {
    return Container(
      height: 500,
      child: GridView.count(
        mainAxisSpacing: 40,
        childAspectRatio: 2.8,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'Acer'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand5.png',
              width: 175,
              height: 57.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'Dell'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand2.png',
              width: 175,
              height: 57.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'Mac'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand3.png',
              width: 175,
              height: 57.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'HP'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand4.png',
              width: 175,
              height: 57.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'Asus'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand1.png',
              width: 175,
              height: 57.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'Lenovo'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand6.png',
              width: 175,
              height: 57.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'Samsung'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand7.png',
              width: 175,
              height: 57.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(name: 'Microsoft'),
                ),
              );
            },
            child: MyCardBrand(
              image: 'brand8.png',
              width: 175,
              height: 57.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Brand',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(PageTransition(
                type: PageTransitionType.fade,
                alignment: Alignment.bottomCenter,
                child: Home(),
              ));
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
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildBrand(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
