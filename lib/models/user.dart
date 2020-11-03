import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/cart_item.dart';
import 'package:flutter/material.dart';

class UserModel {
  static const ID = 'uid';
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const STRIPE_ID = 'stripeId';
  static const CART = 'cart';

  String _id;
  String _name;
  String _email;
  String _stripeId;

  // getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get stripeId => _stripeId;

  // public variable
  List<CartItemModel> cart;
  int totalCartPrice;

  // named constructure
  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    print(snapshot);
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _email = data[EMAIL];
    _stripeId = data[STRIPE_ID] ?? "";
    cart = _convertCartItems(data[CART] ?? []);
    totalCartPrice = data[CART] == null ? 0 : getTotalPrice(cart: data[CART]);
  }

  int getTotalPrice({List cart}) {
    int total = 0;
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      total += cartItem['price'] * cartItem['quantity'];
    }
    print("THE TOTAL IS $total");
    return total;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}