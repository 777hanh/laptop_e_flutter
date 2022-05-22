import 'package:elaptop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider with ChangeNotifier {
//* Acer
  Product? acerData;
  List<Product> acerDataList = [];
  Future<void> getAcerData() async {
    List<Product> newList = [];
    QuerySnapshot acerSnapShot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('6UOoDK3ZDgBRd3o5jJYS')
        .collection('Acer')
        .get();
    acerSnapShot.docs.forEach(
      (element) {
        acerData = Product(
          image: element['image'],
          id: element.id,
          description: element['description'],
          price: element['price'].toDouble(),
          title: element['name'],
          idCategory: element['idCategory'],
          isPopular: element['isPopular'],
        );
        newList.add(acerData!);
      },
    );
    acerDataList = newList;
  }

  List<Product> get getAcerList {
    return acerDataList;
  }

//*Dell
  Product? dellData;
  List<Product> dellDataList = [];
  Future<void> getDellData() async {
    List<Product> newList = [];
    QuerySnapshot dellSnapShot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('6UOoDK3ZDgBRd3o5jJYS')
        .collection('Dell')
        .get();
    dellSnapShot.docs.forEach(
      (element) {
        dellData = Product(
          image: element['image'],
          id: element.id,
          description: element['description'],
          price: element['price'].toDouble(),
          title: element['name'],
          idCategory: element['idCategory'],
          isPopular: element['isPopular'],
        );
        newList.add(dellData!);
      },
    );
    dellDataList = newList;
  }

  List<Product> get getDellList {
    return dellDataList;
  }

//* Mac
  Product? macData;
  List<Product> macDataList = [];
  Future<void> getMacData() async {
    List<Product> newList = [];
    QuerySnapshot macSnapShot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('6UOoDK3ZDgBRd3o5jJYS')
        .collection('Mac')
        .get();
    macSnapShot.docs.forEach(
      (element) {
        macData = Product(
          image: element['image'],
          idCategory: element['idCategory'],
          id: element.id,
          description: element['description'],
          price: element['price'].toDouble(),
          title: element['name'],
          isPopular: element['isPopular'],
        );
        newList.add(macData!);
      },
    );
    macDataList = newList;
  }

  List<Product> get getMacList {
    return macDataList;
  }

//* Find Popular Products chưa có hết data
  Product? popularData;
  List<Product> allDataList = [];
  List<Product> popularDataList = [];
  Future<void> getPopularData() async {
    List<Product> newList = [];
    allDataList = macDataList + dellDataList + acerDataList;
    allDataList.forEach((item) => item.isPopular ? newList.add(item) : null);
    popularDataList = newList;
  }

  List<Product> get getPopularList {
    return popularDataList;
  }
}
