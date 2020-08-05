import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/models/patient_appointment.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

//import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientAppointmentCard extends StatelessWidget {
  final PatientAppointment patientAppointment;

  PatientAppointmentCard({this.patientAppointment});

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
                  Row(
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
                                image: patientAppointment.registerData.doctorImage,
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
                                      'Dr. ${patientAppointment.registerData.firstName} ${patientAppointment.registerData.lastName}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: infoWidget.title),
                                ),
                                RatingBar(
                                  rating: 3,
                                  icon: Icon(
                                    Icons.star,
                                    size: infoWidget.screenWidth* 0.04,
                                    color: Colors.grey,
                                  ),
                                  starCount: 5,
                                  spacing: 2.0,
                                  size: infoWidget.screenWidth*0.03,
                                  isIndicator: true,
                                  allowHalfRating: true,
                                  onRatingCallback: (double value,
                                      ValueNotifier<bool> isIndicator) {
                                    //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                                    isIndicator.value = true;
                                  },
                                  color: Colors.amber,
                                ),
                            ],)
                            ,
                            Padding(
                              padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Text('Speciality: ${patientAppointment.registerData.speciality}',
                                        style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)),
                                  ),
                                  Text(
                                      'Avilable',
                                      style:
                                      infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)
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
                                      'Location: ${patientAppointment.clinicData.address}',
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
                                      'Appointement at ${patientAppointment.appointStart} PM',
                                      style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text('19 min left',
                                      style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)),
                                ],),
                            )
                          ],
                        ),
                      )
                    ],
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
                          launch(
                              "tel:${patientAppointment.registerData.number}");
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(infoWidget.defaultHorizontalPadding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: infoWidget.screenWidth*0.05,
                                  ),
                                  Text(
                                    ' Call ',
                                    style: infoWidget.titleButton,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
//                        sendSMS(message: 'Hello Patient', recipients: ['+201145523795'])
//                            .catchError((onError) {
//                          print(onError);
//                        });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(infoWidget.defaultHorizontalPadding),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                    size: infoWidget.screenWidth*0.05,
                                  ),
                                  Text(
                                    ' Message ',
                                    style: infoWidget.titleButton,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: ()async{
                          Auth _auth = Provider.of<Auth>(context,listen: false);
                          bool x = await _auth.deleteAppointmentForPatAndDoc(appointmentId: patientAppointment.appointmentId,type: 'patient');
                            if(x==true){
                              Toast.show('SuccessFully deleted', context);
                            }else{
                              Toast.show('failed to deleted', context);
                            }
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
