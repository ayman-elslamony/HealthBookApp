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
  final List<DrugList> allDrugList = [
    DrugList(
        diagnoseName: 'Diabetes mellitus (ICD-250)',
        diagnoseDate: '12-10-2020',
        allDoctorsInEachDosage: [
          DoctorsInEachDosage(
              date: '5-6-77',
              doctorData: RegisterData(
                  firstName: 'ahmed',
                  middleName: 'mohamed',
                  lastName: 'nour',
                  number: '01145523795',
                  status: 'not',
                  job: 'Doctor',
                  government: 'Mansoura',
                  gender: 'Male',
                  birthDate: '12/5/2020',
                  aboutYou: 'iam doctor',
                  address: 'man man man ',
                  speciality: 'doc',
                  patientImage:
                      'https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png'),
              allPrescription: [
                Prescription(
                    prescriptionDate: '12-1-2020',
                    prescriptionName: 'Prescription One',
                    allMedicine: [
                      Medicine(
                          medicineName: 'panadol extra',
                          medicineDosage: 'each 4 hour'),
                      Medicine(
                          medicineName: 'extramol',
                          medicineDosage: 'each 12 hour'),
                    ],
                    allAnalysis: [
                      RadiologyAndAnalysisStructure(
                          name: 'dfn',
                          description: 'fedg etet tt',
                          image:
                              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
                      RadiologyAndAnalysisStructure(
                          name: 'ggg',
                          description: 'fgdtet dgtt',
                          image:
                              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
                    ],
                    allRadiology: [
                      RadiologyAndAnalysisStructure(
                          name: 'drttrn',
                          description: 'feazg ett',
                          image:
                              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
                      RadiologyAndAnalysisStructure(
                          name: 'giuoig',
                          description: 'fgqqet dgtt',
                          image:
                              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
                    ]),
                Prescription(
                    prescriptionDate: '8-11-2020',
                    prescriptionName: 'Prescription two',
                    allMedicine: [
                      Medicine(
                          medicineName: 'novadol',
                          medicineDosage: 'each 24 hour'),
                      Medicine(
                          medicineName: 'omega3',
                          medicineDosage: 'each 12 hour'),
                    ]),
              ]),
          DoctorsInEachDosage(
              date: '5-6-77',
              doctorData: RegisterData(
                  firstName: 'Ayman',
                  middleName: 'Kamel',
                  lastName: 'Elslamony',
                  number: '01145523795',
                  status: 'not',
                  job: 'Doctor',
                  government: 'Mansoura',
                  gender: 'Male',
                  birthDate: '12/5/2020',
                  aboutYou: 'iam doctor',
                  address: 'man man man ',
                  speciality: 'doc',
                  patientImage:
                      'https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png'),
              allPrescription: [
                Prescription(
                    prescriptionDate: '2-1-2020',
                    prescriptionName: 'Prescription three',
                    allMedicine: [
                      Medicine(
                          medicineName: 'zeta', medicineDosage: 'each 2 hour'),
                      Medicine(
                          medicineName: 'beta', medicineDosage: 'each 1 hour'),
                    ]),
                Prescription(
                    prescriptionDate: '8-1-2020',
                    prescriptionName: 'Prescription one',
                    allMedicine: [
                      Medicine(
                          medicineName: 'zeta', medicineDosage: 'each 2 hour'),
                      Medicine(
                          medicineName: 'beta', medicineDosage: 'each 1 hour'),
                    ]),
              ]),
        ]),
    DrugList(
        diagnoseName: 'mellitus (ICD-250)',
        diagnoseDate: '1-1-2020',
        allDoctorsInEachDosage: [
          DoctorsInEachDosage(
              date: '5-6-77',
              doctorData: RegisterData(
                  firstName: 'nour',
                  middleName: 'marwan',
                  lastName: 'nemar',
                  number: '01145523795',
                  status: 'not',
                  job: 'Doctor',
                  government: 'Mansoura',
                  gender: 'Male',
                  birthDate: '12/5/2020',
                  aboutYou: 'iam doctor',
                  address: 'man man man ',
                  speciality: 'doc',
                  patientImage:
                      'https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png'),
              allPrescription: [
                Prescription(
                    prescriptionDate: '12-1-2020',
                    prescriptionName: 'Prescription One',
                    allMedicine: [
                      Medicine(
                          medicineName: 'panadol extra',
                          medicineDosage: 'each 4 hour')
                    ]),
              ]),
        ])
  ];

  final GlobalKey<ScaffoldState> _patientHealthRecordState =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _auth =Provider.of<Auth>(context,listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _cancelButton() {
      Auth _auth = Provider.of<Auth>(context, listen: false);
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
                              Row(children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.video_call,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
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

                                    await PermissionHandler().requestPermissions(
                                      [PermissionGroup.camera, PermissionGroup.microphone],
                                    );
                                      CallUtils.dial(
                                        from: sender,
                                        to: receiver,
                                        context: context,
                                      );

                                  }

                                ),
                              ],)
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Health Record:",
                          style: infoWidget.titleButton
                              .copyWith(color: Colors.blue,fontWeight: FontWeight.w600),
                        ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowHealthRecord(
                            allDrugList: allDrugList,
                            diagnoseName: allDrugList[index].diagnoseName,
                            indexForDrugList: index,
                          )));
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            allDrugList[index].diagnoseName,
                            style: infoWidget.titleButton,
                          ),
                        ),
                      ),
                      itemCount: allDrugList.length,
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
