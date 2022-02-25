import 'package:ecommerce_app/firebase_data/user.dart' as AppUser;
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  AppUser.User? user = null;
  void updateUser(AppUser.User user){
    this.user=user;
    notifyListeners();
  }
}