import 'package:ecommerceapp/commons/common.dart';
import 'package:ecommerceapp/services/auth.dart';
import 'package:ecommerceapp/services/users.dart';
import 'package:ecommerceapp/screens/home.dart';
import 'package:ecommerceapp/provider/user_provider.dart';
import 'package:ecommerceapp/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool hideConfirmPass = true;
  bool loading = false;
  Auth authClass = Auth();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[350],
                            blurRadius: 20
                        )
                      ]
                    ),
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          //mainAxisAlignment: MainAxisAlignment.center,
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
                                      title:  TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        icon: Icon(Icons.person_outline),
                                        border: InputBorder.none
                                      ),
                                      keyboardType: TextInputType.name,
                                      controller: _nameTextController,
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'The name field cannot be empty';
                                        } else {
                                          return null;
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
                                        hintText: 'Email',
                                        icon: Icon(Icons.alternate_email_outlined),
                                        border: InputBorder.none,
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
                              child: Container(
                                color: Colors.white.withOpacity(0.2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          'Male',
                                          style: TextStyle(
                                              color: black
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
                                          'Female',
                                          style: TextStyle(
                                              color: black
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
                                        } else {
                                          return null;
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
                                        hintText: 'Confirm password',
                                        icon: Icon(Icons.lock_outline),
                                        border: InputBorder.none
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      controller: _confirmPasswordTextController,
                                      obscureText: hideConfirmPass,
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'The password field cannot be empty';
                                        } else if(value.length < 6) {
                                          return 'The password has to be at least 6 characters';
                                        } else if (_passwordTextController.text != value){
                                          return 'The passwords do not match';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye_outlined
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          hideConfirmPass = !hideConfirmPass;
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
                                      //validateForm();
                                      if(_formKey.currentState.validate()){
                                        if(!await user.signUp(
                                          _nameTextController.text,
                                          _emailTextController.text,
                                          _passwordTextController.text,
                                        )) {
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content: Text('SignUp failed')
                                              )
                                          );
                                          return;
                                        }
                                        changeScreenReplacement(context, HomePage());
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Sign up',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            //Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                    'I already have an account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: deepOrange,
                                      fontSize: 16
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                    'Or Sing up with',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20
                                    )
                                ),
                              ),
                            ),
                            Divider(
                              color: white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                                  child: Material(
                                    child: MaterialButton(
                                        onPressed: () async {
                                          auth.User user = await authClass.googleSignIn();
                                          print('boton');
                                          print(user);
                                          if(user != null){
                                            _userServices.createUser({
                                              "name": user.displayName,
                                              "email": user.email,
                                              "phoneNumber": user.phoneNumber,
                                              "imageURL": user.photoURL,
                                              "uid": user.uid,
                                            });

                                            print('redirigido al home');
                                            changeScreenReplacement(
                                                context,
                                                HomePage()
                                            );
                                          }
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: Text(
                                'Other login in option',
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
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

  valueChanged(e) {
    setState(() {
      if(e == "male") {
        groupValue = e;
        gender = e;
      } else if(e == "female"){
        groupValue = "female";
        gender = e;
      }
    });
  }

  Future validateForm() async {
    print('validateForm');
    FormState formState = _formKey.currentState;
    Map value;
    if(formState.validate()){
      formState.reset();
      auth.User firebaseUser = firebaseAuth.currentUser;
      if(firebaseUser == null) {
        firebaseAuth.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text
        ).then((data) =>
        {
          _userServices.createUser(
            value =
              {
                "uid": data.user.uid,
                "name": _nameTextController.text,
                "email": _emailTextController.text,
                "gender": gender,
              }
          )
        }).catchError((err) => {
          print(err.toString())
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()
            )
        );
      } else {
        print("DEBUGEAR SIGNUP: User registered yet");
      }
    }
  }
}
