import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/screens/cart_screen.dart';

import 'package:store_app/widgets/app_drawer.dart';
import 'package:store_app/widgets/item_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   title: Text('Home'),
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
                              icon: Icon(Icons.menu),
                              color: Colors.white,
                              onPressed: () =>
                                  _scaffoldKey.currentState.openDrawer(),
                            ),
                            IconButton(
                              icon: Icon(Icons.filter_list),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25.0),
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
                        SizedBox(width: 10.0),
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
                padding:
                    const EdgeInsets.only(top: 20, left: 25.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Container(child: ItemList()),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: mediaQuery.size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Container(
                            //   height: 60.0,
                            //   width: 60.0,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //       color: Colors.grey,
                            //       style: BorderStyle.solid,
                            //       width: 1.0,
                            //     ),
                            //     borderRadius: BorderRadius.circular(10.0),
                            //   ),
                            //   child: Center(
                            //     child: Icon(Icons.search, color: Colors.black),
                            //   ),
                            // ),
                            Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, top: 3),
                                        child: Consumer<Cart>(
                                          builder: (_, cartData, ch) => Text(
                                              cartData.itemCount.toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.shopping_basket,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 60.0,
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Theme.of(context).accentColor,
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(CartScreen.routeName),
                                child: Text(
                                  'Checkout',
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 60.0,
                            //   width: 120.0,
                            //   decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: Colors.grey,
                            //           style: BorderStyle.solid,
                            //           width: 1.0),
                            //       borderRadius: BorderRadius.circular(10.0),
                            //       color: Theme.of(context).accentColor),
                            //   child: Center(
                            //     child: Text(
                            //       'Checkout',
                            //       style: TextStyle(
                            //           color: Colors.white, fontSize: 15.0),
                            //     ),
                            //   ),
                            // )
                          ],
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
