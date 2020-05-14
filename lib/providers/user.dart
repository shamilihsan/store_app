import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final CollectionReference usersCollection =
    Firestore.instance.collection('users');

class User with ChangeNotifier {
  final String userId;
  final String email;
  final String name;
  final String address;

  User(
      {@required this.userId,
      @required this.email,
      @required this.name,
      @required this.address});
}

class Users with ChangeNotifier {
  User _user =
      User(userId: '', email: '', name: '', address: '');

  User get user {
    return _user;
  }

  set updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> getUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    var snapshot = await usersCollection.document(firebaseUser.uid).get();

    print(snapshot.data);

    User user = User(
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      userId: firebaseUser.uid,
      address: snapshot.data['address'] ?? '',
    );

    _user = user;
    notifyListeners();
  }
}
