import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/models/brand_model.dart';
import 'package:mobile_store/src/repository/base_repository.dart';

class BrandRepository {
  Future<List<BrandModel>?> getAllBrandAPI() async {
    Response response = await BaseRepository().get(ApiGateway.getAllBrand);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      var list = BrandModel.fromJsonList(data);
      //print(data.toString());
      return list;
    }
    return null;
  }
}
