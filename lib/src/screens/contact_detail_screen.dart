import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../src/models/contacts.dart';

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
                              'Address:',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ),
                          Text(
                            widget.contact.street,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.contact.number,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(',  '),
                              Text(
                                widget.contact.optional,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
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
                            'Phone numbers:',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              launch("tel://${widget.contact.phone}"),
                          icon: Icon(Icons.phone, size: 15.0),
                          label: Text(
                            'Phone: ' + widget.contact.phone,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          onLongPress: () {
                            launchWhatsApp(
                              number: widget.contact.phone,
                              message: "Hello ${widget.contact.name}, ",
                            );
                          },
                        ),
                        widget.contact.phone2.isEmpty
                            ? Container()
                            : TextButton.icon(
                                icon: Icon(Icons.phone, size: 15.0),
                                label: Text(
                                  'Phone 2: ' + widget.contact.phone2,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onPressed: () => launch(
                                  "tel://${widget.contact.phone2}",
                                ),
                                onLongPress: () {
                                  launchWhatsApp(
                                    number: widget.contact.phone2,
                                    message: "Hello ${widget.contact.name}, ",
                                  );
                                },
                              ),
                        widget.contact.phone3.isEmpty
                            ? Container()
                            : TextButton.icon(
                                icon: Icon(Icons.phone, size: 15.0),
                                label: Text(
                                  'Phone 3: ' + widget.contact.phone3,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onPressed: () => launch(
                                  "tel://${widget.contact.phone3}",
                                ),
                                onLongPress: () {
                                  launchWhatsApp(
                                    number: widget.contact.phone3,
                                    message: "Hello ${widget.contact.name}, ",
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
                              'mailto:${widget.contact.email}?subject=Bom%20dia&body=Ola%20${widget.contact.name}, \n',
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
                                    'mailto:${widget.contact.email2}?subject=Bom%20dia&body=Ola%20${widget.contact.name}, \n',
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
                              'Contact info:',
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
                            'Day of Birth: ' +
                                widget.contact.dayOfBirth.substring(
                                  0,
                                  10,
                                ),
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Registered: ' +
                                widget.contact.register.substring(
                                  0,
                                  10,
                                ),
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
