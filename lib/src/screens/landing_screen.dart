import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../screens/homePage.dart';
import '../screens/auth_screen.dart';
import '../utils/app_localizations.dart';
import '../widgets/loading_spinner.dart';

class LandingScreen extends StatelessWidget {
  // LandingPage checks if the app is connected to firebase
  // from here you get directed to the homePage or loginPage
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Connection has an error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // Connected with success
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // Check if user is logged in
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;

                if (user == null) {
                  return AuthScreen();
                } else {
                  return HomePage();
                }
              }

              // Still trying to connect
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingSpinner(Colors.blue),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("Checking authentication"),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        // Still trying to connect
        return Scaffold(
          body: Center(
            child: Text(
              AppLocalizations.of(context).translate("Connecting to the app"),
            ),
          ),
        );
      },
    );
  }
}
