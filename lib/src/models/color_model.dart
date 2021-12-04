import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_store/src/models/quantityInfo_model.dart';

class ColorModel {
  int price;
  String name;
  List<QuantityInfoModel> quantityInfo;
  ColorModel({
    required this.price,
    required this.name,
    required this.quantityInfo,
  });

  ColorModel copyWith({
    int? price,
    String? name,
    List<QuantityInfoModel>? quantityInfo,
  }) {
    return ColorModel(
      price: price ?? this.price,
      name: name ?? this.name,
      quantityInfo: quantityInfo ?? this.quantityInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'name': name,
      'quantityInfo': quantityInfo.map((x) => x.toMap()).toList(),
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      price: map['price'],
      name: map['name'],
      quantityInfo: List<QuantityInfoModel>.from(
          map['quantityInfo']?.map((x) => QuantityInfoModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) =>
      ColorModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ColorModel(price: $price, name: $name, quantityInfo: $quantityInfo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorModel &&
        other.price == price &&
        other.name == name &&
        listEquals(other.quantityInfo, quantityInfo);
  }

  @override
  int get hashCode => price.hashCode ^ name.hashCode ^ quantityInfo.hashCode;
}
