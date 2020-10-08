import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  String gender;
  String groupValue = "male";
  bool loading = false;
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
                                  hintText: 'Name',
                                  icon: Icon(Icons.person_outline),
                                ),
                                keyboardType: TextInputType.name,
                                controller: _nameTextController,
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'The name field cannot be empty';
                                  } else {
                                    return 'null';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Container(
                            color: Colors.white.withOpacity(0.5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'male',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    trailing: Radio(
                                        value: "male",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'female',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    trailing: Radio(
                                      value: "female",
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e),
                                    ),
                                  ),
                                )
                              ],
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  icon: Icon(Icons.alternate_email_outlined),
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  icon: Icon(Icons.lock_outline),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passwordTextController,
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'The password field cannot be empty';
                                  } else if(value.length < 6) {
                                    return 'The password has to be at least 6 characters';
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Confirm password',
                                  icon: Icon(Icons.lock_outline),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                controller: _confirmPasswordTextController,
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'The password field cannot be empty';
                                  } else if(value.length < 6) {
                                    return 'The password has to be at least 6 characters';
                                  }
                                },
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
                                  'Sign up',
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
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red
                              )
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
                                  //handleSignIn();
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

  valueChanged(e) {
    setState(() {
      if(e == "male"){
        groupValue = e;
      } else if(e == "female"){
        groupValue = "female";
      }
    });
  }
}
