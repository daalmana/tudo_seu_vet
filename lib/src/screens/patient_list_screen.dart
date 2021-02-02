import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tudo_seu_vet/src/widgets/loading_spinner.dart';

import '../../src/models/patients.dart';
import '../../src/providers/contact_provider.dart';
import '../../src/providers/patient_provider.dart';
import '../../src/screens/patient_detail_screen.dart';
import '../../src/utils/app_localizations.dart';

class PatientListScreen extends StatefulWidget {
  static const routeName = '/patient-list';

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  @override
  Widget build(BuildContext context) {
    var patientProvider = Provider.of<PatientProvider>(context);
    var contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate(
            "Patients",
          ),
        ),
      ),
      body: StreamBuilder<List<Patient>>(
        stream: patientProvider.patients,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingSpinner(Colors.green);
          }
          return ListView.separated(
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.3,
            ),
            itemBuilder: (context, index) {
              return Slidable(
                // Slider for deleting a contact with dialog
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                  closeOnCanceled: true,
                  onWillDismiss: (actionType) {
                    return showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            AppLocalizations.of(context).translate(
                              "Delete",
                            ),
                          ),
                          content: Text(
                            AppLocalizations.of(context).translate(
                              "Patient will be deleted",
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                AppLocalizations.of(context).translate(
                                  "Cancel",
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            FlatButton(
                              child: Text(
                                'Ok',
                              ),
                              onPressed: () {
                                contactProvider.removeContact(
                                    snapshot.data[index].patientId);
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                key: Key(snapshot.data[index].patientId),
                child: ListTile(
                  onTap: () {
                    // Goes to ContactDetailScreen with data of the contact that was tapped
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PatientDetailScreen(
                          // Data of tapped contact
                          patient: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                  dense: true,
                  title: Text(
                    snapshot.data[index].name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    snapshot.data[index].owner,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: AppLocalizations.of(context).translate(
                      "Delete",
                    ),
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      return showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              AppLocalizations.of(context).translate(
                                "Delete",
                              ),
                            ),
                            content: Text(
                              AppLocalizations.of(context).translate(
                                "Patient will be deleted",
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  AppLocalizations.of(context).translate(
                                    "Cancel",
                                  ),
                                ),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  patientProvider.removePatient(
                                      snapshot.data[index].patientId);
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
