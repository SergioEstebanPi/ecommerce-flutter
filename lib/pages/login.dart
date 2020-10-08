import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;
  @override
  void initState(){
    super.initState();
    isSignedIn();
  }
  Future handleSignIn() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication .accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    auth.UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
    auth.User firebaseUser = userCredential.user;
    Fluttertoast.showToast(msg: "" + userCredential.toString());
    Fluttertoast.showToast(msg: "" + firebaseUser.displayName);
    //User firebaseUser = () as User;
    if(firebaseUser != null){
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where(
            "id",
            isEqualTo: firebaseUser.uid
        ).get();
      final List<DocumentSnapshot> documents = result.docs;
      if(documents.length == 0) {
        // insert the user to our collection
        FirebaseFirestore.instance.collection("users")
            .doc(firebaseUser.uid)
            .set({
              "id": firebaseUser.uid,
              "username": firebaseUser.displayName,
              "profilePicture": firebaseUser.photoURL
            });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("profilePicture", firebaseUser.photoURL);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("profilePicture", documents[0]['photoUrl']);
      }
      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading: false;
      });

    } else {
      Fluttertoast.showToast(msg: "You are not logged");
    }
  }
  void isSignedIn() async {
    Fluttertoast.showToast(msg: "Firebase login");
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    if(isLogedin){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(),
          )
      );
    } else {
      Fluttertoast.showToast(msg: "You are not lg");
    }
    setState(() {
      loading: false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
      elevation: 0.1,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        'Login',
        style: TextStyle(
          color: Colors.red.shade900
        ),
      ),
      ),
      body: Stack(
        children: [
          Center(
            child: FlatButton(
              color: Colors.red.shade900,
              onPressed: () {
                handleSignIn();
                Fluttertoast.showToast(msg: "click");
              },
              child: Text(
                'Sign In/ Sign Up with Google',
                style: TextStyle(
                  color: Colors.white
                ),
              ),

            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            )
          )
        ],
      ),
    );
  }
}

