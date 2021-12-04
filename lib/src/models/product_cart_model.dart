import 'dart:convert';

class ProductCartModel {
  int quantity;
  int price;
  String color;
  String image;
  String idProduct;
  ProductCartModel({
    required this.quantity,
    required this.price,
    required this.color,
    required this.image,
    required this.idProduct,
  });

  ProductCartModel copyWith({
    int? quantity,
    int? price,
    String? color,
    String? image,
    String? idProduct,
  }) {
    return ProductCartModel(
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      color: color ?? this.color,
      image: image ?? this.image,
      idProduct: idProduct ?? this.idProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'price': price,
      'color': color,
      'image': image,
      'idProduct': idProduct,
    };
  }

  factory ProductCartModel.fromMap(Map<String, dynamic> map) {
    return ProductCartModel(
      quantity: map['quantity'],
      price: map['price'],
      color: map['color'],
      image: map['image'],
      idProduct: map['idProduct'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCartModel.fromJson(String source) =>
      ProductCartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductCartModel(quantity: $quantity, price: $price, color: $color, image: $image, idProduct: $idProduct)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCartModel &&
        other.quantity == quantity &&
        other.price == price &&
        other.color == color &&
        other.image == image &&
        other.idProduct == idProduct;
  }

  @override
  int get hashCode {
    return quantity.hashCode ^
        price.hashCode ^
        color.hashCode ^
        image.hashCode ^
        idProduct.hashCode;
  }
}
