import 'package:flutter/material.dart';

class MyCardText extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final double? fontSize;
  final String? name;
  MyCardText({this.image, this.height, this.width, this.name, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // if you need this
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          
        ),
        child: Container(
            alignment: Alignment.center,
            height: height == null ? 57 : height,
            width: width == null ? 160 : width,
            child: Text(
              name.toString(),
              style: TextStyle(fontFamily: 'Lato', fontSize: fontSize),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
