import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:store_app/providers/cart.dart';
import 'package:store_app/providers/orders.dart';
import 'package:store_app/widgets/app_drawer.dart';
import 'package:store_app/widgets/cart_item.dart' as cartItem;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;

  order(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     icon: Icon(Icons.arrow_back_ios),
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   centerTitle: true,
      // ),
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
                                onPressed: () => Navigator.of(context).pop()),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
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
                          'Cart',
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        )
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(75.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 20, left: 20.0, right: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Container(
                        child: cart.itemCount == 0
                            ? (SvgPicture.asset('assets/images/empty_cart.svg'))
                            : ListView.builder(
                                itemBuilder: (ctx, index) => cartItem.CartItem(
                                  itemId: cart.items.values.toList()[index].id,
                                  itemName:
                                      cart.items.values.toList()[index].name,
                                  quantity: cart.items.values
                                      .toList()[index]
                                      .quantity,
                                  price:
                                      cart.items.values.toList()[index].price,
                                  imageUrl: cart.items.values
                                      .toList()[index]
                                      .imageUrl,
                                ),
                                itemCount: cart.itemCount,
                              ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : cart.itemCount == 0
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(75.0),
                                      topRight: const Radius.circular(75.0),
                                    ),
                                  ),
                                  width: mediaQuery.size.width,
                                  child: Center(
                                    child: Text(
                                      'Seems like your cart is empty',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        child: RaisedButton(
                                          onPressed: null,
                                          disabledColor:
                                              Theme.of(context).accentColor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  'Total : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  'Rs. ${cart.totalAmount}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    RaisedButton(
                                      textColor: Colors.white,
                                      color: Theme.of(context).accentColor,
                                      onPressed: () {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        Provider.of<Orders>(context,
                                                listen: false)
                                            .addOrder(
                                                cart.items.values.toList(),
                                                cart.totalAmount)
                                            .then((_) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          cart.clear();
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title:
                                                  Text('Order has been placed'),
                                              content: Text(
                                                  'Your order has been placed successfully!'),
                                              elevation: 10,
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('Okay')),
                                              ],
                                            ),
                                          ).then((_) {
                                            Navigator.of(context).pop();
                                          });
                                        });
                                      },
                                      child: Text(
                                        'Order',
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
