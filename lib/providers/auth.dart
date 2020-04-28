import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String userId;

  bool get isAuth{
    return userId !=null;
  }
}