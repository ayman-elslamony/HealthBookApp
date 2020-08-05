import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/screens/user_profile/patient_health_record.dart';
import 'package:healthbook/screens/user_profile/show_profile.dart';
import '../user_profile/user_profile.dart';

class DoctorAppointmentCard extends StatefulWidget {
  final Function cancelButton;
  final DoctorAppointment doctorAppointment;
  DoctorAppointmentCard({this.cancelButton,this.doctorAppointment});

  @override
  _DoctorAppointmentCardState createState() => _DoctorAppointmentCardState();
}

class _DoctorAppointmentCardState extends State<DoctorAppointmentCard> {
  AgeDuration birthDate;
  List<String> mybirth=[];
  @override
  void initState() {
    DateTime today = DateTime.now();
    mybirth=widget.doctorAppointment.registerData.birthDate.split('/');
    print(mybirth);
    DateTime birthday = DateTime(mybirth.length!=3?2020:int.parse(mybirth[2]),mybirth.length!=3?1:int.parse(mybirth[1]),mybirth.length!=3?1: int.parse(mybirth[0]));
    birthDate = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return InfoWidget(
      builder: (context, infoWidget) {

        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: infoWidget.defaultVerticalPadding,
              horizontal: infoWidget.defaultHorizontalPadding),
          child: Material(
            shadowColor: Colors.blueAccent,
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            type: MaterialType.card,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: infoWidget.defaultVerticalPadding *1.5,
                  horizontal: infoWidget.defaultHorizontalPadding * 1.3),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                      ShowUserProfile(
                        userData: widget.doctorAppointment.registerData,
                        type: 'patient',
                      )
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(infoWidget.orientation == Orientation.portrait
                                    ? 35.0:55.0)),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/user.png',
                                  image: widget.doctorAppointment.registerData.patientImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width:  infoWidget.screenWidth * 0.18//
                              ,
                              height: infoWidget.screenWidth * 0.18,
                            ),
                          ],
                        ),
                        SizedBox(width: infoWidget.defaultVerticalPadding,),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        '${widget.doctorAppointment.registerData.firstName} ${widget.doctorAppointment.registerData.lastName}'
                                        ,maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: infoWidget.title),
                                  ),
                                  Text(
                                    widget.doctorAppointment.appointDate,
                                    style:
                                    infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500,color: Colors.blue),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],)
                              ,
                              mybirth.length!=3?SizedBox():Padding(
                                padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('Age: ${birthDate.years} years',
                                          style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)),
                                    ),
                                  ],),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                    'Appointement number: 1',
                                        style:
                                        infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child:  Text(
                                        'Appointement at ${widget.doctorAppointment.appointStart} PM',
                                        style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.02:infoWidget.screenHeight*0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PatientHealthRecord(doctorAppointment: widget.doctorAppointment,)));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(infoWidget.defaultHorizontalPadding),
                              child: Text(
                                ' View H.Record ',
                                style: infoWidget.titleButton,
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: (){
                          print(widget.doctorAppointment.appointmentId);
                          widget.cancelButton(widget.doctorAppointment.appointmentId);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(infoWidget.defaultHorizontalPadding),

                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: infoWidget.titleButton,
                                ),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
