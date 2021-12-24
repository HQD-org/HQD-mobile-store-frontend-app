import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/branch_model.dart';
import 'package:mobile_store/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  double totalPrice = 0;
  bool hasCart = false;
  UserModel? _user;
  List<BranchModel>? _listAllDataBranch;

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

  List<BranchModel>? get getAllBranch => _listAllDataBranch;
  set setAllBranch(List<BranchModel> list) {
    _listAllDataBranch = list;
  }
}

UserProvider userProvider = UserProvider();
