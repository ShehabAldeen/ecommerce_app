import 'package:ecommerce_app/firebase_data/user.dart' as AppUser;
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  AppUser.User? user = null;
  int index=1;
  void updateUser(AppUser.User user){
    this.user=user;
    notifyListeners();
  }

  void categoryIndex(int index) {
    this.index=index;
    notifyListeners();
  }
}