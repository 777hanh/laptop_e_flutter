import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontFamily: 'Lato'),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight, child: Home()));
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          actions: <Widget>[
            NotificationButton(),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * (710 / 812),
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              //* search
              Container(
                height: 80,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Which laptop do you want to buy ?",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
