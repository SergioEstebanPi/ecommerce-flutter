import 'package:ecommerceapp/widgets/cart_products.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text(
            "Cart",
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          )
        ],
      ),
      body: CartProducts(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                  title: Text('Total:'),
                  subtitle: Text('\$235')
              ),
            ),
            Expanded(
                child: MaterialButton(
                onPressed: (){

                },
                color: Colors.red,
                child: Text(
                  'Check out',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
