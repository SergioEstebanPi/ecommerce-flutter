import 'package:ecommerceapp/services/products.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List<ProductModel> _featuredProducts = [];
  ProductServices _productServices = ProductServices();

  AppProvider(){
    getFeaturedProducts();
  }

  AppProvider.initialize() {

  }

  // getter
  List<ProductModel> get featuredProducts => _featuredProducts;

  // methods
  void getFeaturedProducts() async {
    _featuredProducts = await _productServices.getFeaturedProducts();
  }

}