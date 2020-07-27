import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_sms/flutter_sms.dart';
import 'package:healthbook/screens/patient_prescription/widgets/patient_prescription.dart';
import 'package:healthbook/screens/user_profile/widgets/user_history.dart';
import 'package:url_launcher/url_launcher.dart';

import 'user_profile.dart';

class PatientHealthRecord extends StatelessWidget {
  final GlobalKey<ScaffoldState> _patientHealthRecordState = GlobalKey<ScaffoldState>();
  static const routeName = 'PatientHealthRecord';
  String _patient_name = "Mohamed Salah Ismail";
  String _patient_job = "Student";
  String _about =
      " A personal health record is a collection of information about your"
      "health. If you have a vaccination record or a folder of medical papers,"
      "you already have a basic personal health record. ";
  String _address = "address............";
  String _governorate = "governorate............";
  String _gender = "male............";
  String _marital_status = "maritalstatus............";
  String _language = "language............";
  String _email = "email............";
  String _home_phone = "01211447755";
  @override
  Widget build(BuildContext context) {
    _cancelButton() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title:  ColorizeAnimatedTextKit(
              totalRepeatCount: 9,
              pause: Duration(milliseconds: 1000),
              isRepeatingAnimation: true,
              speed: Duration(seconds: 1),
              text: [' please tell the patient '],
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                  fontSize: 23.0, fontFamily: "Horizon"),
              colors: [
                Colors.blue,
                Colors.green,
                Colors.blue,
              ],
              alignment: AlignmentDirectional
                  .topStart // or Alignment.topLeft
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      launch("tel://21213123123");
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height:  38,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            Text(
                              'Call ',
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: (){
//                      sendSMS(message: 'Hello Patient', recipients: ['+201145523795'])
//                          .catchError((onError) {
//                        print(onError);
//                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 38,
                        width: 126,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            Text(
                              'Message ',
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text('SuccessFully deleted',style:
                  TextStyle(color: Colors.white, fontSize: 15),),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  duration: Duration(seconds: 5),
                  backgroundColor: Colors.blue,
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {

                    },
                  ),
                );
                _patientHealthRecordState.currentState.showSnackBar(snackBar);
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    return Scaffold(
      key: _patientHealthRecordState
      ,appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
//                Navigator.pushNamed(context, MapSample.routeName);
              },
              child: Center(
                  child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ,color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PatientPrescription()));
                      },
                      child: Text(
                        'Adding Prescription',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
            ),
          ),
        ],
      ),
      body:
    Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView(
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserProfile()));
              },
              child: ListTile(
                leading: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/user.png'),
                  ),
                ),
                title: FittedBox(
                  child: Text('Mahmoud Essam',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                trailing: FlatButton.icon(padding: EdgeInsets.all(0.0),onPressed: _cancelButton, icon: Icon(Icons.delete,color: Colors.red,size: 18,), label: Text('Cancel',style: TextStyle(color: Colors.red),)),
              ),
            ),
            SizedBox(height: 20.0,),
            UserHistory(),
          ],
        ),
    ),
    );
  }
}
