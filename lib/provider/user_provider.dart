import 'package:ecommerceapp/models/cart_item.dart';
import 'package:ecommerceapp/models/order.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/orders.dart';
import 'package:ecommerceapp/services/users.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class UserProvider with ChangeNotifier {
  auth.FirebaseAuth _auth;
  auth.User _user;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();

  UserModel _userModel;

  //  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  auth.User get user => _user;
  // public variables
  List<OrderModel> orders = [];

  UserProvider.initialize(): _auth = auth.FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async{
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async{
    print('singUp');
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((data) {
        Map<String, dynamic> values = {
         "uid": data.user.uid,
         "name": name,
         "email": email,
         "phoneNumber": null,
         "emailVerified": null,
         "stripeId": '',
          "cart": [],
        };
        print(values);
        _userServices.createUser(values);
      })
      .catchError((error) {
        print(error.toString());
      });
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    googleSignIn.signOut();
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(auth.User user) async {
    if(user == null){
      _status = Status.Unauthenticated;
      notifyListeners();
    } else {
      print(user);
      print(user.uid);
      print(_status);
      _status = Status.Authenticated;
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      print("CART ITEMS: ${_userModel.cart}");
      print("CART ITEMS: ${_userModel.cart.length}");
      print("CART ITEMS: ${_userModel.totalCartPrice}");
      print("CART ITEMS: ${_userModel.cart.length}");
      notifyListeners();
    }
  }

  Future<bool> addToCart(
      {ProductModel product, String size, String color, int quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.picture,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity,
        "size": size,
        "color": color,
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      print("CART ITEMS ARE: ${cart.toString()}");
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem})async{
    print("THE PRODUC IS: ${cartItem.toString()}");

    try{
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }

  getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<void> reloadUserModel()async{
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
}