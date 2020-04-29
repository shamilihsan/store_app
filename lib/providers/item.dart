import 'package:flutter/foundation.dart';

class Item with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final int price;

  Item({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
  });
}
