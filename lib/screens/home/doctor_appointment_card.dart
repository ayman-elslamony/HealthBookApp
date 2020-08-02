import 'package:age/age.dart';
import 'package:flutter/material.dart';
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Material(
        shadowColor: Colors.blueAccent,
        elevation: 8.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        type: MaterialType.card,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 8.0),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_)=>ShowUserProfile(
                    type: 'patient',
                    userData: widget.doctorAppointment.registerData,
                  )));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: FadeInImage.assetNetwork(placeholder: 'assets/user.png', image: widget.doctorAppointment.registerData.patientImage,fit: BoxFit.fill,),
                          ),
                          width: 45,
                          height: 50,
                        ),
                      ],
                    )
                    ,Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text('${widget.doctorAppointment.registerData.firstName} ${widget.doctorAppointment.registerData.lastName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.display1.copyWith(fontSize: 18)),
                        ),
                        mybirth.length!=3?SizedBox():Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Age: ${birthDate.years} years',
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 4),
                          child: Text(
                            'Appointement number: 1',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(fontSize: 14,color: Colors.black87,),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Appointement time : ${widget.doctorAppointment.appointStart}',
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on,color: Colors.blue,),
                            Text(
                              widget.doctorAppointment.registerData.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 14,color: Colors.black87,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          widget.doctorAppointment.appointDate,
                        textAlign: TextAlign.end,
                        style:
                        Theme.of(context).textTheme.display3.copyWith(
                          fontSize: 14,
                        ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                          PatientHealthRecord.routeName);
                    },
                    child: Container(
                        height:  35,
                        width: 118,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Text(
                                'View H.Record',
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: widget.cancelButton,
                    child: Container(
                        height:  38,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize:16),
                          ),
                        )),
                  ),
                ],
              )

            ],
          )
        ),
      ),
    );
  }
}
