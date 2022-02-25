import 'package:ecommerce_app/authantication/login_screen.dart';
import 'package:ecommerce_app/authantication/register_screen.dart';
import 'package:ecommerce_app/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemeData.lightThemeData,
      routes: {
        RegisterScreen.routeName: (buildContext) => RegisterScreen(),
        LoginScreen.routeName: (buildContext) => LoginScreen(),
        HomeScreen.routeName: (buildContext) => HomeScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}

class MyThemeData {
  static final ThemeData lightThemeData = ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        color: Color.fromRGBO(0, 0, 0, 1.0),
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 18,
        color: Color.fromRGBO(0, 197, 105, 1.0),
      ),
    ),
  );
}
