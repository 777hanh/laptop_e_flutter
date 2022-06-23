import 'package:elaptop/screens/home.dart';
import 'package:elaptop/screens/searchScreen.dart';
import 'package:elaptop/widgets/myCardText.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListCategories extends StatelessWidget {
  const ListCategories({Key? key}) : super(key: key);

  Widget _buildCategories() {
    return Container(
      height: 500,
      child: GridView.count(
        mainAxisSpacing: 40,
        childAspectRatio: 2.8,
        crossAxisCount: 2,
        children: <Widget>[
          MyCardText(
            name: 'Gaming Laptops',
            width: 175,
            height: 57.5,
            fontSize: 20,
          ),
          MyCardText(
            name: 'Office Laptops',
            width: 175,
            height: 57.5,
            fontSize: 20,
          ),
          MyCardText(
            name: 'Mini Laptops',
            width: 175,
            height: 57.5,
            fontSize: 20,
          ),
          MyCardText(
            name: 'Thin and Light Laptops',
            width: 175,
            height: 57.5,
            fontSize: 20,
          ),
          MyCardText(
            name: 'Graphic Laptops',
            width: 175,
            height: 57.5,
            fontSize: 20,
          ),
          MyCardText(
            name: 'Touch Laptops',
            width: 175,
            height: 57.5,
            fontSize: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          //   onPressed: () {
          //     Navigator.of(context).pushReplacement(PageTransition(
          //       type: PageTransitionType.fade,
          //       alignment: Alignment.bottomCenter,
          //       child: Home(),
          //     ));
          //   },
          // ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SearchScreen()),
                );
              },
            ),
            NotificationButton(),
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Which category do you want ?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  // height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildCategories(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
