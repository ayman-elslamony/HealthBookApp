import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/register_user_data.dart';
import 'package:healthbook/providers/auth_controller.dart';

//import 'package:flutter_sms/flutter_sms.dart';
import 'package:healthbook/screens/user_profile/widgets/clinic_info_card.dart';
import 'package:healthbook/screens/user_profile/widgets/personal_info_card.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class ShowUserProfile extends StatefulWidget {
  final RegisterData userData;
  final ClinicData clinicData;
  final String type;
  ShowUserProfile({this.userData, this.type,this.clinicData});
  @override
  _ShowUserProfileState createState() => _ShowUserProfileState();
}

class _ShowUserProfileState extends State<ShowUserProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          color: Colors.blue,
        ),
      ),
        body: ListView(
          children: <Widget>[
            Stack(children: [
              Container(
                height: 140,
                width: double.infinity,
                color: Colors.blueAccent,
                child: Center(
                  child: SizedBox(
                    width: 130,
                    height: 130,
                    child: ClipRRect(
                      //backgroundColor: Colors.white,
                      //backgroundImage:
                        child:  widget.type == 'patient'?
                        FadeInImage.assetNetwork(placeholder: 'assets/user.png',image: widget.userData.patientImage)
                            :FadeInImage.assetNetwork(placeholder: 'assets/user.png',image: widget.userData.doctorImage)
                    ),
                  ),
                ),
              ),
//             _isDoctor? Positioned(
//               child: FlatButton.icon(
//                 color: Colors.red,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                   padding: EdgeInsets.all(8.0),
//                   onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserSignUp()));
//                   },
//                   icon: Icon(
//                     Icons.mode_edit,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                   label: Text(
//                     'Edit Profile',
//                     style: TextStyle(color: Colors.white),
//                   )),
//               right: 3.0,
//               top: 1.0,
//             ):Positioned(
//                child: FlatButton.icon(
//                    padding: EdgeInsets.all(0.0),
//                    onPressed: _cancelButton,
//                    icon: Icon(
//                      Icons.delete,
//                      color: Colors.red,
//                      size: 18,
//                    ),
//                    label: Text(
//                      'Cancel',
//                      style: TextStyle(color: Colors.red),
//                    )),
//                right: 3.0,
//                top: 1.0,
//              ) ,
//              Navigator.canPop(context)? Positioned(
//                child: BackButton(color: Colors.white,onPressed: (){Navigator.of(context).pop();},)
//                ,left: 3.0,
//                top: 1.0,
//              ):SizedBox()
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                shadowColor: Colors.blueAccent,
                elevation: 8.0,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                type: MaterialType.card,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 0.0, left: 10.0, right: 10.0, bottom: 0.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                          widget.type == 'doctor'
                              ? 'Dr. ${widget.userData.firstName} ${widget.userData.middleName} ${widget.userData.lastName}'
                              : '${widget.userData.firstName} ${widget.userData.middleName} ${widget.userData.lastName}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),

                      /// patient name
                      Text(
                        widget.type == 'doctor'
                            ? 'Specialty: ${widget.userData.speciality}'
                            : "Job: ${widget.userData.job}",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),

                      /// patient job
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4,
                      ),
                      widget.userData.aboutYou == null
                          ? SizedBox()
                          : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.type == 'doctor'
                                  ? 'Bio'
                                  : "About",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 5.0),
                              child: Text(widget.userData.aboutYou,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            PersonalInfoCard(
              address: widget.userData.address,
              email: widget.userData.email??'',
              gender: widget.userData.gender,
              governorate: widget.userData.government,
              language: 'Arabic and English',
              maritalStatus: widget.userData.status,
              phoneNumber: widget.userData.number,
            ),
//           _isDoctor? SizedBox():UserHistory(),
//            _isDoctor? SizedBox(): UserVitals(),
//            _isDoctor? SizedBox():UserLabResult(),
            widget.type == 'doctor'?
            ClinicInfoCard(
              address:  widget.clinicData.address,
              governorate: widget.clinicData.government,
              fees: widget.clinicData.fees,
              startTime: widget.clinicData.openingTime,
              endTime: widget.clinicData.clossingTime,
              watingTime: widget.clinicData.waitingTime,
              workingDays: [widget.clinicData.workingDays],
            )
                : SizedBox()
          ],
        ));
  }
}
