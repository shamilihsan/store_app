import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/item.dart';

class ItemListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    //final downloadUrl = FirebaseStorage.instance.ref().getDownloadURL();
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: item.id,
                    child: Image.asset(
                      'assets/images/breakfast.jpg',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rs. ${item.price}',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.black,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
