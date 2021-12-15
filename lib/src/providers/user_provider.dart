import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  double totalPrice = 0;
  UserModel? _user;

  // MARK: getter & setter
  UserModel? get getUser => _user;
  set setUser(UserModel user) {
    _user = user;
  }

  get getPrice => totalPrice;
  set setPrice(double p) {
    totalPrice = p;
    notifyListeners();
  }
}

UserProvider userProvider = UserProvider();
