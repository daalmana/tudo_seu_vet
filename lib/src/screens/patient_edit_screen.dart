import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../src/models/contacts.dart';
import '../../src/models/patients.dart';
import '../../src/providers/patient_provider.dart';
import '../../src/utils/app_localizations.dart';

class PatientEditScreen extends StatefulWidget {
  static const routeName = '/patient';
  final Patient patient;
  final Contact contact;

  PatientEditScreen({this.contact, this.patient});
  @override
  _PatientEditScreenState createState() => _PatientEditScreenState();
}

class _PatientEditScreenState extends State<PatientEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");

  final nameController = TextEditingController();
  final dayOfBirthController = TextEditingController();
  final breedController = TextEditingController();
  final sexController = TextEditingController();
  final colorController = TextEditingController();
  final ageController = TextEditingController();
  final chipController = TextEditingController();
  final originController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    final patientProvider =
        Provider.of<PatientProvider>(context, listen: false);
    if (widget.patient != null) {
      nameController.text = widget.patient.name;
      dayOfBirthController.text = widget.patient.dayOfBirth;
      breedController.text = widget.patient.breed;
      sexController.text = widget.patient.sex;
      colorController.text = widget.patient.color;
      ageController.text = widget.patient.age;
      chipController.text = widget.patient.chip;
      originController.text = widget.patient.origin;
      weightController.text = widget.patient.weight;
      patientProvider.loadAll(widget.patient);
    } else {
      patientProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    dayOfBirthController.dispose();
    breedController.dispose();
    sexController.dispose();
    colorController.dispose();
    ageController.dispose();
    chipController.dispose();
    originController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cats&dogs.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate("Add patient"),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                final isValid = _formKey.currentState.validate();
                if (isValid) {
                  _formKey.currentState.save();
                  patientProvider.savePatient();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.3),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: true,
                      maintainState: true,
                      child: TextFormField(
                        enabled: false,
                        initialValue: widget.contact.contactId,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Client ID',
                            labelStyle: Theme.of(context).textTheme.bodyText2),
                        onSaved: (value) {
                          patientProvider.changeOwnerId = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        enabled: false,
                        initialValue: widget.contact.name,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate("Owner:"),
                            labelStyle: Theme.of(context).textTheme.bodyText2),
                        onSaved: (value) {
                          patientProvider.changeOwner = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context)
                                .translate("Enter a name");
                          }
                          return null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Name:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeName = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: breedController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Breed:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeBreed = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DateTimeField(
                        controller: dayOfBirthController,
                        keyboardType: TextInputType.datetime,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate("Day of Birth:"),
                        ),
                        initialValue: DateTime.now(),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime.now(),
                          );
                        },
                        onSaved: (value) {
                          patientProvider.changeDayOfBirth = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: sexController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Sex:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeSex = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: colorController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Color:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeColor = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Age:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeAge = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: chipController,
                        keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Chip:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeChip = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: originController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Origin:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeOrigin = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate("Weight:"),
                        ),
                        onSaved: (value) {
                          patientProvider.changeWeight = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
