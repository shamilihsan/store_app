import 'package:flutter/material.dart';
import 'package:store_app/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Welcome to the store!'),
      ),
    );
  }
}
