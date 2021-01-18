import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:provider/provider.dart';

import '../../src/models/contacts.dart';
import '../../src/providers/contact_provider.dart';
import '../../src/utils/app_localizations.dart';

// A screen that adds or edit a contact/client
class ContactEditScreen extends StatefulWidget {
  static const routeName = '/contact-edit';
  final Contact contact;

  ContactEditScreen({this.contact});
  @override
  _ContactEditScreenState createState() => _ContactEditScreenState();
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phone2Controller = TextEditingController();
  final phone3Controller = TextEditingController();
  final emailController = TextEditingController();
  final email2Controller = TextEditingController();
  final dayOfBirthController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final optionalController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final rgController = TextEditingController();
  final cpfController = TextEditingController();
  final registerController = TextEditingController();

  @override
  void initState() {
    final contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    if (widget.contact != null) {
      nameController.text = widget.contact.name;
      phoneController.text = widget.contact.phone;
      phone2Controller.text = widget.contact.phone2;
      phone3Controller.text = widget.contact.phone3;
      emailController.text = widget.contact.email;
      email2Controller.text = widget.contact.email2;
      dayOfBirthController.text = widget.contact.dayOfBirth;
      streetController.text = widget.contact.street;
      numberController.text = widget.contact.number;
      neighborhoodController.text = widget.contact.neighborhood;
      optionalController.text = widget.contact.optional;
      cityController.text = widget.contact.city;
      stateController.text = widget.contact.state;
      zipCodeController.text = widget.contact.cep;
      rgController.text = widget.contact.rg;
      cpfController.text = widget.contact.cpf;
      registerController.text = widget.contact.register;
      contactProvider.loadAll(widget.contact);
    } else {
      contactProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    phone2Controller.dispose();
    phone3Controller.dispose();
    emailController.dispose();
    email2Controller.dispose();
    dayOfBirthController.dispose();
    streetController.dispose();
    numberController.dispose();
    neighborhoodController.dispose();
    optionalController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    rgController.dispose();
    cpfController.dispose();
    registerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/web_CANIS_18.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate("Edit contact"),
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                final isValid = _formKey.currentState.validate();
                if (isValid) {
                  _formKey.currentState.save();
                  contactProvider.saveContact();
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
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return AppLocalizations.of(context)
                                .translate("Enter more than 4 characters");
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
                          contactProvider.changeName = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: streetController,
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
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
                              AppLocalizations.of(context).translate("Street:"),
                        ),
                        onSaved: (value) {
                          contactProvider.changeStreet = value;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: numberController,
                              keyboardType: TextInputType.numberWithOptions(),
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
                                    .translate("Number:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeNumber = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: optionalController,
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
                                labelText: AppLocalizations.of(context)
                                    .translate("Optional:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeOptional = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: zipCodeController,
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
                                labelText: AppLocalizations.of(context)
                                    .translate("Zip code:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeZipCode = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: neighborhoodController,
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
                                labelText: AppLocalizations.of(context)
                                    .translate("Neighborhood:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeNeighborhood = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.8,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: stateController,
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
                                labelText: AppLocalizations.of(context)
                                    .translate("State:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeState = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: cityController,
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
                                labelText: AppLocalizations.of(context)
                                    .translate("City:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeCity = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: TextFormField(
                          controller: phoneController,
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
                            labelText: AppLocalizations.of(context)
                                .translate("Phone:"),
                          ),
                          onSaved: (value) {
                            contactProvider.changePhone = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: TextFormField(
                          controller: phone2Controller,
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
                            labelText: AppLocalizations.of(context)
                                .translate("Phone 2:"),
                          ),
                          onSaved: (value) {
                            contactProvider.changePhone2 = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.9,
                        child: TextFormField(
                          controller: phone3Controller,
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
                            labelText: AppLocalizations.of(context)
                                .translate("Phone 3:"),
                          ),
                          onSaved: (value) {
                            contactProvider.changePhone3 = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
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
                                .translate("E-mail:"),
                          ),
                          onSaved: (value) {
                            contactProvider.changeEmail = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: email2Controller,
                          keyboardType: TextInputType.emailAddress,
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
                                .translate("E-mail 2:"),
                          ),
                          onSaved: (value) {
                            contactProvider.changeEmail2 = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: cpfController,
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
                                labelText: AppLocalizations.of(context)
                                    .translate("CPF:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeCpf = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: rgController,
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
                                labelText: AppLocalizations.of(context)
                                    .translate("RG:"),
                              ),
                              onSaved: (value) {
                                contactProvider.changeRg = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.1,
                      height: 45.0,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DateTimeField(
                          initialValue: DateTime.now(),
                          controller: dayOfBirthController,
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
                          format: format,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: DateTime(1995),
                              lastDate: DateTime.now(),
                            );
                          },
                          onSaved: (value) {
                            contactProvider.changeDayOfBirth = value;
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.1,
                      height: 45.0,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DateTimeField(
                          controller: registerController,
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
                                .translate("Registered:"),
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
                            contactProvider.changeRegister = value;
                          },
                        ),
                      ),
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
