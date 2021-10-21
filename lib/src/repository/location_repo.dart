import 'package:dio/dio.dart';
import 'package:mobile_store/src/models/province.dart';

const String baseURL = 'https://location-vn.herokuapp.com';

class LocationRepository {
  // bắt API province
  Future<Response> getDataProvince() async {
    var response = await Dio().get("$baseURL/api/province");
    //print('provice statuscode: ${response.statusCode}');
    return response;
  }

  // Bắt API District
  Future<Response> getDataDistrict(String id) async {
    var response = await Dio().get("$baseURL/api/province/$id/district");
    return response;
  }

  // Bắt API Village

  Future<Response> getDataVillage(String id) async {
    var response = await Dio().get("$baseURL/api/district/$id/village");
    return response;
  }
}
