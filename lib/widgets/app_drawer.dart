import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/auth.dart';
import 'package:store_app/providers/cart.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.undo),
            title: Text('Sign Out'),
            onTap: () {
              Provider.of<Cart>(context, listen: false).clear();
              Navigator.of(context).pop();
              // Ensures that the home route autoLogin() function is always called
              Navigator.of(context).pushReplacementNamed('/');

              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
