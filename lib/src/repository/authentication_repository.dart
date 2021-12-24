import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/repository/base_repository.dart';

class AuthenticationRepository {
  Future<Response> loginAPI({
    required String username,
    required String password,
  }) async {
    var dataBody = {
      "username": username,
      "password": password,
    };

    Response response = await BaseRepository().post(ApiGateway.login, dataBody);
    print(response.body.toString());

    return response;
  }

  Future<Response> changePassAPI(
      {required String oldPassword, required String newPassword}) async {
    var dataBody = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    Response response =
        await BaseRepository().post(ApiGateway.changePassword, dataBody);
    return response;
  }

  Future<Response> forgotPassAPI({required String email}) async {
    var dataBody = {
      "username": email,
    };
    Response response =
        await BaseRepository().post(ApiGateway.forgotPassword, dataBody);
    return response;
  }

  Future<Response> sendNewPassAPI(
      {required String email, required String otp}) async {
    var dataBody = {"username": email, "otp": otp};
    Response response =
        await BaseRepository().post(ApiGateway.sendNewPassword, dataBody);
    return response;
  }

  Future<Response> updateProfile(
      {required String fullName,
      required String detail,
      required String province,
      required String district,
      required String village,
      required String phone}) async {
    var addressBody = {
      "detail": detail,
      "village": village,
      "district": district,
      "province": province
    };
    var dataBody = {"name": fullName, "phone": phone, "address": addressBody};
    Response response =
        await BaseRepository().post(ApiGateway.updateProfile, dataBody);
    //print(response.toString());
    var jsonResponse = jsonDecode(response.body)['message'];
    print(jsonResponse.toString());
    return response;
  }
}
