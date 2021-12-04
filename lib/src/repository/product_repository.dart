import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/models/product_model_s.dart';
import 'package:mobile_store/src/repository/base_repository.dart';

class ProductRepository {
  Future<List<ProductModel>?> getAllProduct() async {
    Response response = await BaseRepository().get(ApiGateway.getAllProduct);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      //print("dataP: " + jsonResponse.toString());
      return ProductModel.fromJsonList(jsonResponse);
    }
    return null;
  }
}
