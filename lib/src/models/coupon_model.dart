import 'dart:convert';

class CouponModel {
  String name;
  String image;
  int quantity;
  String discountBy;
  int minPriceToApply;
  int discountValue;
  String status;
  int maxDiscount;
  String description;
  String id;
  String startedDate;
  String expiredDate;
  CouponModel({
    required this.name,
    required this.image,
    required this.quantity,
    required this.discountBy,
    required this.minPriceToApply,
    required this.discountValue,
    required this.status,
    required this.maxDiscount,
    required this.description,
    required this.id,
    required this.startedDate,
    required this.expiredDate,
  });

  CouponModel copyWith({
    String? name,
    String? image,
    int? quantity,
    String? discountBy,
    int? minPriceToApply,
    int? discountValue,
    String? status,
    int? maxDiscount,
    String? description,
    String? id,
    String? startedDate,
    String? expiredDate,
  }) {
    return CouponModel(
      name: name ?? this.name,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      discountBy: discountBy ?? this.discountBy,
      minPriceToApply: minPriceToApply ?? this.minPriceToApply,
      discountValue: discountValue ?? this.discountValue,
      status: status ?? this.status,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      description: description ?? this.description,
      id: id ?? this.id,
      startedDate: startedDate ?? this.startedDate,
      expiredDate: expiredDate ?? this.expiredDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'quantity': quantity,
      'discountBy': discountBy,
      'minPriceToApply': minPriceToApply,
      'discountValue': discountValue,
      'status': status,
      'maxDiscount': maxDiscount,
      'description': description,
      'id': id,
      'startedDate': startedDate,
      'expiredDate': expiredDate,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      discountBy: map['discountBy'] ?? '',
      minPriceToApply: map['minPriceToApply']?.toInt() ?? 0,
      discountValue: map['discountValue']?.toInt() ?? 0,
      status: map['status'] ?? '',
      maxDiscount: map['maxDiscount']?.toInt() ?? 0,
      description: map['description'] ?? '',
      id: map['_id'] ?? '',
      startedDate: map['startedDate'] ?? '',
      expiredDate: map['expiredDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponModel.fromJson(String source) =>
      CouponModel.fromMap(json.decode(source));

  static List<CouponModel> fromJsonList(List list) {
    return list.map((e) => CouponModel.fromMap(e)).toList();
  }

  @override
  String toString() {
    return 'CouponModel(name: $name, image: $image, quantity: $quantity, discountBy: $discountBy, minPriceToApply: $minPriceToApply, discountValue: $discountValue, status: $status, maxDiscount: $maxDiscount, description: $description, id: $id, startedDate: $startedDate, expiredDate: $expiredDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CouponModel &&
        other.name == name &&
        other.image == image &&
        other.quantity == quantity &&
        other.discountBy == discountBy &&
        other.minPriceToApply == minPriceToApply &&
        other.discountValue == discountValue &&
        other.status == status &&
        other.maxDiscount == maxDiscount &&
        other.description == description &&
        other.id == id &&
        other.startedDate == startedDate &&
        other.expiredDate == expiredDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        quantity.hashCode ^
        discountBy.hashCode ^
        minPriceToApply.hashCode ^
        discountValue.hashCode ^
        status.hashCode ^
        maxDiscount.hashCode ^
        description.hashCode ^
        id.hashCode ^
        startedDate.hashCode ^
        expiredDate.hashCode;
  }
}
