import 'package:flutter/material.dart';

class Contact {
  final String contactId;
  final String name;
  final String street;
  final String number;
  final String optional;
  final String cep;
  final String neighborhood;
  final String state;
  final String city;
  final String phone;
  final String phone2;
  final String phone3;
  final String email;
  final String email2;
  final String cpf;
  final String rg;
  final String dayOfBirth;
  final String register;
  Contact({
    @required this.contactId,
    this.name,
    this.street,
    this.number,
    this.optional,
    this.cep,
    this.neighborhood,
    this.state,
    this.city,
    this.phone,
    this.phone2,
    this.phone3,
    this.email,
    this.email2,
    this.cpf,
    this.rg,
    this.dayOfBirth,
    this.register,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      contactId: json['contactId'],
      name: json['name'],
      street: json['street'],
      number: json['number'],
      optional: json['optional'],
      cep: json['cep'],
      neighborhood: json['neighborhood'],
      state: json['state'],
      city: json['city'],
      phone: json['phone'],
      phone2: json['phone2'],
      phone3: json['phone3'],
      email: json['email'],
      email2: json['email2'],
      cpf: json['cpf'],
      rg: json['rg'],
      dayOfBirth: json['dayOfBirth'],
      register: json['register'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contactId': contactId,
      'name': name,
      'street': street,
      'number': number,
      'optional': optional,
      'cep': cep,
      'neighborhood': neighborhood,
      'state': state,
      'city': city,
      'phone': phone,
      'phone2': phone2,
      'phone3': phone3,
      'email': email,
      'email2': email2,
      'cpf': cpf,
      'rg': rg,
      'dayOfBirth': dayOfBirth,
      'register': register,
    };
  }
}
