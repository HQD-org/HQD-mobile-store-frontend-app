import 'dart:convert';

class QuantityInfoModel {
  int quantity;
  String idBranch;
  QuantityInfoModel({
    required this.quantity,
    required this.idBranch,
  });

  QuantityInfoModel copyWith({
    int? quantity,
    String? idBranch,
  }) {
    return QuantityInfoModel(
      quantity: quantity ?? this.quantity,
      idBranch: idBranch ?? this.idBranch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'idBranch': idBranch,
    };
  }

  factory QuantityInfoModel.fromMap(Map<String, dynamic> map) {
    return QuantityInfoModel(
      quantity: map['quantity'],
      idBranch: map['idBranch'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuantityInfoModel.fromJson(String source) =>
      QuantityInfoModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'QuantityInfoModel(quantity: $quantity, idBranch: $idBranch)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuantityInfoModel &&
        other.quantity == quantity &&
        other.idBranch == idBranch;
  }

  @override
  int get hashCode => quantity.hashCode ^ idBranch.hashCode;
}
