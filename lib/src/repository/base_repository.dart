import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_store/src/common/shared_preference_user.dart';

 const root_url = "hqd-mobile-store-api.herokuapp.com";
// const root_url = "localhost:8080";

class BaseRepository {
  get(String name, [String? params]) async {
    Map<String, String> paramsObject = {};
    if (params != null)
      params.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    http.Response response = await http.get(
      params == null
          ? Uri.http(root_url, '/' + name)
          : Uri.http(root_url, '/' + name, paramsObject),
      headers: getHeader(),
    );
    return response;
  }

  post(String name, Map<String, dynamic> body) async {
    return await http.post(
      Uri.http(root_url, '/' + name),
      headers: getHeader(),
      body: jsonEncode(body),
    );
  }

  put(String name, Map<String, dynamic> body) async {
    return await http.put(
      Uri.http(root_url, '/' + name),
      headers: getHeader(),
      body: jsonEncode(body),
    );
  }

  delete(String name, {Map<String, dynamic>? body}) async {
    return await http.delete(
      Uri.http(root_url, '/' + name),
      headers: getHeader(),
    );
  }

  getHeader() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization':
          'Bearer ' + (UserSharedPreference.getAccessToken() ?? ''),
    };
  }
}
