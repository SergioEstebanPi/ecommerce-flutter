import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth{
  Future<auth.User> googleSignIn();
}

class Auth implements BaseAuth {
  auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  @override
  Future<auth.User> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );

    try {
      auth.User user = (await _firebaseAuth.signInWithCredential(credential)).user;
      return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}