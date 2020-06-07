import 'package:flutter/material.dart';
import 'package:healthbook/screens/patient_prescription/previous_prescription.dart';

class ShowPreviousPatientPrecription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,onPressed: (){
          Navigator.of(context).pop();
        },),
      ),
      body: PreviousPrescription(),
    );
  }
}
