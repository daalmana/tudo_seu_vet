import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../src/models/patients.dart';
import '../../src/services/firestore_service_patients.dart';

class PatientProvider with ChangeNotifier {
  final firestoreServicePatients = FirestoreServicePatients();
  String _ownerId;
  String _owner;
  String _patientId;
  String _name;
  DateTime _dayOfBirth;
  String _breed;
  String _sex;
  String _color;
  String _age;
  String _chip;
  String _origin;
  String _weight;
  var uuid = Uuid();

  String get ownerId => _ownerId;
  String get owner => _owner;
  String get patientId => _patientId;
  String get name => _name;
  DateTime get dayOfBirth => _dayOfBirth;
  String get breed => _breed;
  String get sex => _sex;
  String get color => _color;
  String get age => _age;
  String get chip => _chip;
  String get origin => _origin;
  String get weight => _weight;
  Stream<List<Patient>> get patients => firestoreServicePatients.getPatients();

  //Setters
  set changeOwnerId(String ownerId) {
    _ownerId = ownerId;
    notifyListeners();
  }

  set changeOwner(String owner) {
    _owner = owner;
    notifyListeners();
  }

  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changeDayOfBirth(DateTime dayOfBirth) {
    _dayOfBirth = dayOfBirth;
    notifyListeners();
  }

  set changeBreed(String breed) {
    _breed = breed;
    notifyListeners();
  }

  set changeSex(String sex) {
    _sex = sex;
    notifyListeners();
  }

  set changeColor(String color) {
    _color = color;
    notifyListeners();
  }

  set changeAge(String age) {
    _age = age;
    notifyListeners();
  }

  set changeChip(String chip) {
    _chip = chip;
    notifyListeners();
  }

  set changeOrigin(String origin) {
    _origin = origin;
    notifyListeners();
  }

  set changeWeight(String weight) {
    _weight = weight;
    notifyListeners();
  }

  //Functions
  loadAll(Patient patient) {
    if (patient != null) {
      _ownerId = patient.ownerId;
      _owner = patient.owner;
      _patientId = patient.patientId;
      _name = patient.name;
      _dayOfBirth = DateTime.parse(patient.dayOfBirth);
      _breed = patient.breed;
      _sex = patient.sex;
      _color = patient.color;
      _age = patient.age;
      _chip = patient.chip;
      _origin = patient.origin;
      _weight = patient.weight;
    } else {
      _ownerId = null;
      _owner = null;
      _patientId = null;
      _name = null;
      _dayOfBirth = null;
      _breed = null;
      _sex = null;
      _color = null;
      _age = null;
      _chip = null;
      _origin = null;
      _weight = null;
    }
  }

  savePatient() {
    if (_patientId == null) {
      //Add
      var newPatient = Patient(
        ownerId: _ownerId,
        owner: _owner,
        patientId: uuid.v1(),
        name: name,
        dayOfBirth: _dayOfBirth.toIso8601String(),
        breed: _breed,
        sex: _sex,
        color: _color,
        age: _age,
        chip: _chip,
        origin: _origin,
        weight: _weight,
      );
      firestoreServicePatients.setPatient(newPatient);
    } else {
      var updatePatient = Patient(
        ownerId: _ownerId,
        owner: _owner,
        patientId: _patientId,
        name: _name,
        dayOfBirth: _dayOfBirth.toIso8601String(),
        breed: _breed,
        sex: _sex,
        color: _color,
        age: _age,
        chip: _chip,
        origin: _origin,
        weight: _weight,
      );
      firestoreServicePatients.setPatient(updatePatient);
    }
  }

  removePatient(String patientId) {
    firestoreServicePatients.removePatient(patientId);
  }
}
