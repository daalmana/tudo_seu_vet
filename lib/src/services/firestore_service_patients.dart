import '../models/patients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirestoreServicePatients {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  auth.User user = auth.FirebaseAuth.instance.currentUser;

  //Get patients
  Stream<List<Patient>> getPatients() {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('patients')
        .orderBy('name')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Patient.fromJson(doc.data())).toList());
  }

  //Upsert
  Future<void> setPatient(Patient patient) {
    var options = SetOptions(merge: true);

    return _db
        .collection('users')
        .doc(user.uid)
        .collection('patients')
        .doc(patient.patientId)
        .set(patient.toMap(), options);
  }

  //Delete
  Future<void> removePatient(String patientId) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('patients')
        .doc(patientId)
        .delete();
  }
}
