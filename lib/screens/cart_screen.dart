import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:store_app/providers/cart.dart';
import 'package:store_app/providers/orders.dart';
import 'package:store_app/providers/user.dart';
import 'package:store_app/widgets/app_drawer.dart';
import 'package:store_app/widgets/cart_item.dart' as cartItem;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  var _isUserLoading = true;
  var address = '';

  @override
  void initState() {
    Provider.of<Users>(context, listen: false)
        .getUser()
        .then((_) => setState(() {
              _isUserLoading = false;
            }));

    super.initState();
  }

  showAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Enter your address'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Your Address'),
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter an address';
                  }
                  return null;
                },
                onChanged: (value) {
                  address = value;
                },
              ),
            ],
          ),
        ),
        elevation: 10,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  // Invalid!
                  return null;
                }
                _formKey.currentState.save();
                Provider.of<Users>(context, listen: false)
                    .updateAddress(address)
                    .then((_) => Navigator.of(context).pop());
              },
              child: Text('Update')),
        ],
      ),
    ).then((_) {
      //Navigator.of(context).pop();
    });
  }

  showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Order has been placed'),
        content: Column(
          children: <Widget>[
            Expanded(
              child: SvgPicture.asset('assets/images/order_confirmed.svg',
                  placeholderBuilder: (BuildContext context) =>
                      Center(child: const CircularProgressIndicator())),
            ),
            Text('Your order has been placed successfully!'),
          ],
        ),
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
  }

  Widget renderEmptyCard(mediaQuery) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 20.0, right: 25.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              child: SvgPicture.asset(
                'assets/images/empty_cart.svg',
                placeholderBuilder: (BuildContext context) =>
                    Center(child: const CircularProgressIndicator()),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(75.0),
                  topRight: const Radius.circular(75.0),
                ),
              ),
              width: mediaQuery.size.width,
              child: Center(
                child: Text(
                  'Seems like your cart is empty.....',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ]);
  }

  Widget renderCart(Cart cart, mediaQuery) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: cart.items.values
                    .toList()
                    .map((ctItem) => cartItem.CartItem(
                          itemId: ctItem.id,
                          itemName: ctItem.name,
                          quantity: ctItem.quantity,
                          price: ctItem.price,
                          imageUrl: ctItem.imageUrl,
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.info,
                    size: 15, color: Theme.of(context).primaryColor),
                SizedBox(width: 5),
                Text(
                  'Swipe left on an item to remove it from the cart',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            Divider(thickness: 2),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                    child: ListTile(
                      title: Text('Drop Off Details'),
                      subtitle: Consumer<Users>(
                        builder: (_, userData, ch) => userData
                                    .user.name.length ==
                                0
                            ? SizedBox(
                                height: 5,
                                width: 20,
                                child: LinearProgressIndicator())
                            : userData.user.address.length == 0
                                ? RaisedButton(
                                    textColor: Colors.white,
                                    color: Theme.of(context).accentColor,
                                    child: Text('Add Address'),
                                    onPressed: () {
                                      showAddressDialog(context);
                                    },
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text('Name : '),
                                            Text(userData.user.name),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Text('Address : '),
                                            Text(userData.user.address),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        RaisedButton(
                                          textColor: Colors.white,
                                          color: Theme.of(context).accentColor,
                                          child: Text('Change Address',
                                              style: TextStyle(fontSize: 12)),
                                          onPressed: () {
                                            showAddressDialog(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    elevation: 3.0,
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      Provider.of<Orders>(context, listen: false)
                          .addOrder(
                              cart.items.values.toList(), cart.totalAmount)
                          .then((_) {
                        setState(() {
                          _isLoading = false;
                        });
                        cart.clear();
                        showOrderSuccessDialog(context);
                      });
                    },
                    child: Text(
                      'Place your Order of Rs. ${cart.totalAmount}',
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            height: mediaQuery.size.height * 1 / 4,
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
                          if (cart.itemCount != 0)
                            IconButton(
                                icon: Icon(Icons.remove_shopping_cart),
                                color: Colors.white,
                                onPressed: () => cart.clear()),
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(75.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                    child: cart.itemCount == 0
                        ? renderEmptyCard(mediaQuery)
                        : renderCart(cart, mediaQuery)),
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
