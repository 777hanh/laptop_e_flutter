import 'dart:async';
// import 'package:elaptop/provider/categoryProvider.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/screens/welcome.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final AsyncSnapshot<Object?>? snapshot;
  const SplashScreen({Key? key, this.snapshot}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// CategoryProvider? categoryProvider;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    handRedirect();
  }

  handleRedirectLoginScreen() {
    //redirect to Login screen
    if (widget.snapshot!.hasData) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    }
  }

  handRedirect() async {
    //set 5 second to show splash
    var duration = const Duration(seconds: 5);
    return Timer(duration, handleRedirectLoginScreen);
  }

  @override
  Widget build(BuildContext context) {
    // categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.png'),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B5EA7),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
//Loading
                LoadingBouncingGrid.square(
                  borderSize: 1.0,
                  size: 50.0,
                  backgroundColor: const Color.fromRGBO(11, 94, 167, 1),
                  duration: const Duration(seconds: 2),
                  inverted: false,
                ),
              ],
            ),
          ),
        ));
  }
}
