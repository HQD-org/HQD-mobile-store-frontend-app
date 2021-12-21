import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  double totalPrice = 0;
  bool hasCart = false;
  UserModel? _user;

  // MARK: getter & setter
  UserModel? get getUser => _user;
  set setUser(UserModel user) {
    _user = user;
  }

  get getHasCart => hasCart;
  set setHasCart(bool h) {
    hasCart = h;
    notifyListeners();
  }

  get getPrice => totalPrice;
  set setPrice(double p) {
    totalPrice = p;
    notifyListeners();
  }
}

UserProvider userProvider = UserProvider();
