import 'package:ecommerceapp/pages/home.dart';
import 'package:ecommerceapp/pages/splash.dart';
import 'package:ecommerceapp/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/pages/login.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider(
        create: (_) => UserProvider.initialize(),
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