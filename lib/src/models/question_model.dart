import 'dart:convert';

class QuestionModel {
  String id;
  String questionSentence;
  String answer;
  String status;
  QuestionModel({
    required this.id,
    required this.questionSentence,
    required this.answer,
    required this.status,
  });

  QuestionModel copyWith({
    String? id,
    String? questionSentence,
    String? answer,
    String? status,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionSentence: questionSentence ?? this.questionSentence,
      answer: answer ?? this.answer,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionSentence': questionSentence,
      'answer': answer,
      'status': status,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['_id'] ?? '',
      questionSentence: map['questionSentence'] ?? '',
      answer: map['answer'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source));
  static List<QuestionModel> fromJsonList(List list) {
    return list.map((e) => QuestionModel.fromMap(e)).toList();
  }

  @override
  String toString() {
    return 'QuestionModel(id: $id, questionSentence: $questionSentence, answer: $answer, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionModel &&
        other.id == id &&
        other.questionSentence == questionSentence &&
        other.answer == answer &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        questionSentence.hashCode ^
        answer.hashCode ^
        status.hashCode;
  }
}
