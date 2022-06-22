// ignore_for_file: prefer_const_constructors
// import 'package:elaptop/screens/login.dart';
// import 'package:elaptop/screens/signup.dart';
import 'package:elaptop/models/cart.dart';
import 'package:elaptop/models/product.dart';
import 'package:elaptop/models/user.dart';
import 'package:elaptop/provider/authProvider.dart';
import 'package:elaptop/provider/cartProvider.dart';
import 'package:elaptop/provider/carts-provider.dart';
import 'package:elaptop/provider/productProvider.dart';
import 'package:elaptop/provider/products-provider.dart';
import 'package:elaptop/provider/user-provider.dart';
import 'package:elaptop/provider/userProvider.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/screens/splash.dart';
import 'package:elaptop/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebas';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD6IePi7lkXSnApXfzcS-Oelp7SxwgE6AQ",
      projectId: "flutter-d8fdd",
      messagingSenderId: "598286659428",
      appId: "1:598286659428:android:2750fd4f7aaf31c629d471",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        StreamProvider<List<UserModel>>.value(
          value: User_Provider().allUsers,
          catchError: (_, __) => [],
          initialData: [],
          child: MyApp(),
        ),
        StreamProvider<List<Product>>.value(
          value: Products_Provider().allProducts,
          catchError: (_, __) => [],
          initialData: [],
          child: MyApp(),
        ),
        StreamProvider<List<CartModel>>.value(
          value: Cart_Provider().allCart,
          initialData: [],
          catchError: (_, __) => [],
          child: MyApp(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home: Profile(),
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
