import 'package:flutter/material.dart';
import 'package:tudo_seu_vet/src/screens/landing_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tudo Seu Vet',
      home: LandingScreen(),
    );
  }
}
