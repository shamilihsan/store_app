import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:store_app/providers/cart.dart';
import 'package:store_app/providers/order.dart';
import 'package:store_app/providers/user.dart';

class Orders with ChangeNotifier {
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> getOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Quit function since userId is null
      if (!prefs.containsKey('userId')) {
        return;
      }

      final _userId = prefs.getString('userId');

      var snapshot = await orderCollection
          .where('userId', isEqualTo: _userId)
          .getDocuments();

      _orders = _orderListFromSnapshot(snapshot);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot querySnapshot) {
    List<Order> unorderedList = querySnapshot.documents
        .map((doc) => Order(
              id: doc.documentID,
              dateTime: DateTime.parse(doc.data['dateTime']),
              total: doc.data['total'],
              items: (doc.data['items'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item['id'] ?? '',
                      price: item['price'],
                      quantity: item['quantity'],
                      name: item['name'],
                      imageUrl: item['imageUrl'] ?? '',
                    ),
                  )
                  .toList(),
            ))
        .toList();

    unorderedList.sort((a, b) {
      var aDate = a.dateTime;
      var bDate = b.dateTime;
      return bDate.compareTo(aDate);
    });

    return unorderedList;
  }

  Future<DocumentReference> addOrder(
      List<CartItem> cartItems, int total, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final _userId = prefs.getString('userId');

    User user = Provider.of<Users>(context, listen: false).user;

    return await orderCollection.add({
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
      'dropAddress': user.address,
      'userName': user.name,
      'contactNumber': user.contactNumber
    });
  }
}
