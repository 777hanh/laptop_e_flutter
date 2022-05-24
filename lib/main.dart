// ignore_for_file: prefer_const_constructors
// import 'package:elaptop/screens/login.dart';
// import 'package:elaptop/screens/signup.dart';
import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/product.dart';
// import 'package:elaptop/provider/categoryProvider.dart';
import 'package:elaptop/provider/carts-provider.dart';
import 'package:elaptop/provider/products-provider.dart';
import 'package:elaptop/screens/categories.dart';
import 'package:elaptop/screens/checkout.dart';
import 'package:elaptop/screens/detail.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/screens/listproduct.dart';
import 'package:elaptop/screens/login.dart';
import 'package:elaptop/screens/splash.dart';
import 'package:elaptop/screens/testScreen.dart';
import 'package:elaptop/screens/welcome.dart';
import 'package:elaptop/widgets/bottomNavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Product>>.value(
          value: Products_Provider().allProducts,
          catchError: (_, __) => [],
          initialData: [],
          child: MyApp(),
        ),
        StreamProvider<CartModel>.value(
          value: Cart_Provider().allCart,
          initialData: CartModel(),
          child: MyApp(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SplashScreen(snapshot: snapshot);
                // return Home();
              } else {
                return Welcome();
              }
            }),
      ),
    );
  }
}
