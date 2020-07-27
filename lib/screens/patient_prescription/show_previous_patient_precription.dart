import 'package:flutter/material.dart';
import 'package:healthbook/screens/patient_prescription/previous_prescription.dart';

class ShowPreviousPatientPrecription extends StatelessWidget {
  final String diagnose;

  ShowPreviousPatientPrecription({this.diagnose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr: mohamed",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        leading: BackButton(color: Colors.white,onPressed: (){
          Navigator.of(context).pop();
        },),
      ),
      body: PreviousPrescription(diagnose: diagnose,),
    );
  }
}
