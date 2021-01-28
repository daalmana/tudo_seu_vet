import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../src/models/consults.dart';
import '../../src/services/firestore_service_consults.dart';

class ConsultProvider with ChangeNotifier {
  final firestoreService = FirestoreServiceConsults();
  String _consultId;
  String _contactId;
  String _patientId;
  DateTime _date;
  String _description;
  double _amount;
  bool _consultReady;
  bool _paid;
  bool _invoice;
  var uuid = Uuid();

  //Getters
  String get consultId => _consultId;
  String get contactId => _contactId;
  String get patientId => _patientId;
  DateTime get date => _date;
  String get description => _description;
  double get amount => _amount;
  bool get consultReady => _consultReady;
  bool get paid => _paid;
  bool get invoice => _invoice;
  Stream<List<Consult>> get consults => firestoreService.getConsults();
  Stream<List<Consult>> get consultsInvoice =>
      firestoreService.getConsultsInvoices();

  //Setters

  set changeContactName(String contactId) {
    _contactId = contactId;
    notifyListeners();
  }

  set changePatientName(String patientId) {
    _patientId = patientId;
    notifyListeners();
  }

  set changeDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  set changeDescription(String description) {
    _description = description;
    notifyListeners();
  }

  set changeAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  set changeConsultReady(bool consultReady) {
    _consultReady = consultReady;
    notifyListeners();
  }

  set changePaid(bool paid) {
    _paid = paid;
    notifyListeners();
  }

  set changeInvoice(bool invoice) {
    _invoice = invoice;
    notifyListeners();
  }

  loadAll(Consult consult) {
    if (consult != null) {
      _consultId = consult.consultId;
      _contactId = consult.contactId;
      _patientId = consult.patientId;
      _date = consult.date;
      _description = consult.description;
      _amount = consult.amount;
      _consultReady = consult.consultReady;
      _paid = consult.paid;
      _invoice = consult.invoice;
    } else {
      _consultId = null;
      _contactId = null;
      _patientId = null;
      _date = DateTime.now();
      _description = null;
      _amount = null;
      _consultReady = false;
      _paid = false;
      _invoice = false;
    }
  }

  saveConsult() {
    if (_consultId == null) {
      //add
      var newConsult = Consult(
        consultId: uuid.v1(),
        contactId: _contactId,
        patientId: _patientId,
        date: _date,
        description: _description,
        amount: _amount,
        consultReady: _consultReady,
        paid: _paid,
        invoice: _invoice,
      );
      firestoreService.setConsult(newConsult);
    } else {
      var updatedConsult = Consult(
        consultId: _consultId,
        contactId: _contactId,
        patientId: _patientId,
        date: _date,
        description: _description,
        amount: _amount,
        consultReady: _consultReady,
        paid: _paid,
        invoice: _invoice,
      );
      firestoreService.setConsult(updatedConsult);
    }
  }

  removeConsult(String consultId) {
    firestoreService.removeConsult(consultId);
  }
}
