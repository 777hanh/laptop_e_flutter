import 'package:elaptop/screens/home.dart';
import 'package:elaptop/screens/signup.dart';
import 'package:elaptop/widgets/changeScreen.dart';
import 'package:elaptop/widgets/mytextformField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/myButton.dart';
import '../widgets/passwordtextformfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obserText = true;
String? email;
String? password;

class _LoginState extends State<Login> {
  void validation() async {
    final FormState _form = _formKey.currentState!;
    if (_form.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
        if (result.user != null) {
          print('uid: ${result.user!.uid}');
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
        }
        // ignore: unused_catch_clause
      } on FirebaseAuthException catch (err) {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(
          SnackBar(
            content: Container(
              height: 30,
              child: Text(
                'Email or Password is Incorrect',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
            'Welcome,',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              fontSize: 28,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Sign in your Account!',
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

  Widget _buildAllPart() {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
//* Input email
          MyTextFormField(
            name: 'Email',
            validator: (value) {
              if (value == '') {
                return 'Please Fill Email';
              } else if (!regExp.hasMatch(value.toString())) {
                return 'Email Is Invalid!';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                email = value.toString();
              });
            },
          ),

//* Input password
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: PasswordTextFormField(
              name: 'Password',
              obserText: obserText,
              validator: (value) {
                if (value == '') {
                  return 'Please Fill Password';
                } else if (value.toString().length < 7) {
                  return 'Password Is Invalid!';
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
          ),
//* button Login
          MyButton(
              onPressed: () {
                validation();
              },
              name: 'Login',
              color: Color(0xFF0B5EA7)),
//* Register
          ChangeScreen(
              name: 'Register',
              onTap: () {
                Navigator.of(context).pushReplacement(PageTransition(
                  type: PageTransitionType.fade,
                  alignment: Alignment.bottomCenter,
                  child: SignUp(),
                ));
              },
              whichAccount: 'I Have Not Account!')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // User? currentUser = FirebaseAuth.instance.currentUser;
    // if (currentUser != null) {
    //   FirebaseAuth.instance.signOut();
    // }

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
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                child: Image.asset('assets/logo.png'),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: _buildHeadPart(),
                              ),
                            ],
                          ),
                        ),
                        _buildAllPart(),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
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
