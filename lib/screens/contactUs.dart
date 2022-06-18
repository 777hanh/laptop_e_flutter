import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        centerTitle: true,
        title: Text('',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato')),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: Home()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        // actions: [Container()],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: MediaQuery.of(context).size.height * (710 / 812),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                  ),

                  //header
                  Container(
                    // padding: EdgeInsets.only(bottom: 0.5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue.shade300,
                          width: 2.5,
                        ),
                      ),
                    ),
                    // height: 40,
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  //container
                  Container(
                    height: 490,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF0B5EA7),
                          width: 3,
                        ),
                        borderRadius: new BorderRadius.only(
                          topRight: const Radius.circular(170.0),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          height: 400,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: Icon(
                                          Icons.phone,
                                          size: 38,
                                          color: Color(0xFF0B5EA7),
                                        )),
                                    Text(
                                      '0909090909',
                                      style: TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: Icon(
                                          Icons.mail,
                                          size: 38,
                                          color: Color(0xFF0B5EA7),
                                        )),
                                    Text(
                                      'welap-demo@gmail.com',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: Text(
                                          'Instagram:',
                                          style: TextStyle(
                                              color: Color(0xFF0B5EA7),
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 5, left: 70),
                                        child: InkWell(
                                            child: Text(
                                              'WELAPS',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            onTap: () async {
                                              await launch(
                                                  'https://youtu.be/dQw4w9WgXcQ');
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              child: MyButton(
                                onPressed: () async {
                                  await launch('tel:0909090909');
                                },
                                name: 'Call',
                                width: 150,
                              ),
                            ),
                            Container(
                              height: 50,
                              child: MyButton(
                                onPressed: () async {
                                  await launch(
                                      'mailto:welap-demo@gmail.com?subject=Hỗ%20hợ&body=');
                                },
                                name: 'Mail',
                                width: 150,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
