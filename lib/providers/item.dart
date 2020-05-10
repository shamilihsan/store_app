import 'package:flutter/foundation.dart';

class Item with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String category;

  Item({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.category
  });
}
