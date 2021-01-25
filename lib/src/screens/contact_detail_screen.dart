import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tudo_seu_vet/src/providers/patient_provider.dart';
import 'package:tudo_seu_vet/src/screens/patient_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../src/models/contacts.dart';
import '../../src/screens/contact_edit_screen.dart';
import '../../src/screens/patient_edit_add_screen.dart';
import '../../src/utils/app_localizations.dart';

// A screen that shows all of the contact/client details
class ContactDetailScreen extends StatefulWidget {
  static const routeName = '/contact-detail';
  final Contact contact;
  ContactDetailScreen({this.contact});

  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Cant launch');
    }
  }

  void launchWhatsApp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print('Cant open Whatsapp');
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Container(
      // BackgroundImage
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Vet-Clinic-3small.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            widget.contact.name,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ContactEditScreen(
                      // Data of tapped contact
                      contact: widget.contact,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    width: MediaQuery.of(context).size.width / 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("Address:"),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ),
                          Text(
                            widget.contact.street +
                                ', ' +
                                widget.contact.number,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.contact.optional,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            widget.contact.cep,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.contact.neighborhood,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(',  '),
                              Text(
                                widget.contact.state,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Text(
                            widget.contact.city,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    width: MediaQuery.of(context).size.width / 0.9,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("Phone numbers:"),
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                              onPressed: () =>
                                  launch("tel://${widget.contact.phone}"),
                              icon: Icon(Icons.phone, size: 15.0),
                              label: Text(
                                AppLocalizations.of(context)
                                        .translate("Phone:") +
                                    widget.contact.phone,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 25.0,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                launchWhatsApp(
                                  number: widget.contact.phone,
                                  message: AppLocalizations.of(context)
                                          .translate("Hello") +
                                      ' ' +
                                      widget.contact.name +
                                      ', ',
                                );
                              },
                            ),
                          ],
                        ),
                        widget.contact.phone2.isEmpty
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => launch(
                                        "tel://${widget.contact.phone2}"),
                                    icon: Icon(Icons.phone, size: 15.0),
                                    label: Text(
                                      AppLocalizations.of(context)
                                              .translate("Phone 2:") +
                                          widget.contact.phone,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      size: 25.0,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      launchWhatsApp(
                                        number: widget.contact.phone,
                                        message: AppLocalizations.of(context)
                                                .translate("Hello") +
                                            ' ' +
                                            widget.contact.name +
                                            ', ',
                                      );
                                    },
                                  ),
                                ],
                              ),
                        widget.contact.phone3.isEmpty
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => launch(
                                        "tel://${widget.contact.phone3}"),
                                    icon: Icon(Icons.phone, size: 15.0),
                                    label: Text(
                                      AppLocalizations.of(context)
                                              .translate("Phone 3:") +
                                          widget.contact.phone,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      size: 25.0,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      launchWhatsApp(
                                        number: widget.contact.phone,
                                        message: AppLocalizations.of(context)
                                                .translate("Hello") +
                                            ' ' +
                                            widget.contact.name +
                                            ', ',
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  // TODO Make subject and body dynamic for translations
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    width: MediaQuery.of(context).size.width / 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'E-mail:',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.email, size: 15.0),
                          label: Text(
                            'E-mail: ' + widget.contact.email,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          onPressed: () {
                            customLaunch(
                              'mailto:${widget.contact.email}?subject=Bom%20dia&body=Olá%20${widget.contact.name},\n',
                            );
                          },
                        ),
                        widget.contact.email2.isEmpty
                            ? Container()
                            : TextButton.icon(
                                icon: Icon(Icons.email, size: 15.0),
                                label: Text(
                                  'E-mail 2: ' + widget.contact.email2,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onPressed: () {
                                  customLaunch(
                                    'mailto:${widget.contact.email2}?subject=Bom%20dia&body=Olá%20${widget.contact.name},\n',
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    width: MediaQuery.of(context).size.width / 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("Contact info:"),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ),
                          Text(
                            'CPF: ' + widget.contact.cpf,
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                          widget.contact.rg.isEmpty
                              ? Container()
                              : Text(
                                  'RG: ' + widget.contact.rg,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                          Text(
                            AppLocalizations.of(context)
                                    .translate("Day of Birth:") +
                                ' ' +
                                formatter.format(
                                  DateTime.parse(widget.contact.dayOfBirth),
                                ),
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            AppLocalizations.of(context)
                                    .translate("Registered:") +
                                ' ' +
                                formatter.format(
                                  DateTime.parse(widget.contact.dayOfBirth),
                                ),
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    // TODO Sort out the height problem
                    width: MediaQuery.of(context).size.width / 0.9,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                          stream: patientProvider.patients,
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount:
                                  snapshot.hasData ? snapshot.data.length : 0,
                              itemBuilder: (context, index) {
                                if (widget.contact.contactId ==
                                    snapshot.data[index].ownerId)
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
                                                AppLocalizations.of(context)
                                                    .translate(
                                                  "Delete",
                                                ),
                                              ),
                                              content: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                  "Patient will be deleted",
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                      "Cancel",
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                ),
                                                FlatButton(
                                                  child: Text(
                                                    'Ok',
                                                  ),
                                                  onPressed: () {
                                                    patientProvider
                                                        .removePatient(snapshot
                                                            .data[index]
                                                            .patientId);
                                                    Navigator.of(context)
                                                        .pop(true);
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
                                            builder: (context) =>
                                                PatientDetailScreen(
                                              // Data of tapped contact
                                              patient: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 15),
                                      dense: true,
                                      title: Text(
                                        snapshot.data[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      subtitle: Text(
                                        snapshot.data[index].owner,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                        caption: AppLocalizations.of(context)
                                            .translate(
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
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                    "Delete",
                                                  ),
                                                ),
                                                content: Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                    "Patient will be deleted",
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                        "Cancel",
                                                      ),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                  ),
                                                  FlatButton(
                                                    child: Text('Ok'),
                                                    onPressed: () {
                                                      patientProvider
                                                          .removePatient(
                                                              snapshot
                                                                  .data[index]
                                                                  .patientId);
                                                      Navigator.of(context)
                                                          .pop(true);
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
                                else {
                                  return Container();
                                }
                              },
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PatientEditAddScreen(
                  // Data of tapped contact
                  contact: widget.contact,
                ),
              ),
            );
          },
          child: Icon(
            Icons.pets,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
