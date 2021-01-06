import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ProductServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "products";

  Future<List<ProductModel>> getFeaturedProducts() async =>
    _firestore
        .collection(ref)
        //.where('featured', isEqualTo: true)
        .get()
        .then((snap){
      List<ProductModel> featuredProducts = [];
      print("product en esta seccion");
      for(DocumentSnapshot product in snap.docs){
        print(product.get('id'));
        print(product.get('price'));
        print(product.get('quantity'));
        print(product.get('name'));
        //print(product.get('description'));
        featuredProducts.add(ProductModel.fromSnapshot(product));
      }
      print(featuredProducts);
      return featuredProducts;
    });

  Future<List<ProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0] + productName.substring(1);
    return _firestore
        .collection(ref)
        .orderBy("name")
        //.startAt([searchKey])
        //.endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
      List<ProductModel> products = [];
      for (DocumentSnapshot product in result.docs) {
        ProductModel productObj = ProductModel.fromSnapshot(product);
        if(
          (productObj.name != null && productObj.name.contains(searchKey))
            || (productObj.description != null && productObj.description.contains(searchKey))
        ) {
          products.add(productObj);
        }
      }
      return products;
    });
  }
}