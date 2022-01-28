import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:healthbook/core/models/device_info.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/user_profile/show_profile.dart';

//import 'package:flutter_sms/flutter_sms.dart';
import 'package:healthbook/screens/user_profile/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import './patient_appointment_card.dart';
import 'appointments_date_card.dart';
import 'doctor_appointment_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  Auth _auth;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<Auth>(context, listen: false);
    getAllAppoitment();
  }

  getAllAppoitment() async {
    if (_auth.getUserType == 'doctor'
        ? _auth.allAppointment.length == 0
        : _auth.allAppointmentOfPatient.length == 0) {
      await _auth.getUserAppointment();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _cancelButton(String id) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                ' please tell the patient ',
                textAlign: TextAlign.center,
                textStyle:
                    const TextStyle(fontSize: 23.0, fontFamily: "Horizon"),
                colors: [
                  Colors.blue,
                  Colors.green,
                  Colors.blue,
                ],
              )
            ],
            totalRepeatCount: 9,
            pause: const Duration(milliseconds: 1000),
            isRepeatingAnimation: true,
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      launch("tel://21213123123");
                    },
                    child: Container(
                        height: 38,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                    onTap: () {
//                      sendSMS(message: 'Hello Patient', recipients: ['+201145523795'])
//                          .catchError((onError) {
//                        print(onError);
                      //  });
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
              onPressed: () async {
                bool x = await _auth.deleteAppointmentForPatAndDoc(
                    appointmentId: id, type: 'doctor');
                if (x == true) {
                  final snackBar = SnackBar(
                    content: Text(
                      'SuccessFully deleted',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    duration: Duration(seconds: 5),
                    backgroundColor: Colors.blue,
                  );
                  _scaffoldState.currentState.showSnackBar(snackBar);
                  Navigator.of(ctx).pop();
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      'failed to deleted',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    duration: Duration(seconds: 5),
                    backgroundColor: Colors.blue,
                  );
                  _scaffoldState.currentState.showSnackBar(snackBar);
                  Navigator.of(ctx).pop();
                }
              },
            )
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _auth.getUserAppointment();
      },
      backgroundColor: Colors.white,
      color: Colors.blue,
      child: InfoWidget(
        builder: (context, infoWidget) {
          return Scaffold(
            key: _scaffoldState,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: infoWidget.orientation == Orientation.portrait
                      ? infoWidget.screenHeight * 0.015
                      : infoWidget.screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                            _auth.getUserType != 'doctor'
                                ? 'Welcome ${_auth.userData.firstName} ${_auth.userData.lastName} !'
                                : 'Welcome Dr. ${_auth.userData.firstName} ${_auth.userData.lastName} ',
                            style: infoWidget.subTitle),
                      ],
                    ),
                  ],
                ),
                AppointmentsDateCard(),
                isLoading
                    ? Expanded(
                        child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.blue,
                        ),
                      ))
                    : Consumer<Auth>(builder: (context, appointements, _) {
                        if (_auth.getUserType == 'doctor'
                            ? appointements.allAppointment.length == 0
                            : appointements.allAppointmentOfPatient.length ==
                                0) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'You don\'t have any appointement for this day',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: infoWidget.titleButton
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: infoWidget.orientation ==
                                            Orientation.portrait
                                        ? infoWidget.screenHeight * 0.02
                                        : infoWidget.screenHeight * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  infoWidget.screenHeight *
                                                      0.06,
                                              vertical:
                                                  infoWidget.screenHeight *
                                                      0.015),
                                          child: Center(
                                            child: Text(
                                              'Check Out Other Days',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: infoWidget.titleButton,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: infoWidget.orientation ==
                                            Orientation.portrait
                                        ? infoWidget.screenHeight * 0.02
                                        : infoWidget.screenHeight * 0.03,
                                  ),
                                  _auth.getUserType == 'doctor'
                                      ? SizedBox()
                                      : Text('Stay Healty 💙',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: infoWidget.subTitle),
                                ],
                              ),
                            ),
                          );
                        } else {
                          print(appointements.allAppointment.length);
                          return Expanded(
                              child: ListView.builder(
                            itemBuilder: (ctx, index) => _auth.getUserType !=
                                    'doctor'
                                ? InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => ShowUserProfile(
                                                    type: 'doctor',
                                                    userData: appointements
                                                        .allAppointmentOfPatient[
                                                            index]
                                                        .registerData,
                                                    clinicData: appointements
                                                        .allAppointmentOfPatient[
                                                            index]
                                                        .clinicData,
                                                  )));
                                    },
                                    child:
                                        //see app as patient
                                        PatientAppointmentCard(
                                            patientAppointment: appointements
                                                    .allAppointmentOfPatient[
                                                index]))
                                : DoctorAppointmentCard(
                                    cancelButton: _cancelButton,
                                    index: index,
                                    doctorAppointment:
                                        appointements.allAppointment[index],
                                  ),
                            shrinkWrap: true,
                            itemCount: _auth.getUserType == 'doctor'
                                ? appointements.allAppointment.length
                                : appointements.allAppointmentOfPatient.length,
                          ));
                        }
                      })
              ],
            ),
          );
        },
      ),
    );
  }
}
