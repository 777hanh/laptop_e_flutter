import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/myButton.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool edit = false;

  @override
  Widget build(BuildContext context) {
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
                                    _buildTextFormField(name: 'demo'),
                                    _buildTextFormField(name: 'demo@gmail.com'),
                                    _buildTextFormField(name: 'Male'),
                                    _buildTextFormField(name: '1234567890'),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildSingleContainer(
                                        start: 'Name', end: 'demo'),
                                    _buildSingleContainer(
                                        start: 'Email', end: 'demo@gmail.com'),
                                    _buildSingleContainer(
                                        start: 'Gender', end: 'Male'),
                                    _buildSingleContainer(
                                        start: 'Phone', end: '1234567890'),
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
