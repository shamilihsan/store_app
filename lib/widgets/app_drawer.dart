import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/auth.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/screens/orders_screen.dart';
import 'package:store_app/screens/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome'),
            automaticallyImplyLeading: false,
          ),
          Image.asset('assets/images/breakfast.jpg'),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.portrait),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
          ),
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
