import 'package:ecommerce_app/authantication/login_screen.dart';
import 'package:ecommerce_app/authantication/register_screen.dart';
import 'package:ecommerce_app/home/home_screen.dart';
import 'package:ecommerce_app/home/clicked_product_name.dart';
import 'package:ecommerce_app/home/product_details.dart';
import 'package:ecommerce_app/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (builContext)=>AuthProvider(),
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: MyThemeData.lightThemeData,
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName: (buildContext) => RegisterScreen(),
        LoginScreen.routeName: (buildContext) => LoginScreen(),
        HomeScreen.routeName: (buildContext) => HomeScreen(),
        ProductDetails.routeName: (buildContext) => ProductDetails(),
        ClickedCategory.routeName: (buildContext) => ClickedCategory(),
      },
      initialRoute: RegisterScreen.routeName,
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
