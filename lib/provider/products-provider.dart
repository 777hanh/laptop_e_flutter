import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/product.dart';

class Products_Provider {
  List<Product> allProductDataList = [];
  List<Product> asusProductDataList = [];

  final CollectionReference allProductCollection =
      FirebaseFirestore.instance.collection('products');
  Stream<List<Product>> get allProducts {
    return allProductCollection.snapshots().map((snapshot) {
      return _listAllProductsFromSnapShot(snapshot);
    });
  }

  final CollectionReference asusProductCollection =
      FirebaseFirestore.instance.collection('products');
  Stream<List<Product>> get asusProducts {
    return allProductCollection.snapshots().map((snapshot) {
      return _listAsusProductsFromSnapShot(snapshot);
    });
  }

  List<Product> _listAllProductsFromSnapShot(QuerySnapshot snapshot) {
    List<Product> newList = [];
    snapshot.docs.asMap().forEach((index, element) {
      Product product = Product(
        image: element['image'],
        id: element.id,
        description: element['description'],
        price: element['price'].toDouble(),
        title: element['name'],
        isPopular: element['isPopular'],
        idCategory: element['idCategory'],
      );
      newList.add(product);
    });
    return newList;
  }

  List<Product> _listAsusProductsFromSnapShot(QuerySnapshot snapshot) {
    List<Product> newList = [];
    snapshot.docs.asMap().forEach((index, element) {
      Product product = Product(
        image: element['image'],
        id: element.id,
        description: element['description'],
        price: element['price'].toDouble(),
        title: element['name'],
        isPopular: element['isPopular'],
        idCategory: element['idCategory'],
      );
      if (product.idCategory == 2) newList.add(product);
    });
    return newList;
  }
}
