import 'package:flutter/material.dart';

// A screen that shows all of the contact/client details
class ContactDetailScreen extends StatelessWidget {
  static const routeName = '/contact-detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact detail',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
