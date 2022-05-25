import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/product.dart';

class Products_Provider {
  List<Product> allProductDataList = [];

  final CollectionReference allProductCollection =
      FirebaseFirestore.instance.collection('products');
      
  Stream<List<Product>> get allProducts {
    return allProductCollection.snapshots().map((snapshot) {
      return _listAllProductsFromSnapShot(snapshot);
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
  
}
