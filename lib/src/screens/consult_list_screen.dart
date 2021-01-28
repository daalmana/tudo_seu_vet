import 'package:tudo_seu_vet/src/utils/app_localizations.dart';

import '../../src/models/consults.dart';
import '../../src/providers/consult_provider.dart';
import '../../src/screens/consult_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ConsultListScreen extends StatefulWidget {
  static const routeName = '/consults';

  @override
  _ConsultListScreenState createState() => _ConsultListScreenState();
}

class _ConsultListScreenState extends State<ConsultListScreen> {
  bool paid = false;

  @override
  Widget build(BuildContext context) {
    final consultProvider = Provider.of<ConsultProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("Consults"),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: StreamBuilder<List<Consult>>(
        stream: consultProvider.consults,
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.3,
            ),
            itemBuilder: (context, index) {
              DateTime consultDate = snapshot.data[index].date;
              var consultDateFormat = DateTime(
                consultDate.year,
                consultDate.month,
                consultDate.day,
                consultDate.hour,
                consultDate.minute,
              );
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text(
                    snapshot.data[index].contactId +
                        '\n' +
                        AppLocalizations.of(context).translate("With:") +
                        ' ' +
                        snapshot.data[index].patientId,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: Text(
                    'R\$ ' + snapshot.data[index].amount.toStringAsFixed(2),
                    style: snapshot.data[index].paid == true
                        ? Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.green,
                            )
                        : Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.red,
                            ),
                  ),
                  subtitle: Text(
                    '${consultDateFormat.day}-${consultDateFormat.month}-${consultDateFormat.year} / ${consultDateFormat.hour}:${consultDateFormat.minute.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddConsultScreen(
                          consult: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddConsultScreen.routeName);
        },
      ),
    );
  }
}
