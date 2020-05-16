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
  final String contactNumber;

  User(
      {@required this.userId,
      @required this.email,
      @required this.name,
      @required this.address,
      @required this.contactNumber});
}

class Users with ChangeNotifier {
  User _user =
      User(userId: '', email: '', name: '', address: '', contactNumber: '');

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

    User user = User(
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      userId: firebaseUser.uid,
      address: snapshot.data['address'] ?? '',
      contactNumber: snapshot.data['contactNumber'],
    );

    _user = user;
    notifyListeners();
  }

  Future<void> updateAddress(String address) async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    await usersCollection
        .document(firebaseUser.uid)
        .updateData({'address': address});

    return getUser();
  }

  Future<void> updateProfile(String email, String name, String address) async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    await usersCollection
        .document(firebaseUser.uid)
        .updateData({'email': email, 'name': name, 'address': address});

    return getUser();
  }
}
