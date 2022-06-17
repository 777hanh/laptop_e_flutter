import 'dart:async';

import 'package:elaptop/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/myButton.dart';

class ThanksScreen extends StatefulWidget {
  ThanksScreen({Key? key}) : super(key: key);

  @override
  State<ThanksScreen> createState() => _ThanksScreenState();
}

Color themeColor = const Color.fromRGBO(11, 94, 167, 1);

class _ThanksScreenState extends State<ThanksScreen> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    super.initState();
    handRedirect();
  }

  handleRedirectLoginScreen() {
    //redirect to Login screen
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade, child: Home()));
  }

  handRedirect() async {
    //set 5 second to show splash
    var duration = const Duration(seconds: 7);
    return Timer(duration, handleRedirectLoginScreen);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Color.fromRGBO(11, 94, 167, 1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color: Color(0xFF32567A),
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Payment done Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "You will be redirected to the home page shortly\nor click here to return to home page",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 200,
                  child: MyButton(
                      name: 'Home',
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: Home()));
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
