import 'dart:convert';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/models/coupon_model.dart';

import 'package:mobile_store/src/repository/base_repository.dart';
import 'package:http/http.dart' as http;

class CouponRepository {
  Future<List<CouponModel>?> getDataCouponAPI() async {
    http.Response response =
        await BaseRepository().get(ApiGateway.getDataCoupon);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return CouponModel.fromJsonList(jsonResponse);
    }
    return null;
  }

  Future<CouponModel?> getDataCouponByName(String param) async {
    http.Response response =
        await BaseRepository().get(ApiGateway.getDataCouponByName, param);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return CouponModel.fromMap(jsonResponse);
    }
    return null;
  }

  Future<http.Response> applyCouponAPI(String id) async {
    var dataBody = {"id": id};
    http.Response response =
        await BaseRepository().post(ApiGateway.applyCoupon, dataBody);
    return response;
  }
}
