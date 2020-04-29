import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/item.dart';

import 'package:store_app/providers/items.dart';
import 'package:store_app/widgets/app_drawer.dart';
import 'package:store_app/widgets/item_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: Items().items,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: AppDrawer(),
        body: ItemList(),
      ),
    );
  }
}
