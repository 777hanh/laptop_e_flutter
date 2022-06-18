import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/screens/login.dart';
import 'package:elaptop/widgets/changeScreen.dart';
import 'package:elaptop/widgets/mySnackBar.dart';
import 'package:elaptop/widgets/mytextformField.dart';
import 'package:elaptop/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/myButton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obserText = true;
String? email;
String? password;
String? username;
bool isMale = true;
String? phone;

class _SignUpState extends State<SignUp> {
  handleRedirectLoginScreen() {
    //redirect to Login screen
    Navigator.of(context).pushReplacement(PageTransition(
      type: PageTransitionType.fade,
      alignment: Alignment.bottomCenter,
      child: Login(),
    ));
  }

  handRedirect() async {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        content: Container(
          height: 30,
          child: Text(
            'Register successfully!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Lato',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 40, 167, 70),
      ),
    );
    //set 5 second to show splash
    var duration = const Duration(seconds: 2);
    return Timer(duration, handleRedirectLoginScreen);
  }

  Future<void> validation() async {
    final FormState _form = _formKey.currentState!;
    if (_form.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        FirebaseFirestore.instance
            .collection('User')
            .doc(result.user!.uid)
            .set({
          "UserName": username,
          'UserId': result.user!.uid,
          "UserEmail": email,
          "UserGender": isMale == true ? "Male" : "Female",
          "phone": phone,
          "address": "",
          "userImage": ""
        });
        handRedirect();
      } on FirebaseAuthException catch (err) {
        _scaffoldKey.currentState!.showSnackBar(
          SnackBar(
            content: Container(
              height: 50,
              child: Text(
                err.message.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: Color.fromARGB(171, 255, 82, 82),
          ),
        );
      }
    } else {
      print('Value Is Invalid');
    }
  }

  Widget _buildHeadPart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Create Account,',
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Sign up to get start!',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Lato',
              fontSize: 28,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAllTextField() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
//* Input-username
          MyTextFormField(
            name: 'Username',
            onChanged: (value) {
              setState(() {
                username = value.toString();
              });
            },
            validator: (value) {
              if (value.toString().length < 4) {
                return 'Username is too short';
              } else if (value == '') {
                return 'Please Fill username';
              }
              return null;
            },
          ),

//* Input-mail
          MyTextFormField(
            name: 'Email',
            onChanged: (value) {
              setState(() {
                email = value.toString();
              });
            },
            validator: (value) {
              if (value == '') {
                return 'Please Fill Email';
              } else if (!regExp.hasMatch(value.toString())) {
                return 'Email Is Invalid!';
              }
              return null;
            },
          ),

//* Input-password
          PasswordTextFormField(
            name: 'Password',
            obserText: obserText,
            validator: (value) {
              if (value == '') {
                return 'Please Fill Password';
              } else if (value.toString().length < 4) {
                return 'Password Is Too Short!';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                password = value.toString();
              });
            },
            onTap: () {
              setState(() {
                obserText = !obserText;
              });
              FocusScope.of(context).unfocus();
            },
          ),
//* Input -gender
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      isMale == true ? "Male" : "Female",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
//* Input-phonenumber
          MyTextFormField(
            name: 'Phone Number',
            onChanged: (value) {
              setState(() {
                phone = value.toString();
              });
            },
            validator: (value) {
              if (value == '') {
                return 'Please Fill Phone Number';
              } else if (value.toString().length < 10) {
                return 'Phone Number Must Be 10!';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildAllTextField(),

//*Button-Register
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: MyButton(
              onPressed: () {
                validation();
              },
              name: 'Register',
              color: Color(0xFF0B5EA7),
            ),
          ),

//* Login
          ChangeScreen(
              name: 'Login',
              onTap: () {
                Navigator.of(context).pushReplacement(PageTransition(
                  type: PageTransitionType.fade,
                  alignment: Alignment.bottomCenter,
                  child: Login(),
                ));
              },
              whichAccount: 'I Have Already Account!'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * (710 / 812),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 13,
                            ),
                            SizedBox(
                              height: 150,
                              child: Image.asset('assets/logo.png'),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: _buildHeadPart(),
                            ),
                          ],
                        ),
                      ),
                      _buildBottomPart(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
