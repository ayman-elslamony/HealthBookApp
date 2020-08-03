import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/register_user_data.dart';
import 'package:healthbook/providers/auth_controller.dart';

//import 'package:flutter_sms/flutter_sms.dart';
import 'package:healthbook/screens/user_profile/widgets/clinic_info_card.dart';
import 'package:healthbook/screens/user_profile/widgets/personal_info_card.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  static const routeName = 'UserProfile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Auth _auth;

  final GlobalKey<ScaffoldState> _userProfileState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<Auth>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _userProfileState,
        body: InfoWidget(
          builder: (context,infoWidget){
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 2.0,right: 2.0),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 160,
                        height: 130,
                        child: Container(
                          decoration:
                          BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            //backgroundColor: Colors.white,
                            //backgroundImage:
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              child:  _auth.getUserType == 'patient'?
                              FadeInImage.assetNetwork(fit: BoxFit.fill,placeholder: 'assets/user.png',image: _auth.userData.patientImage)
                                  :FadeInImage.assetNetwork(fit: BoxFit.fill,placeholder: 'assets/user.png',image: _auth.userData.doctorImage)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0,right: 3.0),
                  child: Material(
                    shadowColor: Colors.blueAccent,
                    elevation: 1.0,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                    type: MaterialType.card,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 10.0, right: 10.0, bottom: 0.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                              _auth.getUserType == 'doctor'
                                  ? 'Dr. ${_auth.userData.firstName} ${_auth.userData.middleName} ${_auth.userData.lastName}'
                                  : '${_auth.userData.firstName} ${_auth.userData.middleName} ${_auth.userData.lastName}',
                              style: infoWidget.titleButton.copyWith(color: Colors.blue,fontWeight: FontWeight.w500)),

                          /// patient name
                          Text(
                            _auth.getUserType == 'doctor'
                                ? _auth.userData.speciality==''?'':'Specialty: ${_auth.userData.speciality}'
                                : _auth.userData.job==''?'':"Job: ${_auth.userData.job}",
                            style: infoWidget.titleButton.copyWith(color: Colors.blue,fontWeight: FontWeight.w500)
                          ),

                          /// patient job
                          SizedBox(
                            height: 5.0,
                          ),
                          _auth.userData.aboutYou == ''
                              ? SizedBox()
                              :Divider(
                            color: Colors.grey,
                            height: 4,
                          ),
                          _auth.userData.aboutYou == ''
                              ? SizedBox()
                              : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _auth.getUserType == 'doctor'
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
                                  child: Text(_auth.userData.aboutYou,
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
                SizedBox(height: infoWidget.screenHeight*0.02,),
                PersonalInfoCard(
                  title: infoWidget.title,
                   orientation: infoWidget.orientation,
                  subTitle: infoWidget.titleButton,
                  width: infoWidget.screenWidth,
                  address: _auth.userData.address,
                  email: _auth.email,
                  gender: _auth.userData.gender,
                  governorate: _auth.userData.government,
                  language: 'Arabic and English',
                  maritalStatus: _auth.userData.status,
                  phoneNumber: _auth.userData.number,
                ),
//           _isDoctor? SizedBox():UserHistory(),
//            _isDoctor? SizedBox(): UserVitals(),
//            _isDoctor? SizedBox():UserLabResult(),
                _auth.getUserType == 'doctor'?
                _auth.getClinicData==null?SizedBox():ClinicInfoCard(
                  name: _auth.getClinicData.clinicName,
                  address:  _auth.getClinicData.address,
                  governorate: _auth.getClinicData.government,
                  fees: _auth.getClinicData.fees,
                  number: _auth.getClinicData.number,
                  startTime: _auth.getClinicData.openingTime,
                  endTime: _auth.getClinicData.clossingTime,
                  watingTime: _auth.getClinicData.waitingTime,
                  workingDays: _auth.getClinicData.workingDays,
                  title: infoWidget.title,
                  orientation: infoWidget.orientation,
                  subTitle: infoWidget.titleButton,
                  width: infoWidget.screenWidth,
                )
                    : SizedBox()
              ],
            );
          },
        ));
  }
}
