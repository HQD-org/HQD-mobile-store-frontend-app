import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_store/src/models/data_product_model.dart';
import 'package:mobile_store/src/models/product_cart_model.dart';

class CartModel {
  String id;
  String status;
  String user;
  List<ProductCartModel> products;
  List<DataProductModel> dataProduct;
  CartModel({
    required this.id,
    required this.status,
    required this.user,
    required this.products,
    required this.dataProduct,
  });

  CartModel copyWith({
    String? id,
    String? status,
    String? user,
    List<ProductCartModel>? products,
    List<DataProductModel>? dataProduct,
  }) {
    return CartModel(
      id: id ?? this.id,
      status: status ?? this.status,
      user: user ?? this.user,
      products: products ?? this.products,
      dataProduct: dataProduct ?? this.dataProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'user': user,
      'products': products.map((x) => x.toMap()).toList(),
      'dataProduct': dataProduct.map((x) => x.toMap()).toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'],
      status: map['status'],
      user: map['user'],
      products: List<ProductCartModel>.from(
          map['products']?.map((x) => ProductCartModel.fromMap(x))),
      dataProduct: List<DataProductModel>.from(
          map['dataProduct']?.map((x) => DataProductModel.fromMap(x))),
    );
  }
  static List<CartModel> fromJsonList(List list) {
    return list.map((e) => CartModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartModel(id: $id, status: $status, user: $user, products: $products, dataProduct: $dataProduct)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.id == id &&
        other.status == status &&
        other.user == user &&
        listEquals(other.products, products) &&
        listEquals(other.dataProduct, dataProduct);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        user.hashCode ^
        products.hashCode ^
        dataProduct.hashCode;
  }
}
