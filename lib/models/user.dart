import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/cart_item.dart';
import 'package:flutter/material.dart';

class UserModel {
  static const ID = 'uid';
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const PHONE_NUMBER = 'phoneNumber';
  static const EMAIL_VERIFIED = 'emailVerified';
  static const CART = 'cart';

  String _id;
  String _name;
  String _email;
  String _phoneNumber;
  bool _emailVerified;
  String _stripeId;
  int _priceSum = 0;

  // getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  bool get emailVerified => _emailVerified;

  // public variable
  List<CartItemModel> cart;
  int totalCartPrice;

  // named constructure
  UserModel.fromSnapshot(DocumentSnapshot data){
    print('fromSnapshot');
    print(data);
    print(data.get(ID));
    print(data.get(NAME));
    _id = data.get(ID);
    _name = data.get(NAME);
    _email = data.get(EMAIL);
    _phoneNumber = data.get(PHONE_NUMBER);
    _emailVerified = data.get(EMAIL_VERIFIED);
    cart = _convertCartItems(data.get(CART) ?? []);
    totalCartPrice = data.get(CART) == null ? 0 : getTotalPrice(cart: data.get(CART));
  }

  int getTotalPrice({List cart}) {
    if(cart == null){
      return 0;
    }
    print('cantidades');
    for(Map cartItem in cart){
      print(cartItem['price']);
      print(cartItem['quantity']);
      _priceSum += cartItem['price'] * cartItem['quantity'];
    }
    int total = _priceSum;
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