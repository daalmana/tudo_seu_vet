import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tudo_seu_vet/app.dart';

// Root file/widget for starting the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
