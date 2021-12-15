import 'dart:convert';

class ProductOrderModel {
  final String idProduct;
  final int quantity;
  final String color;
  final String image;
  final int price;
  final String name;
  ProductOrderModel({
    required this.idProduct,
    required this.quantity,
    required this.color,
    required this.image,
    required this.price,
    required this.name,
  });
  // ProductOrderModel(
  //     {required this.idProduct,
  //     required this.quantity,
  //     required this.image,
  //     required this.color,
  //     required this.price,
  //     required this.name});

  Map<String, dynamic> toJson() {
    return {
      'idProduct': idProduct,
      'quantity': quantity,
      'color': color,
      'image': image,
      'price': price,
      'name': name
    };
  }

  //String toJson() => json.encode(toMap());

  ProductOrderModel copyWith({
    String? idProduct,
    int? quantity,
    String? color,
    String? image,
    int? price,
    String? name,
  }) {
    return ProductOrderModel(
      idProduct: idProduct ?? this.idProduct,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      image: image ?? this.image,
      price: price ?? this.price,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idProduct': idProduct,
      'quantity': quantity,
      'color': color,
      'image': image,
      'price': price,
      'name': name,
    };
  }

  factory ProductOrderModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderModel(
      idProduct: map['idProduct'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      color: map['color'] ?? '',
      image: map['image'] ?? '',
      price: map['price']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  //String toJson() => json.encode(toMap());

  factory ProductOrderModel.fromJson(String source) =>
      ProductOrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductOrderModel(idProduct: $idProduct, quantity: $quantity, color: $color, image: $image, price: $price, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductOrderModel &&
        other.idProduct == idProduct &&
        other.quantity == quantity &&
        other.color == color &&
        other.image == image &&
        other.price == price &&
        other.name == name;
  }

  @override
  int get hashCode {
    return idProduct.hashCode ^
        quantity.hashCode ^
        color.hashCode ^
        image.hashCode ^
        price.hashCode ^
        name.hashCode;
  }
}
