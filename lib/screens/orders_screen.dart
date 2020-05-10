import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/orders.dart';
import 'package:store_app/widgets/app_drawer.dart';
import 'package:store_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: mediaQuery.padding.top),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: mediaQuery.size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                              onPressed: () => Navigator.of(context).pop(),
                              // onPressed: () =>
                              //     _scaffoldKey.currentState.openDrawer(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Your',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Orders',
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(75.0),
                  ),
                ),
                child: FutureBuilder(
                    future:
                        Provider.of<Orders>(context, listen: false).getOrders(),
                    builder: (ctx, dataSnapshot) {
                      if (dataSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (dataSnapshot.error != null) {
                          // Error handle
                          return Center(
                            child: Text('Check your connection'),
                          );
                        } else {
                          return Consumer<Orders>(
                              builder: (ctx, orderData, child) {
                            return orderData.orders.length == 0
                                ? Column(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: SvgPicture.asset(
                                            'assets/images/empty_orders.svg',
                                            placeholderBuilder: (BuildContext
                                                    context) =>
                                                Center(
                                                    child:
                                                        const CircularProgressIndicator()),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          width: mediaQuery.size.width,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(70.0),
                                              topRight:
                                                  const Radius.circular(70.0),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Seems like you haven\'t ordered anything.....',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : ListView.builder(
                                    itemBuilder: (ctx, i) =>
                                        OrderItem(orderData.orders[i]),
                                    itemCount: orderData.orders.length,
                                  );
                          });
                        }
                      }
                    }),
              ))
        ],
      ),
    );
  }
}
