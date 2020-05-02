import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String itemId;
  final String itemName;
  final int price;
  final int quantity;
  final String imageUrl;

  CartItem({
    this.itemId,
    this.itemName,
    this.price,
    this.quantity,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(itemId),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from the card?'),
            elevation: 10,
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text('Yes')),
            ],
          ),
        );
      },
      onDismissed: (direction) {},
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
            title: Text(itemName),
            subtitle: Text('Total: Rs. ${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
    );
  }
}
