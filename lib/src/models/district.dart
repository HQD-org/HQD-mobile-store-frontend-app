import 'dart:convert';

class District {
  final String code;
  final String nameWithType;
  District({
    required this.code,
    required this.nameWithType,
  });

  District copyWith({
    String? code,
    String? nameWithType,
  }) {
    return District(
      code: code ?? this.code,
      nameWithType: nameWithType ?? this.nameWithType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'nameWithType': nameWithType,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      code: map['code'],
      nameWithType: map['name_with_type'],
    );
  }

  factory District.fromJson(Map<String, dynamic> json) {
    return District(code: json['code'], nameWithType: json['name_with_type']);
  }

  static List<District> fromJsonList(List list) {
    return list.map((e) => District.fromJson(e)).toList();
  }

  bool isEqual(District model) {
    return this.code == model.code;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => nameWithType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is District &&
        other.code == code &&
        other.nameWithType == nameWithType;
  }

  @override
  int get hashCode => code.hashCode ^ nameWithType.hashCode;
}
