import 'package:ecommerceapp/models/cart_item.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/users.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  Status _status = Status.Uninitialized;
  Status get status => _status;
  auth.User get user => _user;
  UserServices _userServices = UserServices();
  UserModel _userModel;

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
         "name": name,
         "email": email,
         "uid": data.user.uid,
         "stripeId": '',
        };
        print(values);
        _userServices.createUser(values);
        _status = Status.Authenticated;
        notifyListeners();
      })
      .catchError((error) {
        print(error.toString());
      });
      return true;
    } catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future singOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(auth.User user) async {
    if(user == null){
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      print("CART ITEMS: ${_userModel.cart}");
      print("CART ITEMS: ${_userModel.cart.length}");
      print("CART ITEMS: ${_userModel.totalCartPrice}");
      print("CART ITEMS: ${_userModel.cart.length}");
      _status = Status.Authenticated;
    }
    notifyListeners();
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

    /*
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
     */

  /*
  getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }
   */

  Future<void> reloadUserModel()async{
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
}