import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/models/patient_appointment.dart';
//import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientAppointmentCard extends StatelessWidget {
  PatientAppointment patientAppointment;

  PatientAppointmentCard({this.patientAppointment});

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
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: FadeInImage.assetNetwork(placeholder: 'assets/user.png', image: patientAppointment.registerData.doctorImage,fit: BoxFit.fill,),
                      ),
                      width: 45,
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Dr. ${patientAppointment.registerData.firstName} ${patientAppointment.registerData.lastName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.display1),
                        Text('${patientAppointment.registerData.speciality}',
                            style: Theme.of(context)
                                .textTheme
                                .display2
                                .copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                        Text(
                          'appointement at ${patientAppointment.appointStart} PM',
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 15,color: Colors.black87,),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on),
                            Text(
                              '${patientAppointment.registerData.address}',
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 15,color: Colors.black87,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        RatingBar(
                          rating: 3,
                          icon: Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.grey,
                          ),
                          starCount: 5,
                          spacing: 2.0,
                          size: 15,
                          isIndicator: true,
                          allowHalfRating: true,
                          onRatingCallback:
                              (double value, ValueNotifier<bool> isIndicator) {
                            //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                            isIndicator.value = true;
                          },
                          color: Colors.amber,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Avilable',
                            style:
                                Theme.of(context).textTheme.display3.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('19 min left',
                            style: Theme.of(context)
                                .textTheme
                                .display3
                                .copyWith(fontSize: 15)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        launch("tel:${patientAppointment.registerData.number}");
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
//                        sendSMS(message: 'Hello Patient', recipients: ['+201145523795'])
//                            .catchError((onError) {
//                          print(onError);
//                        });
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
                    Container(
                        height:  38,
                        width: 93,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize:19),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
