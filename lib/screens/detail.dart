import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/singleProduct.dart';

class Detail extends StatelessWidget {
  final Product product;

  Detail(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height * (710 / 812),
        child: SingleProduct(
          product: product,
        ),
      ),
    );
  }
}
