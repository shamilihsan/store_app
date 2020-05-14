import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:store_app/providers/auth.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/providers/categories.dart';
import 'package:store_app/providers/items.dart';
import 'package:store_app/providers/item.dart';
import 'package:store_app/providers/orders.dart';
import 'package:store_app/providers/user.dart';
import 'package:store_app/screens/auth_screen.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:store_app/screens/order_screen.dart';
import 'package:store_app/screens/orders_screen.dart';
import 'package:store_app/screens/splash_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        StreamProvider<List<Item>>.value(
          value: Items().items,
        ),
        StreamProvider<List<Category>>.value(
          value: Categories().categories,
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
        ChangeNotifierProvider.value(
          value: Users(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Store App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.cyan,
          ),
          home: authData.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authData.autoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
          },
        ),
      ),
    );
  }
}

// Command to get SHA-1 key firebase

//keytool -list -v -keystore "C:\Users\Shamil\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
