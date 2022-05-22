import 'package:flutter/material.dart';

class Product {
  final String id, title, description;
  final String image;
  final double price;
  final int idCategory;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    this.idCategory = 0,
    this.isFavourite = false,
    this.isPopular = false,
  });
}

List<Product> demoProduct = [
  Product(
      id: '1',
      title: 'Laptop Asus Gaming Rog Strix G15 G513IH HN015W',
      price: 19700000,
      image:
          'https://image.cellphones.com.vn/358x/media/catalog/product/1/_/1_69_35.jpg',
      description: description,
      isFavourite: true,
      isPopular: true),
  Product(
      id: '2',
      title: 'Laptop Apple Macbook Air Retina MREE2LL/A',
      price: 21789000,
      image:
          'https://macstores.vn/wp-content/uploads/2019/04/macbook-air-13inch-mre82-5.jpg',
      description: description,
      isFavourite: true,
      isPopular: false),
  Product(
      id: '3',
      title: 'HP Pavilion 13-bb0730ng',
      price: 9990000,
      image:
          'https://www.notebookcheck.net/uploads/tx_nbc2/HPPavilion13-b__1__03.jpg',
      description: description,
      isFavourite: false,
      isPopular: true),
  Product(
      id: '4',
      title: 'Laptop Lenovo ThinkPad E14 Gen 2 i5',
      price: 13490000,
      image:
          'https://phucanhcdn.com/media/product/41872_thinkpad_e14_gen_2_ha2.jpg',
      description: description,
      isFavourite: false,
      isPopular: true),
];

String description =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.';
