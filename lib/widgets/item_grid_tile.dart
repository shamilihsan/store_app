import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/item.dart';

class ItemGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Text(item.name),
          Text(item.description),
          Text(item.price.toString()),
        ],
      ),
    );
  }
}
