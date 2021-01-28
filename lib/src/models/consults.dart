import 'package:cloud_firestore/cloud_firestore.dart';

class Consult {
  final String consultId;
  final String contactId;
  final String patientId;
  final DateTime date;
  final String description;
  final double amount;
  final bool consultReady;
  final bool paid;
  final bool invoice;

  Consult({
    this.consultId,
    this.contactId,
    this.patientId,
    this.date,
    this.description,
    this.amount,
    this.consultReady,
    this.paid,
    this.invoice,
  });

  factory Consult.fromJson(Map<String, dynamic> json) {
    return Consult(
        consultId: json['consultId'],
        contactId: json['contactId'],
        patientId: json['patientId'],
        date: (json['date'] as Timestamp).toDate(),
        description: json['description'],
        amount: json['amount'],
        consultReady: json['consultReady'],
        paid: json['paid'],
        invoice: json['invoice']);
  }
  Map<String, dynamic> toMap() {
    return {
      'consultId': consultId,
      'contactId': contactId,
      'patientId': patientId,
      'date': date,
      'description': description,
      'amount': amount,
      'consultReady': consultReady,
      'paid': paid,
      'invoice': invoice,
    };
  }
}
