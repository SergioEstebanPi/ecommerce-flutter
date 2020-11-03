import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "users";

  void createUser(Map<String, dynamic> data){
    print('createUser');
    print(data);
    _firestore
      .collection(ref)
      .doc(data["uid"])
      .set(data)
    .then((value) => print('Agregado'))
    .catchError((error) => print('Failed to add user: $error'));
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(ref)
      .doc(id)
      .get()
      .then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}