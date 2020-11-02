import 'package:ecommerceapp/components/featured_card.dart';
import 'package:flutter/material.dart';

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (_, index){
            return FeaturedCard(
                name: "Winter Blazer",
                price: 50.99,
                picture: ''
            );
          }
      ),
    );
  }
}
