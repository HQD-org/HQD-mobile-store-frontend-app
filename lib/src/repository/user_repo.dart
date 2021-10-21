import 'package:http/http.dart' as http;

const String baseURL = 'hqd-mobile-store-api.herokuapp.com';

class UserRepository {
  Future<http.Response> getAuthAPI(String token) async {
    // Authorization
    var response =
        await http.get(Uri.https(baseURL, "/auth/get-auth"), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    return response;
  }
}
