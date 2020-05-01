import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/item.dart';

class ItemGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    //final downloadUrl = FirebaseStorage.instance.ref().getDownloadURL();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 58,
            width: double.infinity,
            child: Image.network(
              item.imageUrl.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Text(item.name,),
          Text(item.description),
          Text(item.price.toString()),
        ],
      ),
    );
  }
}
