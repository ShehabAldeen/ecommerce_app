import 'package:ecommerce_app/authantication/login_screen.dart';
import 'package:ecommerce_app/authantication/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

void showMessage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'))
          ],
        );
      });
}

String isUserHaveAccount() {
  if (FirebaseAuth.instance.currentUser != null) {
    return LoginScreen.routeName;
  }
  return RegisterScreen.routeName;
}

