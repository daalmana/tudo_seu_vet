import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tudo_seu_vet/src/screens/contact_detail_screen.dart';

import '../../src/models/contacts.dart';
import '../../src/providers/contact_provider.dart';
import '../../src/screens/contact_edit_screen.dart';
import '../../src/utils/app_localizations.dart';

class ContactListScreen extends StatefulWidget {
  static const routeName = '/contact-list';

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate(
            "Contacts",
          ),
        ),
      ),
      body: StreamBuilder<List<Contact>>(
        stream: contactProvider.contacts,
        builder: (context, snapshot) {
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
                              "Contact will be deleted",
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
                                    snapshot.data[index].contactId);
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
                key: Key(snapshot.data[index].contactId),
                child: ListTile(
                  onTap: () {
                    // Goes to ContactDetailScreen with data of the contact that was tapped
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ContactDetailScreen(
                          // Data of tapped contact
                          contact: snapshot.data[index],
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
                    snapshot.data[index].phone,
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
                                "Contact will be deleted",
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
                                  contactProvider.removeContact(
                                      snapshot.data[index].contactId);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ContactEditScreen.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
