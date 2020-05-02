import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final int price;
  final int quantity;
  final String imageUrl;

  CartItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.quantity,
    @required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return items.length;
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });

    return total;
  }

  void addToCart(
      String itemId, int price, String name, String imageUrl, int quantity) {
    if (_items.containsKey(itemId)) {
      // Update quantity
      _items.update(
        itemId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        itemId,
        () => CartItem(
          id: itemId,
          name: name,
          price: price,
          imageUrl: imageUrl,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }
}
