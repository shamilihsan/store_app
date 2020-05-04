import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:store_app/providers/cart.dart';

class Orders with ChangeNotifier {
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  Future<DocumentReference> addOrder(
      List<CartItem> cartItems, int total) async {
    final prefs = await SharedPreferences.getInstance();
    final _userId = prefs.getString('userId');

    return orderCollection.add({
      'userId': _userId,
      'total': total,
      'dateTime': DateTime.now().toIso8601String(),
      'items': cartItems
          .map((cartItem) => {
                'id': cartItem.id,
                'name': cartItem.name,
                'quantity': cartItem.quantity,
                'price': cartItem.price,
              })
          .toList(),
    });
  }
}
