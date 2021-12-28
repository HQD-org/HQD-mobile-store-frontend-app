import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_store/src/common/api_gateway.dart';
import 'package:mobile_store/src/models/question_model.dart';
import 'package:mobile_store/src/repository/base_repository.dart';

class QuestionRepository {
  Future<List<QuestionModel>?> getAllQuestionAPI() async {
    Response response = await BaseRepository().get(ApiGateway.getDataQuestion);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return QuestionModel.fromJsonList(jsonResponse);
    }
    return null;
  }
}
