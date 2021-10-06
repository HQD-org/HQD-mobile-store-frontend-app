import 'dart:convert';

class District {
  final String code;
  final String name_with_type;
  District({
    required this.code,
    required this.name_with_type,
  });

  District copyWith({
    String? code,
    String? name_with_type,
  }) {
    return District(
      code: code ?? this.code,
      name_with_type: name_with_type ?? this.name_with_type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name_with_type': name_with_type,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      code: map['code'],
      name_with_type: map['name_with_type'],
    );
  }

  factory District.fromJson(Map<String, dynamic> json) {
    return District(code: json['code'], name_with_type: json['name_with_type']);
  }

  static List<District> fromJsonList(List list) {
    return list.map((e) => District.fromJson(e)).toList();
  }

  bool isEqual(District model) {
    return this.code == model.code;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => name_with_type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is District &&
        other.code == code &&
        other.name_with_type == name_with_type;
  }

  @override
  int get hashCode => code.hashCode ^ name_with_type.hashCode;
}
