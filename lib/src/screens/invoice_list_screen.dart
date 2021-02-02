import 'package:tudo_seu_vet/src/utils/app_localizations.dart';
import 'package:tudo_seu_vet/src/widgets/loading_spinner.dart';

import '../../src/models/consults.dart';
import '../../src/providers/consult_provider.dart';
import '../../src/screens/consult_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceListScreen extends StatefulWidget {
  static const routeName = '/invoices';
  @override
  _InvoiceListScreenState createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  @override
  Widget build(BuildContext context) {
    final consultProvider = Provider.of<ConsultProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pagamentos',
        ),
      ),
      body: StreamBuilder<List<Consult>>(
        stream: consultProvider.consultsInvoice,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            LoadingSpinner(Colors.green);
          }
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
              print(consultDate.minute);
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text(
                    snapshot.data[index].contactId +
                        '\n' +
                        AppLocalizations.of(context).translate("With:") +
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
    );
  }
}
