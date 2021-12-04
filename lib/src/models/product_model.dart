import 'dart:convert';

import 'package:collection/collection.dart';

class Product {
  String productName;
  String price;
  String coupon;
  String imageURL;
  String Screen;
  String OSSystem;
  String frontCamera;
  String rearCamera;
  String chip;
  String RAM;
  String capacity; // Dung lượng
  String sim;
  String Pin;
  String brand;
  String description;
  List<String> Colors;
  Product({
    required this.productName,
    required this.price,
    required this.coupon,
    required this.imageURL,
    required this.Screen,
    required this.OSSystem,
    required this.frontCamera,
    required this.rearCamera,
    required this.chip,
    required this.RAM,
    required this.capacity,
    required this.sim,
    required this.Pin,
    required this.brand,
    required this.description,
    required this.Colors,
  });

  Product copyWith({
    String? productName,
    String? price,
    String? coupon,
    String? imageURL,
    String? Screen,
    String? OSSystem,
    String? frontCamera,
    String? rearCamera,
    String? chip,
    String? RAM,
    String? capacity,
    String? sim,
    String? Pin,
    String? brand,
    String? description,
    List<String>? Colors,
  }) {
    return Product(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      coupon: coupon ?? this.coupon,
      imageURL: imageURL ?? this.imageURL,
      Screen: Screen ?? this.Screen,
      OSSystem: OSSystem ?? this.OSSystem,
      frontCamera: frontCamera ?? this.frontCamera,
      rearCamera: rearCamera ?? this.rearCamera,
      chip: chip ?? this.chip,
      RAM: RAM ?? this.RAM,
      capacity: capacity ?? this.capacity,
      sim: sim ?? this.sim,
      Pin: Pin ?? this.Pin,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      Colors: Colors ?? this.Colors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'price': price,
      'coupon': coupon,
      'imageURL': imageURL,
      'Screen': Screen,
      'OSSystem': OSSystem,
      'frontCamera': frontCamera,
      'rearCamera': rearCamera,
      'chip': chip,
      'RAM': RAM,
      'capacity': capacity,
      'sim': sim,
      'Pin': Pin,
      'brand': brand,
      'description': description,
      'Colors': Colors,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'],
      price: map['price'],
      coupon: map['coupon'],
      imageURL: map['imageURL'],
      Screen: map['Screen'],
      OSSystem: map['OSSystem'],
      frontCamera: map['frontCamera'],
      rearCamera: map['rearCamera'],
      chip: map['chip'],
      RAM: map['RAM'],
      capacity: map['capacity'],
      sim: map['sim'],
      Pin: map['Pin'],
      brand: map['brand'],
      description: map['description'],
      Colors: List<String>.from(map['Colors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(productName: $productName, price: $price, coupon: $coupon, imageURL: $imageURL, Screen: $Screen, OSSystem: $OSSystem, frontCamera: $frontCamera, rearCamera: $rearCamera, chip: $chip, RAM: $RAM, capacity: $capacity, sim: $sim, Pin: $Pin, brand: $brand, description: $description, Colors: $Colors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Product &&
        other.productName == productName &&
        other.price == price &&
        other.coupon == coupon &&
        other.imageURL == imageURL &&
        other.Screen == Screen &&
        other.OSSystem == OSSystem &&
        other.frontCamera == frontCamera &&
        other.rearCamera == rearCamera &&
        other.chip == chip &&
        other.RAM == RAM &&
        other.capacity == capacity &&
        other.sim == sim &&
        other.Pin == Pin &&
        other.brand == brand &&
        other.description == description &&
        listEquals(other.Colors, Colors);
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        price.hashCode ^
        coupon.hashCode ^
        imageURL.hashCode ^
        Screen.hashCode ^
        OSSystem.hashCode ^
        frontCamera.hashCode ^
        rearCamera.hashCode ^
        chip.hashCode ^
        RAM.hashCode ^
        capacity.hashCode ^
        sim.hashCode ^
        Pin.hashCode ^
        brand.hashCode ^
        description.hashCode ^
        Colors.hashCode;
  }
}
