import 'dart:convert';

import 'package:mobile_store/src/models/address_model.dart';

class BranchModel {
  final String id;
  final String name;
  final String status;
  final Address address;
  BranchModel({
    required this.id,
    required this.name,
    required this.status,
    required this.address,
  });

  BranchModel copyWith({
    String? id,
    String? name,
    String? status,
    Address? address,
  }) {
    return BranchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'address': address.toMap(),
    };
  }

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      address: Address.fromMap(map['address']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchModel.fromJson(String source) =>
      BranchModel.fromMap(json.decode(source));
  static List<BranchModel> fromJsonList(List list) {
    return list.map((e) => BranchModel.fromMap(e)).toList();
  }

  @override
  String toString() {
    return 'BranchModel(id: $id, name: $name, status: $status, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BranchModel &&
        other.id == id &&
        other.name == name &&
        other.status == status &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ status.hashCode ^ address.hashCode;
  }
}
