import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tudo_seu_vet/src/screens/patient_list_screen.dart';
import 'package:tudo_seu_vet/src/utils/app_localizations.dart';

import '../widgets/homepage_menu_card.dart';
import '../screens/contact_list_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {},
          child: Icon(
            Icons.menu,
            color: Theme.of(context).accentColor,
            size: 20.0,
          ),
        ),
        title: Text(
          'Menu',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).accentColor,
              size: 20.0,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Vet-Clinic-3small.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.grey.withOpacity(0.3),
          child: GridView.count(
            reverse: true,
            crossAxisCount: 3,
            children: [
              HomePageMenuCard(
                icons: Icons.date_range,
                text: 'Agenda',
                onTab: '',
              ),
              HomePageMenuCard(
                icons: Icons.add_business_rounded,
                text: AppLocalizations.of(context).translate("+ Consult"),
                onTab: '',
              ),
              HomePageMenuCard(
                text: AppLocalizations.of(context).translate("Clients"),
                icons: Icons.person,
                onTab: ContactListScreen.routeName,
              ),
              HomePageMenuCard(
                icons: Icons.pets,
                text: AppLocalizations.of(context).translate("Patients"),
                onTab: PatientListScreen.routeName,
              ),
              HomePageMenuCard(
                icons: Icons.corporate_fare,
                text: AppLocalizations.of(context).translate("Consults"),
                onTab: '',
              ),
              HomePageMenuCard(
                icons: Icons.attach_money,
                text: AppLocalizations.of(context).translate("Payments"),
                onTab: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
