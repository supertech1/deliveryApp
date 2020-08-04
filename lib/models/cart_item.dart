class CartItem {
  final String id, name;
  final double qty, price, subTotal;

  CartItem({this.id, this.name, this.qty, this.price, this.subTotal});
}

class Cart {
  final String usersId;
  List<CartItem> cartItems;
  final String vendorId;
  String deliveryLocation;
  double totalAmount;
  Cart(
      {this.usersId,
      this.cartItems,
      this.vendorId,
      this.deliveryLocation,
      this.totalAmount = 0});
}
