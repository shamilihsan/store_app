import 'package:flutter/foundation.dart';
import 'package:store_app/providers/cart.dart';

class Order with ChangeNotifier {
  final String id;
  final DateTime dateTime;
  final int total;
  final List<CartItem> items;

  Order({
    @required this.id,
    @required this.dateTime,
    @required this.total,
    @required this.items,
  });
}
