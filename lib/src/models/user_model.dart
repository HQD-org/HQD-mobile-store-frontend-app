import 'dart:convert';

import 'package:mobile_store/src/models/address_model.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final Address address;
  final String role;
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.role,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    Address? address,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address.toMap(),
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return UserModel(
      id: map['_id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      address: Address.fromMap(map['address']),
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, phone: $phone, email: $email, address: $address, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.address == address &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        address.hashCode ^
        role.hashCode;
  }
}
