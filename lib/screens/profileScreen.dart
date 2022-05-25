import 'package:elaptop/models/user.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/myButton.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

bool isMale = true;

class _ProfileState extends State<Profile> {
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    List<UserModel> snapShot =
        Provider.of<List<UserModel>>(context, listen: true);
    List<UserModel> user =
        snapShot.where((element) => element.userId == currentUser.uid).toList();

    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(Icons.close, color: Colors.black38, size: 30),
                onPressed: () {
                  setState(() {
                    edit = !edit;
                  });
                },
              )
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => Home()));
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? NotificationButton()
              : Row(
                  children: [
                    Text('Save'),
                    IconButton(
                      icon: Icon(Icons.check, size: 30, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                      },
                    )
                  ],
                ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * (710 / 812),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  //*image info
                  Stack(
                    children: [
                      Container(
                        height: 130,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              maxRadius: 65,
                              backgroundImage:
                                  AssetImage('assets/userImage.png'),
                            ),
                          ],
                        ),
                      ),
                      edit == true
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 215, top: 80),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  //*
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //*info here
                        Container(
                          height: 300,
                          child: edit == true
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildTextFormField(
                                        name: user.length > 0
                                            ? user[0].userName
                                            : ''),
                                    _buildTextFormField(
                                        name: user.length > 0
                                            ? user[0].userEmail
                                            : ''),
                                    //*Gender
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
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                isMale == true
                                                    ? "Male"
                                                    : "Female",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    //*
                                    _buildTextFormField(
                                        name: user.length > 0
                                            ? user[0].userPhoneNumber
                                            : ''),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildSingleContainer(
                                        start: 'Name',
                                        end: user.length > 0
                                            ? user[0].userName
                                            : ''),
                                    _buildSingleContainer(
                                        start: 'Email',
                                        end: user.length > 0
                                            ? user[0].userEmail
                                            : ''),
                                    _buildSingleContainer(
                                        start: 'Gender',
                                        end: user.length > 0
                                            ? user[0].userGender
                                            : ''),
                                    _buildSingleContainer(
                                        start: 'Phone',
                                        end: user.length > 0
                                            ? user[0].userPhoneNumber
                                            : ''),
                                  ],
                                ),
                        ),
                        //*
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: edit == false
                        ? MyButton(
                            onPressed: () {
                              setState(() {
                                this.edit = !this.edit;
                              });
                            },
                            name: 'Edit Profile',
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleContainer({String? start, String? end}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              start!,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black45,
              ),
            ),
            Text(
              end!,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({String? name}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: name!,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
