import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_store/src/models/product_order_model.dart';
import 'package:mobile_store/src/models/receiver_model.dart';

class OrderModel {
  String id;
  int totalPrice;
  String coupon;
  String user;
  String status;
  List<ProductOrderModel> products;
  String idBranch;
  ReceiverInfo receiveInfo;
  String createdAt;
  String saleId;
  OrderModel(
      {required this.id,
      required this.totalPrice,
      required this.coupon,
      required this.user,
      required this.status,
      required this.products,
      required this.idBranch,
      required this.receiveInfo,
      required this.createdAt,
      required this.saleId});

  OrderModel copyWith(
      {String? id,
      int? totalPrice,
      String? coupon,
      String? user,
      String? status,
      List<ProductOrderModel>? products,
      String? idBranch,
      ReceiverInfo? receiveInfo,
      String? createAt,
      String? saleId}) {
    return OrderModel(
        id: id ?? this.id,
        totalPrice: totalPrice ?? this.totalPrice,
        coupon: coupon ?? this.coupon,
        user: user ?? this.user,
        status: status ?? this.status,
        products: products ?? this.products,
        idBranch: idBranch ?? this.idBranch,
        receiveInfo: receiveInfo ?? this.receiveInfo,
        createdAt: createdAt,
        saleId: saleId ?? this.saleId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalPrice': totalPrice,
      'coupon': coupon,
      'user': user,
      'status': status,
      'products': products.map((x) => x.toMap()).toList(),
      'idBranch': idBranch,
      'receiveInfo': receiveInfo.toMap(),
      'createdAt': createdAt,
      'saleId': saleId
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
        id: map['_id'] ?? '',
        totalPrice: map['totalPrice']?.toInt() ?? 0,
        coupon: map['coupon'] ?? '',
        user: map['user'] ?? '',
        status: map['status'] ?? '',
        products: List<ProductOrderModel>.from(
            map['products']?.map((x) => ProductOrderModel.fromMap(x))),
        idBranch: map['idBranch'] ?? '',
        receiveInfo: ReceiverInfo.fromMap(map['receiveInfo']),
        createdAt: map['createdAt'] ?? '',
        saleId: map['saleId'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  static List<OrderModel> fromJsonList(List list) {
    return list.map((e) => OrderModel.fromMap(e)).toList();
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, totalPrice: $totalPrice, coupon: $coupon, user: $user, status: $status, products: $products, idBranch: $idBranch, receiveInfo: $receiveInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.totalPrice == totalPrice &&
        other.coupon == coupon &&
        other.user == user &&
        other.status == status &&
        listEquals(other.products, products) &&
        other.idBranch == idBranch &&
        other.receiveInfo == receiveInfo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        totalPrice.hashCode ^
        coupon.hashCode ^
        user.hashCode ^
        status.hashCode ^
        products.hashCode ^
        idBranch.hashCode ^
        receiveInfo.hashCode;
  }
}
