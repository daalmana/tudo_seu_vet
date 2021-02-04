import 'package:flutter/material.dart';

class Patient {
  final String ownerId;
  final String owner;
  final String patientId;
  final String name;
  final String dayOfBirth;
  final String breed;
  final String sex;
  final String color;
  final String animalType;
  final String chip;
  final String origin;
  final String weight;

  Patient({
    this.ownerId,
    this.owner,
    @required this.patientId,
    this.name,
    this.dayOfBirth,
    this.breed,
    this.sex,
    this.color,
    this.animalType,
    this.chip,
    this.origin,
    this.weight,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      ownerId: json['ownerId'],
      owner: json['owner'],
      patientId: json['patientId'],
      name: json['name'],
      dayOfBirth: json['dayOfBirth'],
      breed: json['breed'],
      sex: json['sex'],
      color: json['color'],
      animalType: json['animalType'],
      chip: json['chip'],
      origin: json['origin'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'owner': owner,
      'patientId': patientId,
      'name': name,
      'dayOfBirth': dayOfBirth,
      'breed': breed,
      'sex': sex,
      'color': color,
      'animalType': animalType,
      'chip': chip,
      'origin': origin,
      'weight': weight,
    };
  }
}
