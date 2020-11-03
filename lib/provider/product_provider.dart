import 'package:ecommerceapp/services/products.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];


  ProductProvider.initialize(){
    print('loadproducts');
    loadProducts();
  }

  loadProducts()async{
    products = await _productServices.getFeaturedProducts();
    notifyListeners();
  }

  Future search({String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }

}