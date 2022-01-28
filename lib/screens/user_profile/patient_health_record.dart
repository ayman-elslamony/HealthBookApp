import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/call.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/models/user_data.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/drugs_radiology_analysis/drugs_radiology_analysis.dart';
import 'package:healthbook/screens/patient_prescription/widgets/patient_prescription.dart';
import 'package:healthbook/utils/call_utilities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/show_patient_health_record.dart';


class PatientHealthRecord extends StatefulWidget {
  final DoctorAppointment doctorAppointment;

  PatientHealthRecord({this.doctorAppointment});

  static const routeName = 'PatientHealthRecord';

  @override
  _PatientHealthRecordState createState() => _PatientHealthRecordState();
}

class _PatientHealthRecordState extends State<PatientHealthRecord> {
  Auth _auth;
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _patientHealthRecordState =
      GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _auth = Provider.of<Auth>(context, listen: false);
    getHistory();
    super.initState();
  }

  getHistory() async {
    print('widget.doctorAppointment.registerData.id${widget.doctorAppointment.registerData.id}');
    await _auth.getAllDiagnoseName(patientId: widget.doctorAppointment.registerData.id);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    _cancelButton() {
      Auth _auth = Provider.of<Auth>(context, listen: false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:const  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: AnimatedTextKit(animatedTexts:[
            ColorizeAnimatedText(

              ' please tell the patient ',
              textAlign: TextAlign.center,
              textStyle:const  TextStyle(fontSize: 23.0, fontFamily: "Horizon"),
              colors: [
                Colors.blue,
                Colors.green,
                Colors.blue,
              ],
          )],
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
              onPressed: () async{
                bool x =await  _auth.deleteAppointmentForPatAndDoc(appointmentId: widget.doctorAppointment.appointmentId,type: 'doctor');
                if(x==true){
                  final snackBar = SnackBar(
                    content: Text(
                      'SuccessFully deleted',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.blue,
                  );
                  _patientHealthRecordState.currentState.showSnackBar(snackBar);
                  Navigator.of(ctx).pop();
                  await Future.delayed(Duration(seconds: 2),(){
                    Navigator.of(context).pop();
                  });
                }else{
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
                  _patientHealthRecordState.currentState.showSnackBar(snackBar);
                  Navigator.of(ctx).pop();
                }

              },
            )
          ],
        ),
      );
    }
    return InfoWidget(
      builder: (context, infoWidget) {
        return Scaffold(
            key: _patientHealthRecordState,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.05
                        : MediaQuery.of(context).size.width * 0.035,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //TODO: make pop
                  }),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PatientPrescription(
                            doctorAppointment: widget.doctorAppointment,
                          )));
                    },
                    child: Center(
                        child: Text('Adding Prescription',
                            style: infoWidget.titleButton)),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    infoWidget.orientation ==
                                            Orientation.portrait
                                        ? 35.0
                                        : 55.0)),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/user.png',
                                  image: widget.doctorAppointment.registerData.patientImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: infoWidget.screenWidth * 0.18 //
                              ,
                              height: infoWidget.screenWidth * 0.18,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: infoWidget.defaultVerticalPadding,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Text('${widget.doctorAppointment.registerData.firstName} ${widget.doctorAppointment.registerData.lastName}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: infoWidget.title
                                            .copyWith(color: Colors.blue)),
                                  ),
                                  FlatButton.icon(
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: _cancelButton,
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.blue,
                                      size: infoWidget.orientation ==
                                              Orientation.portrait
                                          ? infoWidget.screenWidth * 0.057
                                          : infoWidget.screenWidth * 0.035,
                                    ),
                                    label: Text('Cancel',
                                        style: infoWidget.titleButton.copyWith(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: infoWidget.orientation == Orientation.portrait
                        ? infoWidget.screenHeight * 0.02
                        : infoWidget.screenHeight * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: infoWidget.defaultHorizontalPadding*2.5,
                        vertical: infoWidget.defaultVerticalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Health Record:",
                          style: infoWidget.titleButton
                              .copyWith(color: Colors.blue,fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () async {
                            UserCall sender= UserCall(
                              uid: _auth.userId,
                              name: '${_auth.userData.firstName} ${_auth.userData.lastName}',
                              profilePhoto: _auth.userData.patientImage,
                              username: '${_auth.userData.firstName} ${_auth.userData.lastName}',
                            );
                            UserCall receiver= UserCall(
                              uid: widget.doctorAppointment.registerData.id,
                              name: '${widget.doctorAppointment.registerData.firstName} ${widget.doctorAppointment.registerData.lastName}',
                              profilePhoto: widget.doctorAppointment.registerData.patientImage,
                              username: '${widget.doctorAppointment.registerData.firstName} ${widget.doctorAppointment.registerData.lastName}',
                            );

                            await [Permission.microphone, Permission.camera].request();
                            CallUtils.dial(
                              from: sender,
                              to: receiver,
                              context: context,
                            );

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[ Icon(
                            Icons.video_call,
                            color: Colors.blue,
                            size: 25,
                          ),
                              Text('Video Call',
                                  style: infoWidget.titleButton.copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.normal)),

                            ],),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 6,
                    color: Colors.blue,
                  ),
                  Divider(
                    height: 6,
                    color: Colors.blue,
                  ),
                  isLoading
                      ? SizedBox(
                    width: infoWidget.screenWidth,
                        height: infoWidget.screenHeight*0.65,
                        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  ),
                      )
                      : Consumer<Auth>(
                    builder: (context,data,_){
                      if(data.allDiagnose.length == 0){
                        return SizedBox(
                          width: infoWidget.screenWidth,
                          height: infoWidget.screenHeight*0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: infoWidget.screenWidth,
                                height: infoWidget.screenHeight * 0.05,
                                child:
                                ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    SizedBox(),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('There in no any records yet',style: infoWidget.titleButton.copyWith(color: Colors.blue),maxLines: 3,),
                                ],
                              )
                            ],
                          ),
                        );
                      }else{
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowHealthRecord(
                                  diagnoseName: data.allDiagnose[index],
                                  patientId: widget.doctorAppointment.registerData.id,
                                )));
                              },
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  data.allDiagnose[index],
                                  style: infoWidget.titleButton,
                                ),
                              ),
                            ),
                            itemCount: data.allDiagnose.length,
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ));
      },
    );
  }
}
