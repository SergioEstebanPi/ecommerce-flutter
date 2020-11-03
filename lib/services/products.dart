import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "products";

  Future<List<ProductModel>> getFeaturedProducts() async =>
    _firestore
        .collection(ref)
        .where('featured', isEqualTo: true)
        .get()
        .then((snap){
      List<ProductModel> featuredProducts = [];
      for(DocumentSnapshot product in snap.docs){
        featuredProducts.add(ProductModel.fromSnapshot(product));
      }
      print(featuredProducts);
      return featuredProducts;
    });

  searchProducts({String productName}) {

  }
}