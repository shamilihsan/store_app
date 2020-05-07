import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_app/providers/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Theme(
          data: theme,
          child: ExpansionTile(
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
            key: ValueKey(order.id),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: order.items
                      .map((item) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${item.name}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' x ${item.quantity}',
                              ),
                            ],
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    );
  }
}
