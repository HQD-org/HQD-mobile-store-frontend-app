import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile_store/src/models/brand_model.dart';

import 'package:mobile_store/src/models/color_model.dart';
import 'package:mobile_store/src/models/mobileModel_model.dart';

class ProductModel {
  String id;
  String status;
  String description;
  String name;
  String idModel;
  String capacity;
  String ram;
  List<ColorModel> color;
  MobileModel model;
  BrandModel brand;
  ProductModel({
    required this.id,
    required this.status,
    required this.description,
    required this.name,
    required this.idModel,
    required this.capacity,
    required this.ram,
    required this.color,
    required this.model,
    required this.brand,
  });

  ProductModel copyWith({
    String? id,
    String? status,
    String? description,
    String? name,
    String? idModel,
    String? capacity,
    String? ram,
    List<ColorModel>? color,
    MobileModel? model,
    BrandModel? brand,
  }) {
    return ProductModel(
      id: id ?? this.id,
      status: status ?? this.status,
      description: description ?? this.description,
      name: name ?? this.name,
      idModel: idModel ?? this.idModel,
      capacity: capacity ?? this.capacity,
      ram: ram ?? this.ram,
      color: color ?? this.color,
      model: model ?? this.model,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'status': status,
      'description': description,
      'name': name,
      'idModel': idModel,
      'capacity': capacity,
      'ram': ram,
      'color': color.map((x) => x.toMap()).toList(),
      'model': model.toMap(),
      'brand': brand.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      status: map['status'],
      description: map['description'],
      name: map['name'],
      idModel: map['idModel'],
      capacity: map['capacity'] ?? '',
      ram: map['ram'],
      color: List<ColorModel>.from(
          map['color']?.map((x) => ColorModel.fromMap(x))),
      model: MobileModel.fromMap(map['model']),
      brand: BrandModel.fromMap(map['brand']),
    );
  }

  static List<ProductModel> fromJsonList(List list) {
    return list.map((e) => ProductModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, status: $status, description: $description, name: $name, idModel: $idModel, capacity: $capacity, ram: $ram, color: $color, model: $model, brand: $brand)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.status == status &&
        other.description == description &&
        other.name == name &&
        other.idModel == idModel &&
        other.capacity == capacity &&
        other.ram == ram &&
        listEquals(other.color, color) &&
        other.model == model &&
        other.brand == brand;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        description.hashCode ^
        name.hashCode ^
        idModel.hashCode ^
        capacity.hashCode ^
        ram.hashCode ^
        color.hashCode ^
        model.hashCode ^
        brand.hashCode;
  }
}
