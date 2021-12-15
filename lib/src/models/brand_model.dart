import 'dart:convert';

class BrandModel {
  String status;
  String id;
  String name;
  String description;
  String image;
  BrandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.status,
  });

  BrandModel copyWith(
      {String? id,
      String? name,
      String? description,
      String? image,
      String? status}) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'status': status,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        status: json['status']);
  }
  static List<BrandModel> fromJsonList(List list) {
    return list.map((e) => BrandModel.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'BrandModel(id: $id, name: $name, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ image.hashCode;
  }
}
