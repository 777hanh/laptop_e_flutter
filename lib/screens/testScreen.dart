import 'package:elaptop/screens/login.dart';
import 'package:elaptop/widgets/changeScreen.dart';
import 'package:elaptop/widgets/mySnackBar.dart';
import 'package:elaptop/widgets/mytextformField.dart';
import 'package:elaptop/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/myButton.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _SignUpState();
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

class _SignUpState extends State<TestScreen> {
  Future<void> validation() async {
    final FormState _form = _formKey.currentState!;

    print(_form.validate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
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
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
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
                                } else if (value.toString().length < 7) {
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
//*Button-Register
                            Container(
                              height: 75,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (ctx) => Login(),
                                    ),
                                  );
                                },
                                whichAccount: 'I Have Already Account!'),
// //* Input-phonenumber
//           MyTextFormField(
//             name: 'Phone Number',
//             validator: (value) {
//               if (value == '') {
//                 return 'Please Fill Phone Number';
//               } else if (value.toString().length < 10) {
//                 return 'Phone Number Must Be 10!';
//               }
//               return '';
//             },
//           ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
