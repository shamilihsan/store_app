import 'package:store_app/providers/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);

    if (items != null) {
      items.forEach((item) {
        print(item.id);
        print(item.name);
        print(item.description);
        print(item.price);
      });
    }

    return Container();
  }
}
