import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tudo_seu_vet/src/screens/agenda_home_screen.dart';
import 'package:tudo_seu_vet/src/screens/consult_list_screen.dart';
import 'package:tudo_seu_vet/src/screens/invoice_list_screen.dart';
import './src/providers/consult_provider.dart';
import './src/screens/consult_add_screen.dart';
import './src/screens/patient_detail_screen.dart';
import './src/screens/patient_edit_screen.dart';
import './src/screens/patient_list_screen.dart';

import './src/providers/contact_provider.dart';
import './src/providers/patient_provider.dart';
import './src/screens/contact_detail_screen.dart';
import './src/screens/contact_edit_screen.dart';
import './src/screens/contact_list_screen.dart';
import './src/screens/landing_screen.dart';
import './src/screens/patient_edit_add_screen.dart';
import './src/utils/app_localizations.dart';

//MaterialApp widget for themes, fonts, colors...
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pre loading images
    precacheImage(AssetImage("assets/images/Vet-Clinic-7small.jpg"), context);
    precacheImage(
        AssetImage("assets/images/tudo_seu_avatar_logo.jpg"), context);
    precacheImage(AssetImage("assets/images/Vet-Clinic-3small.jpg"), context);
    precacheImage(AssetImage("assets/images/web_CANIS_18.jpg"), context);
    precacheImage(AssetImage("assets/images/cats&dogs.jpg"), context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConsultProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tudo Seu Vet',
        theme: ThemeData(
          primaryColor: Colors.teal[800],
          accentColor: Colors.amber[500],
          fontFamily: 'Montserrat',
          // This is the theme of your application.
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 96.0,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
            headline2: TextStyle(
              fontSize: 60.0,
              fontWeight: FontWeight.w300,
              letterSpacing: -0.5,
            ),
            headline3: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0,
            ),
            headline4: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            headline5: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0,
            ),
            headline6: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
            subtitle1: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
            ),
            subtitle2: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              letterSpacing: 0.10,
            ),
            bodyText1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            button: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.75,
            ),
            caption: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
            overline: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
            ),
          ),
        ),
        // Get you to the first screen of the app
        home: LandingScreen(),
        supportedLocales: [
          //List all of the app's supported locales here
          const Locale('en', 'US'),
          const Locale('pt', 'BR'),
        ],
        //These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
          //A class which loads the translations from JSON files
          AppLocalizations.delegate,
          //Build-in localizations of basic text for material widgets
          GlobalMaterialLocalizations.delegate,
          //build-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        //Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first on
          // from the list (English is this case)
          return supportedLocales.first;
        },
        routes: {
          ContactListScreen.routeName: (context) => ContactListScreen(),
          ContactEditScreen.routeName: (context) => ContactEditScreen(),
          ContactDetailScreen.routeName: (context) => ContactDetailScreen(),
          PatientEditAddScreen.routeName: (context) => PatientEditAddScreen(),
          PatientListScreen.routeName: (context) => PatientListScreen(),
          PatientDetailScreen.routName: (context) => PatientDetailScreen(),
          PatientEditScreen.routeName: (context) => PatientEditScreen(),
          AddConsultScreen.routeName: (context) => AddConsultScreen(),
          ConsultListScreen.routeName: (context) => ConsultListScreen(),
          InvoiceListScreen.routeName: (context) => InvoiceListScreen(),
          AgendaHomeScreen.routeName: (context) => AgendaHomeScreen(),
        },
      ),
    );
  }
}
