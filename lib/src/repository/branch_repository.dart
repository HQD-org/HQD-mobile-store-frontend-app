import 'dart:convert';

import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/models/branch_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_store/src/repository/base_repository.dart';

class BranchRepository {
  Future<List<BranchModel>?> getDataBranch() async {
    http.Response response =
        await BaseRepository().get(ApiGateway.getDataBranch);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return BranchModel.fromJsonList(jsonResponse);
    }
    return null;
  }
}
