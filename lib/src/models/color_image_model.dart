import 'dart:convert';

import 'package:flutter/foundation.dart';

class ColorImageModel {
  List<String> images;
  String name;
  ColorImageModel({
    required this.images,
    required this.name,
  });

  ColorImageModel copyWith({
    List<String>? images,
    String? name,
  }) {
    return ColorImageModel(
      images: images ?? this.images,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'name': name,
    };
  }

  factory ColorImageModel.fromMap(Map<String, dynamic> map) {
    return ColorImageModel(
      images: List<String>.from(map['images']),
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorImageModel.fromJson(String source) =>
      ColorImageModel.fromMap(json.decode(source));

  @override
  String toString() => 'ColorImageModel(images: $images, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorImageModel &&
        listEquals(other.images, images) &&
        other.name == name;
  }

  @override
  int get hashCode => images.hashCode ^ name.hashCode;
}
