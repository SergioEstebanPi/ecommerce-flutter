import 'package:ecommerceapp/commons/common.dart';
import 'package:ecommerceapp/screens/signup.dart';
import 'package:ecommerceapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final _key = GlobalKey<ScaffoldState>();
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
    if(googleUser != null){
      GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      auth.User firebaseUser;
      await firebaseAuth.signInWithCredential(credential).then((userCredential) => {
        firebaseUser = userCredential.user
      });

      if(firebaseUser != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection("users")
            .where(
            "uid",
            isEqualTo: firebaseUser.uid
        ).get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // insert the user to our collection
          await FirebaseFirestore.instance.collection("users")
              .doc(firebaseUser.uid)
              .set({
            "uid": firebaseUser.uid,
            "name": firebaseUser.displayName,
            "email": firebaseUser.email,
            "phoneNumber": firebaseUser.phoneNumber,
            "emailVerified": firebaseUser.emailVerified,
            "imageUrl": firebaseUser.photoURL,
            "cart": [],
          });
          await preferences.setString("uid", firebaseUser.uid);
          await preferences.setString("name", firebaseUser.displayName);
          await preferences.setString("email", firebaseUser.email);
          await preferences.setString("phoneNumber", firebaseUser.phoneNumber);
          await preferences.setBool(
              "emailVerified", firebaseUser.emailVerified);
          await preferences.setString("imageUrl", firebaseUser.photoURL);
          await preferences.setStringList("cart", []);
        } else {
          await preferences.setString("uid", documents[0]['uid']);
          await preferences.setString("name", documents[0]['name']);
          await preferences.setString("email", documents[0]['email']);
          await preferences.setString(
              "phoneNumber", documents[0]['phoneNumber']);
          await preferences.setBool(
              "emailVerified", documents[0]['emailVerified']);
          await preferences.setString("imageUrl", documents[0]['imageUrl']);
          await preferences.setStringList("cart", []);
        }
        print("DEBUGEAR LOGIN: Login was successful");
        /*
      if (mounted) {
        setState(() {
          loading:
          false;
        });
      }
       */
        /*
      if (mounted) {
        setState(() {
          loading:
          false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            )
        );
      }
       */
      } else {
        print("DEBUGEAR LOGIN: Login failed :(");
        setState(() {
          isLogedin = false;
          loading = false;
        });
      }
    } else {
      print("DEBUGEAR LOGIN: Login failed :(");
      setState(() {
        isLogedin = false;
        loading = false;
      });
    }
  }
  void isSignedIn() async {
    print("DEBUGEAR LOGIN: Firebase login");
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    auth.User firebaseUser = firebaseAuth.currentUser;
    if(firebaseUser != null){
      setState(() {
        isLogedin = true;
      });
    } else {
      setState(() {
        isLogedin = false;
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
      print("DEBUGEAR LOGIN: You are not logged");
    }
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 120,
              bottom: 120,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      blurRadius: 20
                    )
                  ],
                ),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              "images/cart.png",
                              width: 120,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12
                              ),
                              child: ListTile(
                                title: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    icon: Icon(Icons.alternate_email_outlined),
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
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2),
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
                              color: deepOrange,
                              child: MaterialButton(
                                onPressed: () async {
                                  if(_formKey.currentState.validate()){
                                    if(!await user.signIn(
                                      _emailTextController.text,
                                      _passwordTextController.text,
                                    )) {
                                      _key.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text('SignIn failed')
                                          )
                                      );
                                    }
                                  }
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w400
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Signup(),
                                      )
                                  );
                                },
                                child: Text(
                                  'Create an account',
                                  style: TextStyle(
                                    color: black,
                                      fontWeight: FontWeight.w400
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Or',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20
                              )
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Material(
                                child: MaterialButton(
                                    onPressed: () {

                                    },
                                    child: Image.asset(
                                        "images/fb.png",
                                        width: 60
                                    )
                                ),
                              ),
                            ),
                            */
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Material(
                                child: MaterialButton(
                                    onPressed: () {
                                      handleSignIn();
                                    },
                                    child: Image.asset(
                                        "images/ggg.png",
                                        width: 60
                                    )
                                ),
                              ),
                            ),
                          ],
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
                valueColor: AlwaysStoppedAnimation(deepOrange),
              ),
            )
          )
        ],
      ),
    );
  }
}

