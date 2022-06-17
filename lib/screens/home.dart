// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:image_network/image_network.dart';
import 'package:elaptop/models/user.dart';
import 'package:elaptop/provider/productProvider.dart';
import 'package:elaptop/provider/products-provider.dart';
import 'package:elaptop/screens/cartscreen.dart';
import 'package:elaptop/screens/categories.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elaptop/models/cart.dart';
// import 'package:elaptop/provider/categoryProvider.dart';
import 'package:elaptop/screens/listbrand.dart';
import 'package:elaptop/screens/listproduct.dart';
import 'package:elaptop/screens/login.dart';
import 'package:elaptop/screens/profileScreen.dart';
import 'package:elaptop/widgets/myCardBrand.dart';
import 'package:elaptop/widgets/myCardProduct.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class Home extends StatefulWidget {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//*temp - List product
  // List<Product> allProducts = [emptyProduct];
  // List<Product> popularProducts = [emptyProduct];
  List<Product> allProducts = [];
  List<Product> popularProducts = [];
  ProductProvider? productProvider;
  String imageNetworkTemp =
      r'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4hBXLI1tGjFgNKdDFogmZi0nlqxXJaFTleQ&usqp=CAU';
//*temp

  bool homeColor = false;
  bool cartColor = false;
  bool categoryColor = false;

  bool aboutColor = false;
  bool contactColor = false;

  Widget _buildMyDrawer() {
    productProvider = Provider.of<ProductProvider>(context);

    User? currentUser;
    try {
      currentUser = FirebaseAuth.instance.currentUser!;
    } catch (e) {
      FirebaseAuth.instance.currentUser!.reload();
      currentUser = FirebaseAuth.instance.currentUser;
    }
    List<UserModel> snapShot =
        Provider.of<List<UserModel>>(context, listen: true);
    List<UserModel> user = snapShot
        .where((element) => element.userId == currentUser!.uid)
        .toList();
    // print('LOGGER: ${user != [] ? user[0].address : ''}');
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user.length > 0 ? user[0].userName : '',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: BoxDecoration(color: Color(0xfff2f2f2)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user.length > 0 && user[0].userImage == ''
                  ? NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4hBXLI1tGjFgNKdDFogmZi0nlqxXJaFTleQ&usqp=CAU')
                  : AssetImage('assets/userImage.png') as ImageProvider,
            ),
            accountEmail: Text(
              // ignore: unnecessary_null_comparison
              user != null
                  ? user.length > 0
                      ? user[0].userEmail
                      : ''
                  : '',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              // setState(() {
              //   homeColor = true;
              //   contactColor = false;
              //   aboutColor = false;
              //   cartColor = false;
              //   categoryColor = false;
              // });
              widget._key.currentState!.closeDrawer();
            },
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
          ),
          ListTile(
            selected: categoryColor,
            onTap: () {
              // setState(() {
              //   categoryColor = true;
              //   contactColor = false;
              //   aboutColor = false;
              //   cartColor = false;
              //   homeColor = false;
              // });

              Navigator.of(context).push(
                MaterialPageRoute(
                  // builder: (ctx) => ListCategories(),
                  builder: (ctx) => ListBrand(),
                ),
              );
            },
            leading: Icon(Icons.dashboard),
            title: Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                // cartColor = true;
                // contactColor = false;
                // aboutColor = false;
                // homeColor = false;
                // categoryColor = false;
              });
              productProvider!.resetNotification();
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: Cart()),
              );
            },
            leading: Icon(Icons.shopping_bag_rounded),
            title: Text(
              'Cart',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                // cartColor = true;
                // contactColor = false;
                // aboutColor = false;
                // homeColor = false;
                // categoryColor = false;
              });
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: Profile()),
              );
            },
            leading: Icon(Icons.account_circle_rounded),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
          ),
          Divider(
            color: Color.fromARGB(136, 77, 77, 77),
            thickness: 1,
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              // setState(() {
              //   aboutColor = true;
              //   contactColor = false;
              //   homeColor = false;
              //   cartColor = false;
              //   categoryColor = false;
              // });
            },
            leading: Icon(Icons.info_rounded),
            title: Text(
              'About',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
          ),
          ListTile(
            selected: contactColor,
            onTap: () {
              // setState(() {
              //   contactColor = true;
              //   homeColor = false;
              //   aboutColor = false;
              //   cartColor = false;
              //   categoryColor = false;
              // });
            },
            leading: Icon(Icons.phone),
            title: Text(
              'Contact us',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: Login()),
              );
            },
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductPopular(List<Product> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(right: 10),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  // if (mySnapshot.data.docs.length > 3) ...[
                  if (products.length > 3) ...[
                    for (var i = 0; i < 4; i++)
                      MyCardProduct(
                        id: products[i].id,
                        name: products[i].title,
                        price: products[i].price,
                        image: products[i].image,
                        product: products[i],
                      )
                  ] else if (products.length == 3) ...[
                    for (var i = 0; i < 3; i++)
                      MyCardProduct(
                        product: products[i],
                        name: products[i].title,
                        price: products[i].price,
                        image: products[i].image,
                      )
                  ] else ...[
                    for (var i = 0; i < products.length; i++)
                      MyCardProduct(
                        product: products[i],
                        name: products[i].title,
                        price: products[i].price,
                        image: products[i].image,
                      )
                  ]
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrand(context) {
    List<Product> asuss = Provider.of<List<Product>>(context, listen: true)
        .where((element) => element.idCategory == 2)
        .toList();
    List<Product> dells = Provider.of<List<Product>>(context, listen: true)
        .where((element) => element.idCategory == 3)
        .toList();
    List<Product> macs = Provider.of<List<Product>>(context, listen: true)
        .where((element) => element.idCategory == 6)
        .toList();
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Choose your brand',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Lato')),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.bottomCenter,
                      child: ListBrand(),
                    ));
                  },
                  child: Text('See all',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Lato')),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  ListProduct(snapShot: asuss, name: 'Asus'),
                            ),
                          );
                          // print(asuss);
                        },
                        child: MyCardBrand(
                          image: 'brand1.png',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  ListProduct(snapShot: dells, name: 'Dell'),
                            ),
                          );
                        },
                        child: MyCardBrand(
                          image: 'brand2.png',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  ListProduct(snapShot: macs, name: 'Mac'),
                            ),
                          );
                        },
                        child: MyCardBrand(
                          image: 'brand3.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProduct(context, List<Product> productsPopular, String title,
      Widget navigate, String type) {
    productsPopular = Provider.of<List<Product>>(context, listen: true);
    // type == 'popularProduct'
    //     ? productsPopular =
    //         productsPopular.where((item) => item.isPopular).toList()
    //     : productsPopular;
    // print('logger ==== ${productsPopular}');
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Lato')),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.bottomCenter,
                    child: navigate,
                  ));
                },
                child: Text('See all',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Lato')),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: _buildProductPopular(productsPopular),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product> allProductsList =
        Provider.of<List<Product>>(context, listen: true);
    //*set data for all products
    allProducts = allProductsList;
    popularProducts = allProductsList.where((item) => item.isPopular).toList();

    return Scaffold(
      key: widget._key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: Text(
          'Home',
          style:
              TextStyle(color: Colors.black, fontSize: 28, fontFamily: 'Lato'),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              widget._key.currentState!.openDrawer();
            },
            // child: Container(
            //     padding: EdgeInsets.only(left: 10),
            //     child: Image.asset('assets/logo.png')),
            child: Icon(Icons.menu_rounded, color: Colors.black, size: 35)),
        actions: <Widget>[NotificationButton()],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height * (710 / 812),
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            //* search
            Container(
              height: 80,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Which laptop do you want to buy ?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //* Banner
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 130,
                        color: Colors.transparent,
                        child: Carousel(
                          images: [
                            AssetImage('assets/images/banner/banner1.png'),
                            AssetImage('assets/images/banner/banner2.png'),
                            AssetImage('assets/images/banner/banner3.png'),
                          ],
                          dotColor: Colors.white,
                          dotIncreasedColor: Colors.blue,
                          indicatorBgPadding: 1,
                          autoplay: true,
                          dotIncreaseSize: 2,
                          dotSpacing: 30,
                          dotSize: 10,
                          dotBgColor: Colors.transparent,
                          borderRadius: true,
                          radius: Radius.circular(20),
                        ),
                      ),
                      //* brand list
                      SizedBox(
                        height: 20,
                      ),
                      _buildBrand(
                        context,
                      ),
                      //* popular product list
                      SizedBox(
                        height: 20,
                      ),
                      _buildProduct(
                          context,
                          popularProducts,
                          'Popular Product',
                          ListProduct(
                              snapShot: popularProducts,
                              name: 'Popular Product'),
                          'allProduct'),
                      //* product list
                      SizedBox(
                        height: 20,
                      ),
                      _buildProduct(
                          context,
                          // allProductsList,
                          allProducts,
                          'Products',
                          ListProduct(snapShot: allProducts, name: 'Products'),
                          'popularProduct'),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBody() {

  // }
}
