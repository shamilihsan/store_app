import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  String _userId;

  bool get isAuth {
    return _userId != null;
  }

  Future<void> login(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      _userId = user.uid;

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', _userId);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(
      String email, String password, String name, String contactNumber) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = name;

      await user.updateProfile(updateInfo);
      await user.reload();

      FirebaseUser updatedUser = await FirebaseAuth.instance.currentUser();

      await usersCollection.document(user.uid).setData({
        'email': user.email,
        'name': updatedUser.displayName,
        'contactNumber': contactNumber,
      });

      _userId = user.uid;

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', _userId);
    } catch (error) {
      throw error;
    }
  }

  Future<void> autoLogin() async {
    // prefs contains the data and not a Future since await is used
    final prefs = await SharedPreferences.getInstance();

    // Quit function since userId is null
    if (!prefs.containsKey('userId')) {
      return;
    }

    _userId = prefs.getString('userId');
    notifyListeners();
  }

  Future<void> logout() async {
    _userId = null;
    notifyListeners();

    await FirebaseAuth.instance.signOut();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
