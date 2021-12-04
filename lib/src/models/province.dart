import 'dart:convert';

class Province {
  final String name;
  final String nameWithType;
  final String type;
  final String code;
  Province(
      {required this.name,
      required this.nameWithType,
      required this.type,
      required this.code});

  Province copyWith({
    String? name,
    String? nameWithType,
    String? type,
    String? code,
  }) {
    return Province(
      name: name ?? this.name,
      nameWithType: nameWithType ?? this.nameWithType,
      type: type ?? this.type,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nameWithType': nameWithType,
      'type': type,
      'code': code,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      name: map['name'],
      nameWithType: map['name_with_type'],
      type: map['type'],
      code: map['code'],
    );
  }

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
        name: json['name'],
        nameWithType: json['name_with_type'],
        type: json['type'],
        code: json['code']);
  }
  static List<Province> fromJsonList(List list) {
    return list.map((e) => Province.fromJson(e)).toList();
  }

  bool isEqual(Province model) {
    return this.code == model.code;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return nameWithType;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Province &&
        other.name == name &&
        other.nameWithType == nameWithType &&
        other.type == type &&
        other.code == code;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        nameWithType.hashCode ^
        type.hashCode ^
        code.hashCode;
  }
}
