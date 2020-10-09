import 'package:ecommerceapp/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;
  bool hidePass = true;
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
              "photoURL": firebaseUser.photoURL
            });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoURL", firebaseUser.photoURL);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoURL", documents[0]['photoURL']);
      }
      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading: false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          )
      );
    } else {
      Fluttertoast.showToast(msg: "Login failed :(");
    }
  }
  void isSignedIn() async {
    Fluttertoast.showToast(msg: "Firebase login");
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    auth.User firebaseUser = firebaseAuth.currentUser;
    if(firebaseUser != null){
      setState(() {
        isLogedin = true;
      });
    }
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
      body: Stack(
        children: [
          Image.asset(
            'images/familia.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  icon: Icon(Icons.email_outlined),
                                  border: InputBorder.none
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailTextController,
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isNotEmpty) {
                                    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = RegExp(pattern);
                                    if (!regex.hasMatch(value)) {
                                      return 'Please make sure your email address is valid';
                                    } else {
                                      return 'null';
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12
                              ),
                              child: ListTile(
                                title: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _passwordTextController,
                                  obscureText: hidePass,
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'The password field cannot be empty';
                                    } else if(value.length < 6) {
                                      return 'The password has to be at least 6 characters';
                                    }
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = !hidePass;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red,
                              child: MaterialButton(
                                onPressed: (){
                                  Fluttertoast.showToast(msg: 'ok');
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Text(
                            'Forgot password',
                            style: TextStyle(
                                color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()
                                )
                              );
                            },
                            child: Text(
                              ' Sign up!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red
                              )
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Text(
                            'Other login in option',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red.shade900,
                              child: MaterialButton(
                                onPressed: (){
                                  handleSignIn();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Google',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.9),
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

