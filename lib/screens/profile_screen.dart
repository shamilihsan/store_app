import 'package:flutter/material.dart';
import 'package:store_app/widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
