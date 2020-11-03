import 'package:ecommerceapp/services/products.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool isLoading = false;

  void changeIsLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }
}