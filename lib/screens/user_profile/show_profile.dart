import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/user_data.dart';
import 'package:healthbook/providers/auth_controller.dart';

//import 'package:flutter_sms/flutter_sms.dart';
import 'package:healthbook/screens/user_profile/widgets/clinic_info_card.dart';
import 'package:healthbook/screens/user_profile/widgets/personal_info_card.dart';
import 'package:provider/provider.dart';


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
    return InfoWidget(
      builder: (context,infoWidget){
        return  Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '${widget.userData.firstName} ${widget.userData.lastName}'
                ,style: infoWidget.titleButton,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            size: infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight * 0.04:infoWidget.screenHeight * 0.07,
                          ),
                          Positioned(
                              right: 2.9,
                              top: 2.8,
                              child: Container(
                                width: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.023:infoWidget.screenWidth * 0.014,
                                height: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.023:infoWidget.screenWidth* 0.014,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size:
                    MediaQuery
                        .of(context)
                        .orientation == Orientation.portrait
                        ? MediaQuery
                        .of(context)
                        .size
                        .width * 0.05
                        : MediaQuery
                        .of(context)
                        .size
                        .width * 0.035,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //TODO: make pop
                  }),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            body: ListView(
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
        child:  widget.type == 'patient'?
        FadeInImage.assetNetwork(fit: BoxFit.fill,placeholder: 'assets/user.png',image: widget.userData.patientImage)
            :FadeInImage.assetNetwork(fit: BoxFit.fill,placeholder: 'assets/user.png',image: widget.userData.doctorImage)
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
        widget.type == 'doctor'
        ? 'Dr. ${widget.userData.firstName} ${widget.userData.middleName} ${widget.userData.lastName}'
            : '${widget.userData.firstName} ${widget.userData.middleName} ${widget.userData.lastName}',
        style: infoWidget.titleButton.copyWith(color: Colors.blue,fontWeight: FontWeight.w500)),

        /// patient name
        Text(
        widget.type == 'doctor'
        ? widget.userData.speciality==''?'':'Specialty: ${widget.userData.speciality}'
            : widget.userData.job==''?'':"Job: ${widget.userData.job}",
        style: infoWidget.titleButton.copyWith(color: Colors.blue,fontWeight: FontWeight.w500)
        ),

        /// patient job
        SizedBox(
        height: 5.0,
        ),
        widget.userData.aboutYou == ''
        ? SizedBox()
            :Divider(
        color: Colors.grey,
        height: 4,
        ),
        widget.userData.aboutYou == ''
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
        SizedBox(height: infoWidget.screenHeight*0.02,),
        PersonalInfoCard(
        title: infoWidget.title,
        email: '',
        orientation: infoWidget.orientation,
        subTitle: infoWidget.titleButton,
        width: infoWidget.screenWidth,
        address: widget.userData.address,
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
        widget.clinicData==null?SizedBox():ClinicInfoCard(
        name: widget.clinicData.clinicName,
        address:  widget.clinicData.address,
        governorate: widget.clinicData.government,
        fees: widget.clinicData.fees,
        number: widget.clinicData.number[0],
        startTime: widget.clinicData.openingTime,
        endTime: widget.clinicData.clossingTime,
        watingTime: widget.clinicData.waitingTime,
        workingDays: widget.clinicData.workingDays,
        title: infoWidget.title,
        orientation: infoWidget.orientation,
        subTitle: infoWidget.titleButton,
        width: infoWidget.screenWidth,
        )
            : SizedBox()
        ],
        ),
        );},
    );
  }


}
