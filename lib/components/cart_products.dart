import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsOnTheCar = [
    {
      'name': 'camisa',
      'picture': 'images/camisa.jpg',
      'old_price': 25,
      'price': 16,
      'size': 'S',
      'color': 'red',
      'quantity': 1
    },
    {
      'name': 'camisa1',
      'picture': 'images/jeans.jfif',
      'old_price': 25,
      'price': 16,
      'size': 'M',
      'color': 'black',
      'quantity': 2
    },
    {
      'name': 'camisa1',
      'picture': 'images/jeans.jfif',
      'old_price': 25,
      'price': 16,
      'size': 'M',
      'color': 'black',
      'quantity': 2
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productsOnTheCar.length,
        itemBuilder: (context, index){
          return CarProduct(
            carProductName: productsOnTheCar[index]['name'],
            carProductPrice: productsOnTheCar[index]['price'],
            carProductOldPrice: productsOnTheCar[index]['oldPrice'],
            carProductPicture: productsOnTheCar[index]['picture'],
            carProductSize: productsOnTheCar[index]['size'],
            carProductColor: productsOnTheCar[index]['color'],
            carProductQuantity: productsOnTheCar[index]['quantity'],
          );
        },
    );
  }
}

class CarProduct extends StatelessWidget {
  final carProductName;
  final carProductPicture;
  final carProductOldPrice;
  final carProductPrice;
  final carProductSize;
  final carProductColor;
  var carProductQuantity;

  CarProduct({
    this.carProductName,
    this.carProductPicture,
    this.carProductOldPrice,
    this.carProductPrice,
    this.carProductSize,
    this.carProductColor,
    this.carProductQuantity
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          carProductPicture,
          width: 80,
          height: 100,
        ),
        title: Text(carProductName),
        subtitle: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text('Size:')
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                    child: Text(
                      carProductSize,
                      style: TextStyle(
                        color: Colors.red
                      )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                    child: Text('Color:')
                ),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                        carProductColor,
                        style: TextStyle(
                            color: Colors.red
                        )
                    )
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '\$${carProductPrice}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                ),
              ),
            )
          ],
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_drop_up),
                  onPressed: (){
                  },
              ),
              Text('$carProductQuantity'),
              IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: (){
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addQuantity(){
    carProductQuantity += 1;
  }
}
