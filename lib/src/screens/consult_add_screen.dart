import '../../src/utils/app_localizations.dart';

import '../../src/models/consults.dart';
import '../../src/models/contacts.dart';
import '../../src/models/patients.dart';
import '../../src/providers/consult_provider.dart';
import '../../src/providers/contact_provider.dart';
import '../../src/providers/patient_provider.dart';
import '../../src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddConsultScreen extends StatefulWidget {
  static const routeName = '/consult-add';
  final Consult consult;

  AddConsultScreen({this.consult});

  @override
  _AddConsultScreenState createState() => _AddConsultScreenState();
}

class _AddConsultScreenState extends State<AddConsultScreen> {
  final _formKey = GlobalKey<FormState>();
  auth.User user = auth.FirebaseAuth.instance.currentUser;

  var contactList;
  var contactList2;
  TextEditingController patientIdController = TextEditingController();
  TextEditingController contactIdController = TextEditingController();
  TextEditingController consultIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    final consultProvider =
        Provider.of<ConsultProvider>(context, listen: false);
    if (widget.consult != null) {
      DateTime consultDate = widget.consult.date;
      var consultDateFormat = DateTime(
        consultDate.year,
        consultDate.month,
        consultDate.day,
        consultDate.hour,
        consultDate.minute,
      );
      contactIdController.text = widget.consult.contactId;
      patientIdController.text = widget.consult.patientId;
      dateController.text =
          '${consultDateFormat.day}-${consultDateFormat.month}-${consultDateFormat.year} / ${consultDateFormat.hour}:${consultDateFormat.minute.toString().padLeft(2, '0')}';
      amountController.text = widget.consult.amount.toStringAsFixed(2);
      descriptionController.text = widget.consult.description;
      consultProvider.loadAll(widget.consult);
    } else {
      consultProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    contactIdController.dispose();
    patientIdController.dispose();
    consultIdController.dispose();
    dateController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context);
    final consultProvider = Provider.of<ConsultProvider>(context);
    final format = DateFormat("dd-MM-yyyy / HH:mm");
    final initialValue = DateTime.now();

    bool autoValidate = false;
    bool showResetIcon = true;
    DateTime value = DateTime.now();
    return Container(
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
              AppLocalizations.of(context).translate("Consults"),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
            ),
            actions: [
              (widget.consult != null)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.yellowAccent,
                                title: Text(
                                  'Excluir consulta?',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                content:
                                    Text('Você deseja excluir a consulta?'),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('cancel'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      // consultProvider.removeConsult(
                                      //     widget.consult.consultId);
                                      // Navigator.popAndPushNamed(
                                      //     context, ConsultListScreen.routeName);
                                    },
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                  color: Colors.greenAccent,
                  icon: Icon(Icons.done),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            'Você tem certeza?',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          content: Text(
                              'Tem certeza de que todos os dados estão corretos?'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('cancel'),
                            ),
                            FlatButton(
                              onPressed: () {
                                final isValid =
                                    _formKey.currentState.validate();
                                if (isValid) {
                                  _formKey.currentState.save();
                                  consultProvider.saveConsult();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                } else {
                                  final isValid =
                                      _formKey.currentState.validate();
                                  if (isValid) {
                                    _formKey.currentState.save();
                                    consultProvider.saveConsult();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                }
                                // consultProvider.removeConsult(
                                //     widget.consult.consultId);
                                // Navigator.popAndPushNamed(
                                //     context, ConsultListScreen.routeName);
                              },
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: Column(
                        children: [
                          StreamBuilder<List<Contact>>(
                            stream: contactProvider.contacts,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return LoadingSpinner(Colors.white);
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.person_add),
                                  ),
                                  SizedBox(
                                    width: 50.0,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: widget.consult == null
                                        ? DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Selecione o cliente'),
                                            items: snapshot.data
                                                .map(
                                                  (Contact contact) =>
                                                      DropdownMenuItem<String>(
                                                    value: contact.name,
                                                    child: Container(
                                                      width: 210,
                                                      child: Text(contact.name),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged:
                                                (String newValueSelected) {
                                              setState(
                                                () {
                                                  this.contactList =
                                                      newValueSelected;
                                                },
                                              );
                                            },
                                            onSaved: (value) {
                                              consultProvider
                                                  .changeContactName = value;
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'O cliente não foi selecionado';
                                              }

                                              return null;
                                            },
                                          )
                                        : TextFormField(
                                            readOnly: true,
                                            initialValue:
                                                widget.consult.contactId,
                                          ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 20.0),
                          StreamBuilder<List<Patient>>(
                            stream: patientProvider.patients,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return LoadingSpinner(Colors.white);
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.pets),
                                  ),
                                  SizedBox(
                                    width: 50.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: widget.consult == null
                                        ? DropdownButtonFormField<String>(
                                            // TODO create dynamic list only showing the patients when client is selected
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Selecione o patiente'),
                                            items: snapshot.data
                                                .map(
                                                  (Patient patient) =>
                                                      DropdownMenuItem<String>(
                                                    value: patient.name,
                                                    child: Text(patient.name),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged:
                                                (String newValueSelected) {
                                              setState(
                                                () {
                                                  this.contactList2 =
                                                      newValueSelected;
                                                },
                                              );
                                            },
                                            onSaved: (value) {
                                              consultProvider
                                                  .changePatientName = value;
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Paciente não selecionado';
                                              }
                                              return null;
                                            },
                                          )
                                        : TextFormField(
                                            readOnly: true,
                                            initialValue:
                                                widget.consult.patientId,
                                          ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.calendar_today),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: DateTimeField(
                                  controller: dateController,
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
                                    final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now()),
                                      );
                                      return DateTimeField.combine(date, time);
                                    } else {
                                      return currentValue;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Selecione a data e hora',
                                  ),
                                  autovalidate: autoValidate,
                                  validator: (date) =>
                                      date == null ? 'Data inválida' : null,
                                  initialValue: (widget.consult == null)
                                      ? initialValue
                                      : widget.consult.date,
                                  onChanged: (date) => setState(() {
                                    value = date;
                                  }),
                                  onSaved: (date) => setState(() {
                                    consultProvider.changeDate = date;
                                  }),
                                  resetIcon:
                                      showResetIcon ? Icon(Icons.delete) : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Colors.white.withOpacity(0.9),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 1,
                      child: SingleChildScrollView(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: descriptionController,
                          maxLines: 10,
                          minLines: 5,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate("Description:"),
                            border: InputBorder.none,
                            labelStyle:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                          onSaved: (value) {
                            consultProvider.changeDescription = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: amountController,
                              decoration: InputDecoration(
                                prefixText: 'R\$ ',
                                labelText: 'Insira um valor',
                                // hintText: 'R\$ 450,00',
                              ),
                              onSaved: (value) {
                                if (value.isEmpty) {
                                  consultProvider.changeAmount = 0.00;
                                } else {
                                  consultProvider.changeAmount =
                                      double.parse(value);
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Consulto pronto?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      )),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                child: Switch(
                                  inactiveThumbColor: Colors.redAccent,
                                  inactiveTrackColor: Colors.redAccent.shade100,
                                  value: consultProvider.consultReady,
                                  onChanged: (value) {
                                    setState(() {
                                      consultProvider.changeConsultReady =
                                          value;
                                      consultProvider.changeInvoice = value;
                                    });
                                  },
                                  activeTrackColor: Colors.green.shade200,
                                  activeColor: Colors.green,
                                ),
                              ),
                              (consultProvider.consultReady == true)
                                  ? Container(
                                      child: Text(
                                        'Pronto!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          (widget.consult != null &&
                                  widget.consult.invoice == true)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Pagou?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Switch(
                                        inactiveThumbColor: Colors.redAccent,
                                        inactiveTrackColor:
                                            Colors.redAccent.shade100,
                                        value: consultProvider.paid,
                                        onChanged: (value) {
                                          setState(() {
                                            consultProvider.changePaid = value;
                                          });
                                        },
                                        activeTrackColor: Colors.green.shade200,
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    (consultProvider.paid == true)
                                        ? Container(
                                            child: Text(
                                              'Pagou! ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
