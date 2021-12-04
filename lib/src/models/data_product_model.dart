import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_store/src/models/color_model.dart';

class DataProductModel {
  String id;
  String status;
  String description;
  String name;
  String idModel;
  String capacity;
  String ram;
  List<ColorModel> color;
  DataProductModel({
    required this.id,
    required this.status,
    required this.description,
    required this.name,
    required this.idModel,
    required this.capacity,
    required this.ram,
    required this.color,
  });

  DataProductModel copyWith({
    String? id,
    String? status,
    String? description,
    String? name,
    String? idModel,
    String? capacity,
    String? ram,
    List<ColorModel>? color,
  }) {
    return DataProductModel(
      id: id ?? this.id,
      status: status ?? this.status,
      description: description ?? this.description,
      name: name ?? this.name,
      idModel: idModel ?? this.idModel,
      capacity: capacity ?? this.capacity,
      ram: ram ?? this.ram,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'description': description,
      'name': name,
      'idModel': idModel,
      'capacity': capacity,
      'ram': ram,
      'color': color.map((x) => x.toMap()).toList(),
    };
  }

  factory DataProductModel.fromMap(Map<String, dynamic> map) {
    return DataProductModel(
      id: map['id'],
      status: map['status'],
      description: map['description'],
      name: map['name'],
      idModel: map['idModel'],
      capacity: map['capacity'],
      ram: map['ram'],
      color: List<ColorModel>.from(
          map['color']?.map((x) => ColorModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataProductModel.fromJson(String source) =>
      DataProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DataProductModel(id: $id, status: $status, description: $description, name: $name, idModel: $idModel, capacity: $capacity, ram: $ram, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataProductModel &&
        other.id == id &&
        other.status == status &&
        other.description == description &&
        other.name == name &&
        other.idModel == idModel &&
        other.capacity == capacity &&
        other.ram == ram &&
        listEquals(other.color, color);
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
        color.hashCode;
  }
}
