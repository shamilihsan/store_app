import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/auth.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/screens/orders_screen.dart';
import 'package:store_app/screens/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ])),
        child: Column(
          children: <Widget>[
            SizedBox(height: mediaQuery.padding.top + 20),
            Image.asset('assets/images/logo.png', width: 220),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.shop, color: Colors.white),
              title: Text('Shop', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.white),
              title: Text('Orders', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.portrait, color: Colors.white),
              title: Text('Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.undo, color: Colors.white),
              title: Text('Sign Out', style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}
