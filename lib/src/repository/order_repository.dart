import 'dart:convert';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/models/order_model.dart';
import 'package:mobile_store/src/repository/base_repository.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  Future<http.Response> createOrderCODAPI({
    required String coupon,
    required double totalPrice,
    required List<Map<String, dynamic>> products,
    required Map<String, dynamic> receiverInfo,
  }) async {
    var dataBody = {
      "products": products,
      "totalPrice": totalPrice,
      "coupon": coupon,
      "receiveInfo": receiverInfo,
    };
    print(dataBody);
    http.Response response =
        await BaseRepository().post(ApiGateway.crateOrderCOD, dataBody);
    print(jsonDecode(response.body));
    return response;
  }

  Future<http.Response> createOrderOnlineAPI(
      {required String coupon,
      required double totalPrice,
      required Map<String, dynamic> receiverInfo}) async {
    var dataBody = {
      "idBranch": "",
      "coupon": coupon,
      "price": totalPrice,
      "receiveInfo": receiverInfo
    };
    print(dataBody);
    http.Response response =
        await BaseRepository().post(ApiGateway.createOrderOnline, dataBody);
    print(jsonDecode(response.body));
    return response;
  }

  Future<http.Response> paymentOrderSuccessAPI() async {
    http.Response response =
        await BaseRepository().get(ApiGateway.paymentOrderSuccess);
    return response;
  }

  Future<List<OrderModel>?> getDataOrderAPI(String param) async {
    http.Response response =
        await BaseRepository().get(ApiGateway.getDataOrder, param);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return OrderModel.fromJsonList(jsonResponse['orders']);
    }
    return null;
  }

  Future<http.Response> cancelOrderAPI(String idOrder) async {
    var dataBody = {"idOrder": idOrder};
    http.Response response =
        await BaseRepository().post(ApiGateway.cancelOrder, dataBody);
    return response;
  }
  // Future<http.Response> createOrderCODAPI2({
  //   required String idUser,
  //   required String coupon,
  //   required double totalPrice,
  //   required String products,
  //   required String receiverInfo,
  // }) async {
  //   var dataBody = {
  //     "products": products,
  //     "totalPrice": totalPrice,
  //     "coupon": coupon,
  //     "user": idUser,
  //     "receiverInfo": receiverInfo,
  //   };

  //   http.Response response = await http.post(
  //       Uri.https("hqd-mobile-store-api.herokuapp.com", "/order/create"),
  //       headers: BaseRepository().getHeader(),
  //       body: jsonEncode(dataBody));
  //   print(jsonDecode(response.body));
  //   return response;
  // }
}
