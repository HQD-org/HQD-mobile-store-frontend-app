import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/models/user_model.dart';
import 'package:mobile_store/src/repository/base_repository.dart';

const String baseURL = 'hqd-mobile-store-api.herokuapp.com';

class UserRepository {
  Future<UserModel?> getMyProfile() async {
    Response response = await BaseRepository().get(ApiGateway.profile);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      print(" infor User: " + jsonResponse.toString());
      return UserModel.fromMap(jsonResponse['user']);
    }
    return null;
  }
}
