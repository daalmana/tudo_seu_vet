import 'package:flutter/material.dart';
import 'package:tudo_seu_vet/src/models/patients.dart';
import 'package:tudo_seu_vet/src/screens/patient_edit_screen.dart';

class PatientDetailScreen extends StatefulWidget {
  static const routName = '/patients-detail';
  final Patient patient;

  PatientDetailScreen({this.patient});
  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Text(widget.patient.name),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PatientEditScreen(
                      // Data of tapped contact
                      patient: widget.patient,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
