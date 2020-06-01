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
          FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemDetailsScreen(
                itemId: item.id,
                itemName: item.name,
                itemPrice: item.price,
                imageUrl: item.imageUrl,
                description: item.description,
              ),
            ),
          );
          // .then((_) => Scaffold.of(context)
          //     .showSnackBar(SnackBar(content: Text("Item added"))));
        },
        child: Card(
          child: ListTile(
            leading: Hero(
              tag: item.id,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  item.imageUrl,
                ),
              ),
            ),
            title: Text(item.name),
            subtitle: Text('Price: Rs. ${(item.price)}'),
            trailing: ButtonTheme(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 0,
              height: 0,
              child: FlatButton(
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
            ),
          ),
        ),
      ),
    );
  }
}
