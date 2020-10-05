import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final productDetailName;
  final productDetailPrice;
  final productDetailOldPrice;
  final productDetailPicture;

  ProductDetail({
    this.productDetailName,
    this.productDetailPrice,
    this.productDetailOldPrice,
    this.productDetailPicture
  });

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text("E-commerce App"),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          ),
          IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: null
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.productDetailPicture)
              ),
            ),
          )
        ],
      )
    );
  }
}
