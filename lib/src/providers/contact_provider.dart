import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '.././services/firestore_contact_service.dart';
import '.././models/contacts.dart';

class ContactProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _contactId;
  String _name;
  String _phone;
  String _phone2;
  String _phone3;
  String _email;
  String _email2;
  DateTime _dayOfBirth;
  String _street;
  String _number;
  String _neighborhood;
  String _optional;
  String _city;
  String _state;
  String _cep;
  String _rg;
  String _cpf;
  DateTime _register;
  var uuid = Uuid();

  //Getters
  String get contactId => _contactId;
  String get name => _name;
  String get phone => _phone;
  String get phone2 => _phone2;
  String get phone3 => _phone3;
  String get email => _email;
  String get email2 => _email2;
  DateTime get dayOfBirth => _dayOfBirth;
  String get street => _street;
  String get number => _number;
  String get neighborhood => _neighborhood;
  String get optional => _optional;
  String get city => _city;
  String get state => _state;
  String get cep => _cep;
  String get rg => _rg;
  String get cpf => _cpf;
  DateTime get register => _register;
  Stream<List<Contact>> get contacts => firestoreService.getContacts();

  //Setters
  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  set changePhone2(String phone2) {
    _phone2 = phone2;
    notifyListeners();
  }

  set changePhone3(String phone3) {
    _phone3 = phone3;
    notifyListeners();
  }

  set changeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set changeEmail2(String email2) {
    _email2 = email2;
    notifyListeners();
  }

  set changeDayOfBirth(DateTime dayOfBirth) {
    _dayOfBirth = dayOfBirth;
    notifyListeners();
  }

  set changeStreet(String street) {
    _street = street;
    notifyListeners();
  }

  set changeNumber(String number) {
    _number = number;
    notifyListeners();
  }

  set changeNeighborhood(String neighborhood) {
    _neighborhood = neighborhood;
    notifyListeners();
  }

  set changeOptional(String optional) {
    _optional = optional;
    notifyListeners();
  }

  set changeCity(String city) {
    _city = city;
    notifyListeners();
  }

  set changeState(String state) {
    _state = state;
    notifyListeners();
  }

  set changeZipCode(String cep) {
    _cep = cep;
    notifyListeners();
  }

  set changeRg(String rg) {
    _rg = rg;
    notifyListeners();
  }

  set changeCpf(String cpf) {
    _cpf = cpf;
    notifyListeners();
  }

  set changeRegister(DateTime register) {
    _register = register;
    notifyListeners();
  }

  //Functions

  loadAll(Contact contact) {
    if (contact != null) {
      _contactId = contact.contactId;
      _name = contact.name;
      _phone = contact.phone;
      _phone2 = contact.phone2;
      _phone3 = contact.phone3;
      _email = contact.email;
      _email2 = contact.email2;
      _dayOfBirth = DateTime.parse(contact.dayOfBirth);
      _street = contact.street;
      _number = contact.number;
      _neighborhood = contact.neighborhood;
      _optional = contact.optional;
      _city = contact.city;
      _state = contact.state;
      _cep = contact.cep;
      _rg = contact.rg;
      _cpf = contact.cpf;
      _register = DateTime.parse(contact.register);
    } else {
      _contactId = null;
      _name = null;
      _phone = null;
      _phone2 = null;
      _phone3 = null;
      _email = null;
      _email2 = null;
      _dayOfBirth = null;
      _street = null;
      _number = null;
      _neighborhood = null;
      _optional = null;
      _city = null;
      _state = null;
      _cep = null;
      _rg = null;
      _cpf = null;
      _register = null;
    }
  }

  saveContact() {
    if (_contactId == null) {
      //Add
      var newContact = Contact(
        contactId: uuid.v1(),
        name: _name,
        phone: _phone,
        phone2: _phone2,
        phone3: _phone3,
        email: _email,
        email2: _email2,
        dayOfBirth: _dayOfBirth.toIso8601String(),
        street: _street,
        number: _number,
        neighborhood: _neighborhood,
        optional: _optional,
        city: _city,
        state: _state,
        cep: _cep,
        rg: _rg,
        cpf: _cpf,
        register: _register.toIso8601String(),
      );
      firestoreService.setContact(newContact);
    } else {
      //Edit
      var updatedContact = Contact(
        contactId: _contactId,
        name: _name,
        phone: _phone,
        phone2: _phone2,
        phone3: _phone3,
        email: _email,
        email2: _email2,
        dayOfBirth: _dayOfBirth.toIso8601String(),
        street: _street,
        number: _number,
        neighborhood: _neighborhood,
        optional: _optional,
        city: _city,
        state: _state,
        cep: _cep,
        rg: _rg,
        cpf: _cpf,
        register: _register.toIso8601String(),
      );
      firestoreService.setContact(updatedContact);
    }
  }

  removeContact(String contactId) {
    firestoreService.removeContact(contactId);
  }
}
