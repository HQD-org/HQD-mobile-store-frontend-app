import 'dart:convert';

class ReceiverInfo {
  final String receiver;
  final String phone;
  final String address;
  final String receiveAt;
  final String timeReceive;
  final String status;
  final String message;
  ReceiverInfo({
    required this.receiver,
    required this.phone,
    required this.address,
    required this.receiveAt,
    required this.timeReceive,
    required this.status,
    required this.message,
  });
  // ReceiverInfo(
  //     {required this.receiver,
  //     required this.phone,
  //     required this.address,
  //     required this.receiveAt,
  //     required this.timeReceive,
  //     // required this.typePayment,
  //     required this.message});

  Map<String, dynamic> toJson() {
    return {
      'receiver': receiver,
      'phone': phone,
      'address': address,
      'receiveAt': receiveAt,
      'timeReceive': timeReceive,
      'status': status,
      'message': message
    };
  }

  //String toJson() => json.encode(toMap());

  ReceiverInfo copyWith({
    String? receiver,
    String? phone,
    String? address,
    String? receiveAt,
    String? timeReceive,
    String? status,
    String? message,
  }) {
    return ReceiverInfo(
      receiver: receiver ?? this.receiver,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      receiveAt: receiveAt ?? this.receiveAt,
      timeReceive: timeReceive ?? this.timeReceive,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiver': receiver,
      'phone': phone,
      'address': address,
      'receiveAt': receiveAt,
      'timeReceive': timeReceive,
      'status': status,
      'message': message,
    };
  }

  factory ReceiverInfo.fromMap(Map<String, dynamic> map) {
    return ReceiverInfo(
      receiver: map['receiver'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      receiveAt: map['receiveAt'] ?? '',
      timeReceive: map['timeReceive'] ?? '',
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }

  //String toJson() => json.encode(toMap());

  factory ReceiverInfo.fromJson(String source) =>
      ReceiverInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReceiverInfo(receiver: $receiver, phone: $phone, address: $address, receiveAt: $receiveAt, timeReceive: $timeReceive, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReceiverInfo &&
        other.receiver == receiver &&
        other.phone == phone &&
        other.address == address &&
        other.receiveAt == receiveAt &&
        other.timeReceive == timeReceive &&
        other.message == message;
  }

  @override
  int get hashCode {
    return receiver.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        receiveAt.hashCode ^
        timeReceive.hashCode ^
        message.hashCode;
  }
}
