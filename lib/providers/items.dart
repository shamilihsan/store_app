import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:store_app/providers/item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [...items];
  }

  Future<void> fetchItems() async {
    try {
      final snapshot = await Firestore.instance.collection('Items').snapshots();
      print(snapshot.toString());
    } catch (error) {
      throw error;
    }
  }
}
