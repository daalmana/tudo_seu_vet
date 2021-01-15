import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src/models/contacts.dart';
import '../../src/providers/contact_provider.dart';
import '../../src/screens/contact_edit_screen.dart';
import '../../src/utils/app_localizations.dart';

class ContactListScreen extends StatelessWidget {
  static const routeName = '/contact-list';

  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("Contacts"),
        ),
      ),
      body: StreamBuilder<List<Contact>>(
        stream: contactProvider.contacts,
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.5,
            ),
            itemBuilder: (context, index) {
              return ListTile(
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
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ContactDetailScreen(
                  //       contact: snapshot.data[index],
                  //     ),
                  //   ),
                  // );
                },
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
