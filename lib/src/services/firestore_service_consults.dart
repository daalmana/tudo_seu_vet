import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../src/models/consults.dart';

class FirestoreServiceConsults {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  auth.User user = auth.FirebaseAuth.instance.currentUser;

  //Get consults
  Stream<List<Consult>> getConsults() {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('consults')
        .orderBy('date')
        .where('invoice', isEqualTo: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Consult.fromJson(doc.data())).toList());
  }

  Stream<List<Consult>> getConsultsInvoices() {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('consults')
        .orderBy('date', descending: true)
        .where('invoice', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Consult.fromJson(doc.data())).toList());
  }

  //Upsert
  Future<void> setConsult(Consult consult) {
    var options = SetOptions(merge: true);

    return _db
        .collection('users')
        .doc(user.uid)
        .collection('consults')
        .doc(consult.consultId)
        .set(consult.toMap(), options);
  }

  //Delete
  Future<void> removeConsult(String consultId) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('consults')
        .doc(consultId)
        .delete();
  }
}
