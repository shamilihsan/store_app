import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/item.dart';
import 'package:store_app/providers/cart.dart';

import 'package:store_app/screens/item_detail_screen.dart';

class ItemListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    //final downloadUrl = FirebaseStorage.instance.ref().getDownloadURL();
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemDetailsScreen(
                itemId: item.id,
                itemName: item.name,
                itemPrice: item.price,
                imageUrl: item.imageUrl,
              ),
            ),
          );
          // .then((_) => Scaffold.of(context)
          //     .showSnackBar(SnackBar(content: Text("Item added"))));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: item.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
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
            FlatButton(
              splashColor: Theme.of(context).accentColor,
              child: Icon(Icons.add, color: Colors.black),
              onPressed: () {
                cart.addToCart(
                    item.id, item.price, item.name, item.imageUrl, 1);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added ${item.name} to cart!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(item.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
