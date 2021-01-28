import '../models/contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  auth.User user = auth.FirebaseAuth.instance.currentUser;

  //Get Contacts
  Stream<List<Contact>> getContacts() {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('contacts')
        .orderBy('name')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Contact.fromJson(doc.data())).toList());
  }

  //Upsert
  Future<void> setContact(Contact contact) {
    var options = SetOptions(merge: true);

    return _db
        .collection('users')
        .doc(user.uid)
        .collection('contacts')
        .doc(contact.contactId)
        .set(contact.toMap(), options);
  }

  //Delete
  Future<void> removeContact(String contactId) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('contacts')
        .doc(contactId)
        .delete();
  }
}
