import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:store_app/providers/item.dart';

class Items with ChangeNotifier {
  final CollectionReference itemCollection =
      Firestore.instance.collection('items');

  List<Item> _items = [];

  // List<Item> get items {
  //   return [...items];
  // }

  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }

  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Item(
        id: doc.documentID,
        name: doc.data['name'] ?? '',
        description: doc.data['description'] ?? '',
        price: doc.data['price'] ?? 0,
        imageUrl: doc.data['imageUrl'] ?? null,
      );
    }).toList();
  }
}
