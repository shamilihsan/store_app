import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/widgets/cart_item.dart' as cartItem;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List picked = [false, false];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: mediaQuery.padding.top),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 25.0),
                  Container(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        const Text(
                          'Your',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Text(
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
                  topRight: Radius.circular(75.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 20, left: 20.0, right: 25.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: mediaQuery.size.height - 300.0,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) => cartItem.CartItem(
                          itemId: cart.items.values.toList()[index].id,
                          itemName: cart.items.values.toList()[index].name,
                          quantity: cart.items.values.toList()[index].quantity,
                          price: cart.items.values.toList()[index].price,
                          imageUrl: cart.items.values.toList()[index].imageUrl,
                        ),
                        itemCount: cart.itemCount,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: mediaQuery.size.width - 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).accentColor),
                          child: Text(
                            'Checkout',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        )
                      ],
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
