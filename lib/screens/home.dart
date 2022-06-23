// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/screens/aboutUs.dart';
import 'package:elaptop/screens/contactUs.dart';
import 'package:elaptop/screens/historyScreen.dart';
import 'package:elaptop/models/user.dart';
import 'package:elaptop/provider/productProvider.dart';
import 'package:elaptop/screens/cartscreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elaptop/models/cart.dart';
// import 'package:elaptop/provider/categoryProvider.dart';
import 'package:elaptop/screens/listbrand.dart';
import 'package:elaptop/screens/listproduct.dart';
import 'package:elaptop/screens/login.dart';
import 'package:elaptop/screens/profileScreen.dart';
import 'package:elaptop/screens/searchScreen.dart';
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
  List<Product>? allProducts = [emptyProduct];
  List<Product>? popularProducts = [emptyProduct];
  // List<Product>? allProducts;
  // List<Product>? popularProducts;
  ProductProvider? productProvider;
//*temp

  bool homeColor = false;
  bool cartColor = false;
  bool categoryColor = false;

  bool aboutColor = false;
  bool contactColor = false;
  User currentUser = FirebaseAuth.instance.currentUser!;

  Widget _buildMyDrawer() {
    List<UserModel> snapShot =
        Provider.of<List<UserModel>>(context, listen: true);
    //todo
    Stream<QuerySnapshot> _userStream =
        FirebaseFirestore.instance.collection('User').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _userStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(color: Colors.white);
        }

        List<UserModel>? snapShot;
        snapShot = snapshot.data?.docs
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

        snapShot = snapShot != null
            ? snapShot.where((i) => i.userId == currentUser.uid).toList()
            : snapShot;

        if ((snapshot.data?.docs.length ?? 0) > 0 && snapShot != null) {
          // print('LOGGER UID CURRENTUSER: ${snapShot[0].userImage}');
          return Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    snapShot.length > 0 ? snapShot[0].userName : '',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: snapShot.length > 0 &&
                            snapShot[0].userImage != ''
                        ? NetworkImage(
                            // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4hBXLI1tGjFgNKdDFogmZi0nlqxXJaFTleQ&usqp=CAU')
                            '${snapShot[0].userImage}')
                        : AssetImage('assets/userImage.png') as ImageProvider,
                  ),
                  accountEmail: Text(
                    // ignore: unnecessary_null_comparison
                    snapShot != null
                        ? snapShot.length > 0
                            ? snapShot[0].userEmail
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
                    // productProvider!.resetNotification();
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
                    // productProvider!.resetNotification();
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: HistoryScreen()),
                    );
                  },
                  leading: Icon(Icons.access_time_filled_rounded),
                  title: Text(
                    'History',
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
                          type: PageTransitionType.rightToLeft,
                          child: Profile()),
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
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: AboutUs()),
                    );
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
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ContactUs()),
                    );
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
        } else {
          return LinearProgressIndicator();
        }
        // return Drawer(child: Text(snapShot![0].userEmail));
      },
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
      String nameNavigate) {
    // productsPopular = Provider.of<List<Product>>(context, listen: true);
    // print('PRINT ME: ${productsPopular}');
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
                    child: ListProduct(
                        snapShot: productsPopular, name: nameNavigate),
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

  Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          if ((snapshot.data?.docs.length ?? 0) > 0) {
            this.allProducts = snapshot.data?.docs
                .map((i) => Product(
                    image: i['image'],
                    id: i['id'],
                    description: i['description'],
                    price: i['price'].toDouble(),
                    title: i['name'],
                    isPopular: i['isPopular'],
                    idCategory: i['idCategory']))
                .toList();
            this.popularProducts =
                this.allProducts?.where((item) => item.isPopular).toList();
            // print('logger: ${this.allProducts}');
            return Scaffold(
              key: widget._key,
              drawer: _buildMyDrawer(),
              appBar: AppBar(
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.black, fontSize: 28, fontFamily: 'Lato'),
                ),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: GestureDetector(
                    onTap: () {
                      widget._key.currentState?.openDrawer();
                    },
                    // child: Container(
                    //     padding: EdgeInsets.only(left: 10),
                    //     child: Image.asset('assets/logo.png')),
                    child: Icon(Icons.menu_rounded,
                        color: Colors.black, size: 35)),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: SearchScreen()),
                      );
                    },
                  ),
                  NotificationButton()
                ],
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height * (710 / 812),
                width: double.infinity,
                child: ListView(
                  children: <Widget>[
                    //* search
                    // Container(
                    //   height: 80,
                    //   width: double.infinity,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       TextFormField(
                    //         decoration: InputDecoration(
                    //           prefixIcon: Icon(Icons.search),
                    //           hintText: "Which laptop do you want to buy ?",
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(30),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                                    AssetImage(
                                        'assets/images/banner/banner1.png'),
                                    AssetImage(
                                        'assets/images/banner/banner2.png'),
                                    AssetImage(
                                        'assets/images/banner/banner3.png'),
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
                                this.popularProducts!,
                                'Popular Product',
                                'Popular Product',
                              ),
                              //* product list
                              SizedBox(
                                height: 20,
                              ),
                              _buildProduct(
                                context,
                                // allProductsList,
                                this.allProducts!,
                                'Products',
                                'Products',
                              ),
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
          } else {
            return LinearProgressIndicator();
          }
        });
  }

  // Widget _buildBody() {

  // }
}
