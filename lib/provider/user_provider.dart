import 'package:ecommerceapp/services/users.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  UserServices _userServices;
  UserModel userModel;

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
        _userServices.createUser(values);
        _status = Status.Authenticated;
        notifyListeners();
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
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}