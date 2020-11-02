import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "users";

  void createUser(Map<String, dynamic> data){
    print('createUser');
    print(data);
    _firestore
      .collection(ref)
      .doc(data["userId"])
      .set(data)
    .then((value) => print('Agregado'))
    .catchError((error) => print('Failed to add user: $error'));
  }
}