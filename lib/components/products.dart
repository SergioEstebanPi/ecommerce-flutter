import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      'name': 'camisa',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'camisa',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'camisa',
      'picture': 'images/vestidos.jpg',
      'old_price': 25,
      'price': 16
    },
    {
      'name': 'camisa',
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
              onTap: () {},
              child: GridTile(
                child: Image.asset(
                  productPicture,
                  fit: BoxFit.cover,
                ),
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                        productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    title: Text(
                      '\$$productPrice',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    subtitle: Text(
                    '\$$productOldPrice',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
}
