import 'dart:convert';

class Village {
  final String code;
  final String name_with_type;
  Village({
    required this.code,
    required this.name_with_type,
  });

  Village copyWith({
    String? code,
    String? name_with_type,
  }) {
    return Village(
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

  factory Village.fromMap(Map<String, dynamic> map) {
    return Village(
      code: map['code'],
      name_with_type: map['name_with_type'],
    );
  }

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(code: json['code'], name_with_type: json['name_with_type']);
  }

  static List<Village> fromJsonList(List list) {
    return list.map((e) => Village.fromJson(e)).toList();
  }

  bool isEqual(Village model) {
    return this.code == model.code;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => name_with_type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Village &&
        other.code == code &&
        other.name_with_type == name_with_type;
  }

  @override
  int get hashCode => code.hashCode ^ name_with_type.hashCode;
}
