import '../models/cart_item.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart(usersId: "", cartItems: [], totalAmount: 0, vendorId: "");

  bool addToCart(String userId, String vendorId, String deliveryLocation,
      CartItem cartItem, double subTotal, bool isStandardOrSoupMeal) {
    //first time of adding to cart
    if (cart.vendorId.isEmpty) {
      cart = Cart(
          usersId: userId, vendorId: vendorId, cartItems: [], totalAmount: 0);
      cart.cartItems.add(cartItem);
      cart.totalAmount += subTotal;
      notifyListeners();
      return true;
    } else {
      //check if the user is still in the same restaurant
      if (cart.vendorId != vendorId) {
        return false;
      }
      //check if it is standard or soup meal so as to just add to cart directly instead of increasing quantity as done for other types of meal
      if (isStandardOrSoupMeal) {
        cart.cartItems.add(cartItem);
        cart.totalAmount += subTotal;
        notifyListeners();

        return true;
      } else {
        //check if the item is in cart before
        int itemIndex = cart.cartItems.indexWhere((element) {
          return element.id == cartItem.id;
        });
        if (itemIndex < 0) {
          //item not in cart
          cart.cartItems.add(cartItem);
          cart.totalAmount += subTotal;
          notifyListeners();

          return true;
        } else {
          //item in cart, update qty
          cart.cartItems[itemIndex] = CartItem(
              id: cartItem.id,
              name: cartItem.name,
              price: cartItem.price,
              qty: cart.cartItems[itemIndex].qty + 1,
              subTotal: cartItem.subTotal);
          cart.totalAmount += subTotal;
          notifyListeners();

          return true;
        }
      }
    }
  }
}
