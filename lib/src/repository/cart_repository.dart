import 'package:http/http.dart';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/repository/base_repository.dart';

class CartRepository {
  Future<Response> addToCartAPI(
      {required String idProduct,
      required String color,
      required String image}) async {
    var dataBody = {"idProduct": idProduct, "color": color, "image": image};
    Response response =
        await BaseRepository().post(ApiGateway.addToCart, dataBody);
    return response;
  }

  Future<Response> updateCartAPI({
    required String idProduct,
    required String color,
    required int quantity,
  }) async {
    var dataBody = {
      "idProduct": idProduct,
      "color": color,
      "quantity": quantity
    };
    Response response =
        await BaseRepository().post(ApiGateway.updateCart, dataBody);
    return response;
  }

  Future<Response> removeCartItemAPI(
      {required String idProduct, required String color}) async {
    var dataBody = {"idProduct": idProduct, "color": color};
    Response response =
        await BaseRepository().post(ApiGateway.removeItem, dataBody);
    return response;
  }

  Future<List<CartModel>?> getdataCartAPI async(){
       Response response = await BaseRepository().get(ApiGateway.);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      //print("dataP: " + jsonResponse.toString());
      return ProductModel.fromJsonList(jsonResponse);
    }
    return null;
  }
}
