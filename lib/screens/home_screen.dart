import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/providers/categories.dart';
import 'package:store_app/screens/cart_screen.dart';

import 'package:store_app/widgets/app_drawer.dart';
import 'package:store_app/widgets/badge.dart';
import 'package:store_app/widgets/item_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedCategory = 'All';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final categories = Provider.of<List<Category>>(context);

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
                              icon: Icon(Icons.menu),
                              color: Colors.white,
                              onPressed: () =>
                                  _scaffoldKey.currentState.openDrawer(),
                            ),
                            Row(
                              children: <Widget>[
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      canvasColor:
                                          Theme.of(context).accentColor),
                                  child: categories == null
                                      ? Container(
                                          width: 50,
                                          child: LinearProgressIndicator())
                                      : DropdownButton<String>(
                                          value: selectedCategory,
                                          icon: Icon(
                                            Icons.filter_list,
                                            color: Colors.white,
                                          ),
                                          style: TextStyle(color: Colors.white),
                                          underline: Container(
                                            height: 2,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              selectedCategory = newValue;
                                            });
                                          },
                                          items: categories
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                              key: ValueKey(value),
                                              value: value.name,
                                              child: Text(value.name),
                                            );
                                          }).toList(),
                                        ),
                                ),
                                Consumer<Cart>(
                                  builder: (_, cartData, ch) => Badge(
                                    child: ch,
                                    value: cartData.itemCount.toString(),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.shopping_cart),
                                    color: Colors.white,
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(CartScreen.routeName),
                                  ),
                                )
                              ],
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
                          'Our',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Menu',
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
                  topLeft: Radius.circular(75.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 20.0),
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ItemList(selectedCategory)),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: mediaQuery.size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(70.0),
                            topRight: const Radius.circular(70.0),
                          ),
                        ),
                        child: Consumer<Cart>(
                          builder: (_, cartData, ch) => cartData.itemCount == 0
                              ? Center(
                                  child: Text(
                                    'Seems like your cart is empty.....',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            'Rs. ${cartData.totalAmount}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Text(
                                          '${cartData.itemCount} items in cart',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    RaisedButton(
                                      elevation: 10.0,
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(CartScreen.routeName),
                                      child: Text(
                                        'Cart',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    )
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
