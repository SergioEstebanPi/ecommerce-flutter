import 'package:ecommerceapp/services/products.dart';
import 'package:ecommerceapp/screens/home.dart';
import 'package:ecommerceapp/screens/splash.dart';
import 'package:ecommerceapp/provider/app_provider.dart';
import 'package:ecommerceapp/provider/product_provider.dart';
import 'package:ecommerceapp/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/screens/login.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: UserProvider.initialize()),
          ChangeNotifierProvider.value(value: ProductProvider.initialize()),
          ChangeNotifierProvider.value(value: AppProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.red.shade900
          ),
          home: ScreenController(),
        ),
      )
  );
}

class ScreenController extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Splash();
        break;
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
        break;
      case Status.Authenticated:
        return HomePage();
        break;
      default:
        return Login();
        break;
    }
  }
}