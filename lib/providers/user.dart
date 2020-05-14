import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  final String userId;
  final String email;
  final String name;
  final String address;

  User(
      {@required this.userId,
      @required this.email,
      @required this.name,
      @required this.address});

  User _user;

  User get user {
    return _user;
  }

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> getUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    var snapshot = await usersCollection.document(firebaseUser.uid).get();

    print(snapshot.data);


  }
}
