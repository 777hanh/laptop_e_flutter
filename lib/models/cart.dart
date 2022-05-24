class CartModel {
  final String? id;
  final List? products;
  final String? idUser;

  CartModel({this.id, this.products, this.idUser});
}

CartModel demoCart =
    CartModel(id: '9mtBRKujBRxbrVIxaX5s', idUser: 'demouserid', products: [
  {
    'idProduct': '3BfSxTDGHOYrskEtbUTW',
    'quantity': 1,
  },
  {
    'idProduct': '3fqnPoMcO4tZPAWRjoeT',
    'quantity': 1,
  },
]);
