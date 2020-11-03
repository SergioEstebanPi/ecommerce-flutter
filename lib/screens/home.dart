import 'package:ecommerceapp/commons/common.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/widgets/custom_app_bar.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/widgets/featured_products.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:ecommerceapp/provider/app_provider.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/widgets/product_card.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/widgets/search.dart';
import 'package:ecommerceapp/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/horizontal_listview.dart';
import '../widgets/products.dart';
import 'cart.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    Widget image_carousel = Container(
        height: 200,
        child: Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('images/camisa.jpg'),
            AssetImage('images/jeans.jfif'),
            AssetImage('images/jeans2.jfif'),
            AssetImage('images/vestidos.jpg'),
          ],
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(
              milliseconds: 1000
          ),
          dotSize: 4,
          indicatorBgPadding: 2,
          dotBgColor: Colors.transparent,
        )
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(),
            Search(),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(14),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Featured products'),
                  ),
                )
              ],
            ),
            FeaturedProducts(),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Recent products')),
                ),
              ],
            ),
            ProductCard(
              brand: 'SantosBrand',
              name: 'Lux Blazer',
              price: 24.00,
              onSale: true,
              picture: '',
            ),
            ProductCard(
              brand: 'SantosBrand',
              name: 'Lux Blazer',
              price: 24.00,
              onSale: true,
              picture: '',
            ),
            ProductCard(
              brand: 'SantosBrand',
              name: 'Lux Blazer',
              price: 24.00,
              onSale: true,
              picture: '',
            ),
          ],
        ),
      ),
    );
  }
}
