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
bool isLoading=true;
  @override
  void initState() {
    super.initState();
    _auth = Provider.of<Auth>(context, listen: false);
    getAllAppoitment();
  }
  getAllAppoitment()async{

      await _auth.getUserAppointment();

    setState(() {
      isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    _cancelButton() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: ColorizeAnimatedTextKit(
              totalRepeatCount: 9,
              pause: Duration(milliseconds: 1000),
              isRepeatingAnimation: true,
              speed: Duration(seconds: 1),
              text: [' please tell the patient '],
              textAlign: TextAlign.center,
              textStyle: TextStyle(fontSize: 23.0, fontFamily: "Horizon"),
              colors: [
                Colors.blue,
                Colors.green,
                Colors.blue,
              ],
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
          content: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {


                      launch("tel://21213123123");



                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 38,
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
                    onTap: () {
//                      sendSMS(message: 'Hello Patient', recipients: ['+201145523795'])
//                          .catchError((onError) {
//                        print(onError);
                      //  });
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
                  content: Text(
                    'SuccessFully deleted',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  duration: Duration(seconds: 5),
                  backgroundColor: Colors.blue,
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                );
                _scaffoldState.currentState.showSnackBar(snackBar);
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    return InfoWidget(
      builder: (context,infoWidget){
        DeviceInfo x =infoWidget;
        print(infoWidget.orientation);
        return Scaffold(
          key: _scaffoldState,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.015:infoWidget.screenHeight*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                          _auth.getUserType != 'doctor'
                              ? 'Welcome ${_auth.userData.firstName} ${_auth.userData.lastName} !'
                              : 'Welcome Dr. ${_auth.userData.firstName} ${_auth.userData.lastName} ',
                          style: infoWidget.subTitle
                          ),
                    ],
                  ),
                ],
              ),
              AppointmentsDateCard(),
              isLoading?Expanded(child: Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,),)):Consumer<Auth>(builder: (context, appointements, _) {
                if (_auth.getUserType == 'doctor'?
                appointements.allAppointment.length==0 :appointements.allAppointmentOfPatient.length==0) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'You don\'t have any appointement for this week',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: infoWidget.orientation ==Orientation.portrait?infoWidget.screenWidth*0.04:infoWidget.screenWidth*0.035,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.02:infoWidget.screenHeight*0.03,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue,
                                          blurRadius: 40.0,
                                          // has the effect of softening the shadow
                                          spreadRadius: 1.0,
                                          // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0, // horizontal, move right 10
                                            10.0, // vertical, move down 10
                                          ),
                                        )
                                      ],
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: infoWidget.screenHeight*0.06,vertical: infoWidget.screenHeight*0.015),
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Check Out Other Days',
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: infoWidget.orientation ==Orientation.portrait?infoWidget.screenWidth*0.048:infoWidget.screenWidth*0.035,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.02:infoWidget.screenHeight*0.03,
                          ),
                          Text(
                            'Stay Healty 💙',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: infoWidget.orientation ==Orientation.portrait?infoWidget.screenWidth*0.048:infoWidget.screenWidth*0.035,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  print(appointements.allAppointment.length);
                  return Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) =>
                        _auth.getUserType != 'doctor'
                            ?
                        InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_)=>ShowUserProfile(
                                type: 'doctor',
                                userData: appointements.allAppointmentOfPatient[index].registerData,
                                clinicData: appointements.allAppointmentOfPatient[index].clinicData,
                              )));
                            },
                            child:
                            //see app as patient
                            PatientAppointmentCard(patientAppointment: appointements.allAppointmentOfPatient[index])
                        ): DoctorAppointmentCard(
                          cancelButton: _cancelButton,
                          //see app as doctor
                          doctorAppointment: appointements.allAppointment[index],
                        ),
                        itemCount:
                        _auth.getUserType == 'doctor'?
                        appointements.allAppointment.length :appointements.allAppointmentOfPatient.length,
                      )
                  );
                }
              })
            ],
          ),
        );
      },
    );
  }
}
