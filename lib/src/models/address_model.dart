import 'dart:convert';

class Address {
  final String detail;
  final String village;
  final String district;
  final String province;
  Address({
    required this.detail,
    required this.village,
    required this.district,
    required this.province,
  });

  Address copyWith({
    String? detail,
    String? village,
    String? district,
    String? province,
  }) {
    return Address(
      detail: detail ?? this.detail,
      village: village ?? this.village,
      district: district ?? this.district,
      province: province ?? this.province,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'detail': detail,
      'village': village,
      'district': district,
      'province': province,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    print(map);
    return Address(
      detail: map['detail'],
      village: map['village'],
      district: map['district'],
      province: map['province'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) {
    return Address.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'Address(detail: $detail, village: $village, district: $district, province: $province)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.detail == detail &&
        other.village == village &&
        other.district == district &&
        other.province == province;
  }

  @override
  int get hashCode {
    return detail.hashCode ^
        village.hashCode ^
        district.hashCode ^
        province.hashCode;
  }
}
