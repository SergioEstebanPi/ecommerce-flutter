import 'package:ecommerceapp/commons/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/screens/product_detail.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      'name': 'camisa',
      'picture': 'images/camisa.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'camisa1',
      'picture': 'images/jeans.jfif',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'jeans2',
      'picture': 'images/jeans.jfif',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'Vestidos',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'Vestidos2',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'Vestidos3',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'Vestidos4',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    }
  ];
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      itemBuilder: (BuildContext context, int index){
        return Product(
          productName: productList[index]['name'],
          productPicture: productList[index]['picture'],
          productOldPrice: productList[index]['old_price'],
          productPrice: productList[index]['price'],
        );
      }
    );
  }
}


class Product extends StatelessWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;

  Product({
    this.productName,
    this.productPicture,
    this.productOldPrice,
    this.productPrice
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Hero(
          tag: productName,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductDetail(
                  productDetailName: productName,
                  productDetailPrice: productPrice,
                  productDetailOldPrice: productOldPrice,
                  productDetailPicture: productPicture,
                ))
              ),
              child: GridTile(
                child: Image.asset(
                  productPicture,
                  fit: BoxFit.cover,
                ),
                footer: Container(
                  color: white,
                  height: 70,
                  child: ListTile(
                    title: Text(
                        productName,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18
                        ),
                    ),
                    subtitle: Text(
                      '\$$productOldPrice',
                      style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                    trailing:Text(
                      '\$$productPrice',
                      style: TextStyle(
                          color: deepOrange,
                          fontWeight: FontWeight.w800,
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}