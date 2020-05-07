import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_app/providers/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            DateFormat('dd-MM-yyyy hh:mm').format(order.dateTime),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(
                'Rs. ${order.total.toString()}',
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'No. of items ${order.items.length}',
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    );
  }
}
