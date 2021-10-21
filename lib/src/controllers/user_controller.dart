import 'dart:convert';

import 'package:mobile_store/src/repository/user_repo.dart';

class UserController {
  UserRepository userRepository = UserRepository();

  // bắt API getAuth
  Future<String> getDataAuth(String token) async {
    var repo = await userRepository.getAuthAPI(token);
    if (repo.statusCode == 200) {
      var data = jsonDecode(repo.body);
      return repo.body;
    } else if (repo.statusCode == 403) {
      return "Error auth";
    } else {
      return "Error authen";
    }
  }
}
