import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/auth.dart';
import 'package:store_app/screens/auth_screen.dart';
import 'package:store_app/screens/home_screen.dart';

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
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.brown,
            accentColor: Colors.deepOrange,
          ),
          home: AuthScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
        ),
      ),
    );
  }
}

// Command to get SHA-1 key firebase

//keytool -list -v -keystore "C:\Users\Shamil\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
