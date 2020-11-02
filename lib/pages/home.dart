import 'package:ecommerceapp/commons/common.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/components/custom_app_bar.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/components/featured_products.dart';
import 'package:ecommerceapp/pages/login.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/components/product_card.dart';
import 'file:///D:/Usuario/Documentos/SERGIO/flutter/academind/ecommerceapp/lib/components/search.dart';
import 'package:ecommerceapp/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/horizontal_listview.dart';
import '../components/products.dart';
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
      /*
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: deepOrange
        ),
        elevation: 0.1,
        backgroundColor: white,
        title: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1),
          elevation: 0,
          child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none
              ),
              controller: _searchTextController,
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'The search field cannot be empty';
                } else {
                  return null;
                }
              },
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: deepOrange),
              onPressed: null
          ),
          IconButton(
              icon: Icon(Icons.shopping_cart, color: deepOrange),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cart()
                    )
                );
              }
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Sergio Piña'),
              accountEmail: Text('sepi_147@hotmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                        Icons.person,
                        color: Colors.white
                    )
                ),
              ),
              decoration: BoxDecoration(
                  color: deepOrange
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home,color: deepOrange,),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person, color: deepOrange,),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket,color: deepOrange,),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cart()
                    )
                );
              },
              child: ListTile(
                title: Text('Shopping cart'),
                leading: Icon(Icons.shopping_cart,color: deepOrange),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Dashboard'),
                leading: Icon(Icons.dashboard,color: deepOrange),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite, color: deepOrange),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.blue),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.green),
              ),
            ),
            InkWell(
              onTap: () {
                user.singOut();
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.login_outlined, color: deepOrange),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          image_carousel,
          Padding(
            padding: EdgeInsets.all(14),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('Categories'),
            ),
          ),
          HorizontalList(),
          Padding(
            padding: EdgeInsets.all(14),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Recent products')
            ),
          ),
          Flexible(
              child: Products()
          )
        ],
      ),
      */
    );
  }
}
