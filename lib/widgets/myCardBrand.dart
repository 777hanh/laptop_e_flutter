import 'package:flutter/material.dart';

class MyCardBrand extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  MyCardBrand({this.image, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height == null ? 57 : height,
              width: width == null ? 160 : width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage("assets/images/brand/${image}"),
                    fit: BoxFit.fill,
                    alignment: Alignment.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
