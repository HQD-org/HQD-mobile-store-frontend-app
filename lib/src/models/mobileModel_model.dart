import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_store/src/models/color_image_model.dart';

class MobileModel {
  String id;
  String memoryStick;
  String status;
  String description;
  String name;
  String screen;
  String operation;
  String rearCamera;
  String frontCamera;
  String sim;
  String chip;
  String battery;
  String charger;
  String timeDebut;
  List<ColorImageModel> color;
  MobileModel({
    required this.id,
    required this.memoryStick,
    required this.status,
    required this.description,
    required this.name,
    required this.screen,
    required this.operation,
    required this.rearCamera,
    required this.frontCamera,
    required this.sim,
    required this.chip,
    required this.battery,
    required this.charger,
    required this.timeDebut,
    required this.color,
  });

  MobileModel copyWith({
    String? id,
    String? memoryStick,
    String? status,
    String? description,
    String? name,
    String? screen,
    String? operation,
    String? rearCamera,
    String? frontCamera,
    String? sim,
    String? chip,
    String? battery,
    String? charger,
    String? timeDebut,
    List<ColorImageModel>? color,
  }) {
    return MobileModel(
      id: id ?? this.id,
      memoryStick: memoryStick ?? this.memoryStick,
      status: status ?? this.status,
      description: description ?? this.description,
      name: name ?? this.name,
      screen: screen ?? this.screen,
      operation: operation ?? this.operation,
      rearCamera: rearCamera ?? this.rearCamera,
      frontCamera: frontCamera ?? this.frontCamera,
      sim: sim ?? this.sim,
      chip: chip ?? this.chip,
      battery: battery ?? this.battery,
      charger: charger ?? this.charger,
      timeDebut: timeDebut ?? this.timeDebut,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memoryStick': memoryStick,
      'status': status,
      'description': description,
      'name': name,
      'screen': screen,
      'operation': operation,
      'rearCamera': rearCamera,
      'frontCamera': frontCamera,
      'sim': sim,
      'chip': chip,
      'battery': battery,
      'charger': charger,
      'timeDebut': timeDebut,
      'color': color.map((x) => x.toMap()).toList(),
    };
  }

  factory MobileModel.fromMap(Map<String, dynamic> map) {
    return MobileModel(
      id: map['_id'],
      memoryStick: map['memoryStick'],
      status: map['status'],
      description: map['description'],
      name: map['name'],
      screen: map['screen'],
      operation: map['operation'],
      rearCamera: map['rearCamera'],
      frontCamera: map['frontCamera'],
      sim: map['sim'],
      chip: map['chip'],
      battery: map['battery'],
      charger: map['charger'],
      timeDebut: map['timeDebut'],
      color: List<ColorImageModel>.from(
          map['color']?.map((x) => ColorImageModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MobileModel.fromJson(String source) =>
      MobileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MobileModel(id: $id, memoryStick: $memoryStick, status: $status, description: $description, name: $name, screen: $screen, operation: $operation, rearCamera: $rearCamera, frontCamera: $frontCamera, sim: $sim, chip: $chip, battery: $battery, charger: $charger, timeDebut: $timeDebut, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MobileModel &&
        other.id == id &&
        other.memoryStick == memoryStick &&
        other.status == status &&
        other.description == description &&
        other.name == name &&
        other.screen == screen &&
        other.operation == operation &&
        other.rearCamera == rearCamera &&
        other.frontCamera == frontCamera &&
        other.sim == sim &&
        other.chip == chip &&
        other.battery == battery &&
        other.charger == charger &&
        other.timeDebut == timeDebut &&
        listEquals(other.color, color);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        memoryStick.hashCode ^
        status.hashCode ^
        description.hashCode ^
        name.hashCode ^
        screen.hashCode ^
        operation.hashCode ^
        rearCamera.hashCode ^
        frontCamera.hashCode ^
        sim.hashCode ^
        chip.hashCode ^
        battery.hashCode ^
        charger.hashCode ^
        timeDebut.hashCode ^
        color.hashCode;
  }
}
