import 'package:ecommerceapp/widgets/featured_card.dart';
import 'package:ecommerceapp/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (_, index){
            return FeaturedCard(
                product: productProvider.products[index],
            );
          }
      ),
    );
  }
}
