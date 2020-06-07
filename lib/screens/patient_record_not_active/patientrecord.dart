import 'package:flutter/material.dart';


class PatientRecord extends StatefulWidget {
  @override
  _PatientRecordState createState() => _PatientRecordState();
}

class _PatientRecordState extends State<PatientRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10.0, bottom: 4.0),
            child: Text(
              'Record',
              textAlign: TextAlign.left,
            ),
          ),
//          Expanded(
//              child: ListView.builder(
//  //          itemBuilder: (context, index) => RecordCard(),
//            itemCount: 6,
//          ))
        ],
      ),
    );
  }
}
