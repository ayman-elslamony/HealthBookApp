import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
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
    _cancelButton() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                Navigator.of(context).pop();
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
                _userProfileState.currentState.showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
        key: _userProfileState,
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
                         child:  _auth.getUserType == 'patient'?
                    FadeInImage.assetNetwork(placeholder: 'assets/user.png',image: _auth.userData.patientImage)
                :FadeInImage.assetNetwork(placeholder: 'assets/user.png',image: _auth.userData.doctorImage)
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
                          _auth.getUserType == 'doctor'
                              ? 'Dr. ${_auth.userData.firstName} ${_auth.userData.middleName} ${_auth.userData.lastName}'
                              : '${_auth.userData.firstName} ${_auth.userData.middleName} ${_auth.userData.lastName}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),

                      /// patient name
                      Text(
                        _auth.getUserType == 'doctor'
                            ? 'Specialty: ${_auth.userData.speciality}'
                            : "Job: ${_auth.userData.job}",
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
                      _auth.userData.aboutYou == null
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
            PersonalInfoCard(
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
                 ClinicInfoCard(
                    address:  _auth.getClinicData.address,
                    governorate: _auth.getClinicData.government,
                    fees: _auth.getClinicData.fees,
                   startTime: _auth.getClinicData.openingTime,
                   endTime: _auth.getClinicData.clossingTime,
                    watingTime: _auth.getClinicData.waitingTime,
                    workingDays: [_auth.getClinicData.workingDays],
                  )
                : SizedBox()
          ],
        ));
  }
}
