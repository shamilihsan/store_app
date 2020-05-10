import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;

  Category(this.name);
}

class Categories with ChangeNotifier {
  final CollectionReference categoryCollection =
      Firestore.instance.collection('categories');

  Stream<List<Category>> get categories {
    return categoryCollection.snapshots().map(_categoryListFromSnapshot);
  }

  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Category(doc.documentID);
    }).toList();
  }
}
