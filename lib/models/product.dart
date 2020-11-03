import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel {
  static const ID = 'id';
  static const NAME = 'name';
  static const DESCRIPTION = 'description';
  static const CATEGORY = 'category';
  static const PRICE = 'price';
  static const BRAND = 'brand';
  static const COLORS = 'colors';
  static const QUANTITY = 'quantity';
  static const SIZES = 'sizes';
  static const ON_SALE = 'onSale';
  static const FEATURED = 'featured';
  static const PICTURE = 'imageUrl';

  String _id;
  String _name;
  String _description;
  String _category;
  String _brand;
  int _price;
  int _quantity;
  List _colors;
  List _sizes;
  bool _onSale;
  bool _featured;
  String _picture;

  // getters
  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get category => _category;
  String get brand => _brand;
  int get price => _price;
  int get quantity => _quantity;
  List get colors => _colors;
  List get sizes => _sizes;
  bool get onSale => _onSale;
  bool get featured => _featured;
  String get picture => _picture;

  // named constructure
  ProductModel.fromSnapshot(DocumentSnapshot snapshot){
    print(snapshot);
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _description = data[DESCRIPTION];
    _category = data[CATEGORY];
    _brand = data[BRAND];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _colors = data[COLORS];
    _sizes = data[SIZES];
    _onSale = data[ON_SALE];
    _featured = data[FEATURED];
    _picture = data[PICTURE];
  }

}