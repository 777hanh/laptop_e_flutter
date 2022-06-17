import 'package:elaptop/screens/cartscreen.dart';

class CartModel {
  final String? id;
  final String? idProduct;
  final String? idUser;
  final double? quantity;
  final String? dateBuy;
  final String? timeBuy;
  final bool? isBuy;

  CartModel(
      {this.id,
      this.idProduct,
      this.idUser,
      this.quantity,
      this.dateBuy,
      this.timeBuy,
      this.isBuy});
}

List<CartModel> demoCart = [
  CartModel(),
];
