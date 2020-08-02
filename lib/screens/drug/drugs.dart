import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/core/models/device_info.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/register_user_data.dart';
import 'package:healthbook/screens/patient_prescription/show_previous_patient_precription.dart';
import 'package:healthbook/screens/user_profile/user_profile.dart';

class DoctorsInEachDosage {
  bool _showDoctor = false;

  set showDoctorSet(bool value) {
    _showDoctor = value;
  }

  bool get showDoctorGet => _showDoctor;
  RegisterData doctorData;
  String date;
  List<Prescription> allPrescription = [];

  DoctorsInEachDosage({this.doctorData, this.date, this.allPrescription});
}

class Prescription {
  String prescriptionName;
  String prescriptionDate;
  List<Medicine> allMedicine = [];

  Prescription(
      {this.prescriptionName, this.prescriptionDate, this.allMedicine});
}

class Medicine {
  String medicineName;
  String medicineDosage;

  Medicine({this.medicineName, this.medicineDosage});
}

class DrugList {
  bool _showDiagnose = false;

  set showDiagnoseSet(bool value) {
    _showDiagnose = value;
  }

  bool get showDiagnoseGet => _showDiagnose;

  String dosageName;
  String dosageDate;
  List<DoctorsInEachDosage> allDoctorsInEachDosage = [];

  DrugList({this.dosageName, this.dosageDate, this.allDoctorsInEachDosage});
}

class Drug extends StatefulWidget {
  @override
  _DrugState createState() => _DrugState();
}

class _DrugState extends State<Drug> {
  List<DrugList> allDrugList = [
    DrugList(
        dosageName: 'Diabetes mellitus (ICD-250)',
        dosageDate: '12-10-2020',
        allDoctorsInEachDosage: [
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
                    prescriptionDate: '12-1-2020',
                    prescriptionName: 'Prescription One',
                    allMedicine: [
                      Medicine(
                          medicineName: 'panadol extra',
                          medicineDosage: 'each 4 hour')
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
                    prescriptionDate: '12-1-2020',
                    prescriptionName: 'Prescription One',
                    allMedicine: [
                      Medicine(
                          medicineName: 'panadol extra',
                          medicineDosage: 'each 4 hour')
                    ]),
              ]),
        ]),
    DrugList(
        dosageName: 'mellitus (ICD-250)',
        dosageDate: '1-1-2020',
        allDoctorsInEachDosage: [
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

  Widget _userProblems({String problemName, DeviceInfo infoWidget}) {
    return Material(
      shadowColor: Colors.blueAccent,
      elevation: 3.0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      type: MaterialType.card,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    allDrugList[0].showDiagnoseSet =
                        !allDrugList[0].showDiagnoseGet;
                  });
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text("Diagnose: ${allDrugList[0].dosageName}",
                            maxLines: 1,
                            style: infoWidget.title.copyWith(
                              color: Colors.blue,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(allDrugList[0].dosageDate,
                        style: infoWidget.titleButton.copyWith(
                          color: Colors.grey,
                        )),
                    Icon(
                      allDrugList[0].showDiagnoseGet
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 25,
                    ),
                  ],
                )),
          ),
          allDrugList[0].showDiagnoseGet
              ? Divider(
                  color: Colors.grey,
                  height: 1,
                )
              : SizedBox(),
          allDrugList[0].showDiagnoseGet
              ? Padding(
                  padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Color(0xfffafbff),
                        shadowColor: Colors.blueAccent,
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        type: MaterialType.card,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    allDrugList[0]
                                            .allDoctorsInEachDosage[index]
                                            .showDoctorSet =
                                        !allDrugList[0]
                                            .allDoctorsInEachDosage[index]
                                            .showDoctorGet;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                              "Dr: ${allDrugList[0].allDoctorsInEachDosage[index].doctorData.firstName} ${allDrugList[0].allDoctorsInEachDosage[index].doctorData.lastName}",
                                              maxLines: 1,
                                              style: infoWidget.title.copyWith(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            allDrugList[0]
                                                .allDoctorsInEachDosage[index]
                                                .date,
                                            style:
                                                infoWidget.titleButton.copyWith(
                                              color: Colors.grey,
                                            )),
                                      ),
                                      Icon(
                                        allDrugList[0]
                                                .allDoctorsInEachDosage[index]
                                                .showDoctorGet
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size: 25,
                                      ),
                                    ],
                                  ),
                                )),
                            allDrugList[0]
                                    .allDoctorsInEachDosage[index]
                                    .showDoctorGet
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Divider(
                                      color: Colors.grey,
                                      height: 4,
                                    ),
                                  )
                                : SizedBox(),
                            allDrugList[0]
                                    .allDoctorsInEachDosage[index]
                                    .showDoctorGet
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            infoWidget.defaultVerticalPadding,
                                        left:
                                            infoWidget.defaultHorizontalPadding,
                                        right: infoWidget
                                            .defaultHorizontalPadding),
                                    child: Column(children: <Widget>[
                                      Container(
//
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              infoWidget.orientation ==
                                                                      Orientation
                                                                          .portrait
                                                                  ? 35.0
                                                                  : 55.0)),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                            'assets/user.png',
                                                        image:
                                                            'https://res.cloudinary.com/dmmnnncjd/image/upload/v1595866185/ceqcpxokjyyiofznctpv.jpg'
                                                        //patientAppointment.registerData.doctorImage,
                                                        ,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    width:
                                                        infoWidget.screenWidth *
                                                            0.18,
                                                    height:
                                                        infoWidget.screenWidth *
                                                            0.18,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: infoWidget
                                                    .defaultVerticalPadding,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                              "Dr: ${allDrugList[0].allDoctorsInEachDosage[index].doctorData.firstName} ${allDrugList[0].allDoctorsInEachDosage[index].doctorData.lastName}",
                                                              //${patientAppointment.registerData.firstName} ${patientAppointment.registerData.lastName}',
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: infoWidget
                                                                  .title
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                        ),
                                                        RatingBar(
                                                          rating: 3,
                                                          icon: Icon(
                                                            Icons.star,
                                                            size: infoWidget
                                                                    .screenWidth *
                                                                0.04,
                                                            color: Colors.grey,
                                                          ),
                                                          starCount: 5,
                                                          spacing: 2.0,
                                                          size: infoWidget
                                                                  .screenWidth *
                                                              0.03,
                                                          isIndicator: true,
                                                          allowHalfRating: true,
                                                          onRatingCallback: (double
                                                                  value,
                                                              ValueNotifier<
                                                                      bool>
                                                                  isIndicator) {
                                                            //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                                                            isIndicator.value =
                                                                true;
                                                          },
                                                          color: Colors.amber,
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: infoWidget
                                                              .defaultVerticalPadding),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                                'Speciality: '
                                                                //${patientAppointment.registerData.speciality}',
                                                                ,
                                                                style: infoWidget
                                                                    .subTitle.copyWith(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: infoWidget
                                                              .defaultVerticalPadding),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                              'Location: '
                                                              //${patientAppointment.registerData.address}',
                                                              ,
                                                              style: infoWidget
                                                                  .subTitle.copyWith(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border:
                                                Border.all(color: Colors.blue)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text('prescription one',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('04-07-2020',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    'Medicine: ',
                                                    presetFontSizes: [16, 14],
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              SizedBox(
                                                height: 200,
                                                child: ListView.builder(
                                                    itemBuilder:
                                                        (context, index) => Row(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.blue,
                                                                            borderRadius: BorderRadius.all(Radius.circular(15))),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 12.0,
                                                                              vertical: 9.0),
                                                                          child:
                                                                              Text(
                                                                            '${index + 1}',
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.70,
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              'Name:',
                                                                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      ' Name  Name  Name  Name  Name  Name  Name  Name ',
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 6,
                                                                                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 8.0),
                                                                              child: Text(
                                                                                'Dosage:',
                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      ' Dosage  Dosage  Dosage  Dosage  Dosage ',
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 6,
                                                                                      style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 14),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ]))
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
//                      Padding(
//                    padding: const EdgeInsets.only(top: 8.0),
//                    child: Column(
//                      children: <Widget>[
//                        InkWell(
//                          onTap: () {
//                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserProfile()));
//                          },
//                          child: Padding(
//                            padding:
//                            const EdgeInsets.symmetric(vertical: 8.0),
//                            child: Container(
//                              decoration: BoxDecoration(
//                                  border: Border.all(color: Colors.blue),
//                                  borderRadius: BorderRadius.all(
//                                      Radius.circular(10))),
//                              child: Padding(
//                                padding: const EdgeInsets.all(6.0),
//                                child: Column(
//                                  children: <Widget>[
//                                    Row(
//                                      crossAxisAlignment:
//                                      CrossAxisAlignment.center,
//                                      children: <Widget>[
//                                        Column(
//                                          children: <Widget>[
//                                            SizedBox(
//                                              width: 60,
//                                              height: 60,
//                                              child: CircleAvatar(
//                                                backgroundColor: Colors.white,
//                                                backgroundImage: AssetImage(
//                                                    'assets/user.png'),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                        Padding(
//                                          padding: const EdgeInsets.only(
//                                              left: 8.0),
//                                          child: Column(
//                                            crossAxisAlignment:
//                                            CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              Text('Dr: Mahmoud Essam',
//                                                  style: TextStyle(
//                                                      color: Colors.blue,
//                                                      fontSize: 18,
//                                                      fontWeight:
//                                                      FontWeight.bold)),
//                                              SizedBox(
//                                                height: 3,
//                                              ),
//                                              Text('Date: 04-07-2020',
//                                                  style: TextStyle(
//                                                      color: Colors.grey,
//                                                      fontSize: 16,
//                                                      fontWeight:
//                                                      FontWeight
//                                                          .bold)),
//                                              SizedBox(
//                                                height: 3,
//                                              ),
//                                              Row(
//                                                children: <Widget>[
//                                                  Icon(
//                                                    Icons.location_on,
//                                                    color: Colors.grey,
//                                                    size: 20,
//                                                  ),
//                                                  Text('texas,united states',
//                                                      style: TextStyle(
//                                                          color: Colors.grey,
//                                                          fontSize: 16,
//                                                          fontWeight:
//                                                          FontWeight
//                                                              .bold)),
//
//                                                ],
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//
//                                      ],
//                                    ),
//                                    SizedBox(
//                                      height: 3,
//                                    ),
//                                    RaisedButton(
//                                      onPressed: () {
//                                        Navigator.of(context).push(
//                                            MaterialPageRoute(
//                                                builder:
//                                                    (context) =>
//                                                    ShowPreviousPatientPrecription(diagnose: _userProblemslist[index],)));
//                                      },
//                                      color: Colors.blue,
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                          BorderRadius.all(
//                                              Radius
//                                                  .circular(
//                                                  10))),
//                                      child: Text(
//                                        'Show Prescriptions',
//                                        style: TextStyle(
//                                            color:
//                                            Colors.white,
//                                            fontSize: 18,
//                                            fontWeight: FontWeight.bold
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
                    itemCount: allDrugList[0].allDoctorsInEachDosage.length,
                  ))
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, infoWidget) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Drugs',
              style: infoWidget.titleButton,
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
                          size: infoWidget.orientation == Orientation.portrait
                              ? infoWidget.screenHeight * 0.045
                              : infoWidget.screenHeight * 0.08,
                        ),
                        Positioned(
                            right: 2.9,
                            top: 2.8,
                            child: Container(
                              width:
                                  infoWidget.orientation == Orientation.portrait
                                      ? infoWidget.screenWidth * 0.025
                                      : infoWidget.screenWidth * 0.017,
                              height:
                                  infoWidget.orientation == Orientation.portrait
                                      ? infoWidget.screenWidth * 0.025
                                      : infoWidget.screenWidth * 0.017,
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
                      MediaQuery.of(context).orientation == Orientation.portrait
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
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(
                height: infoWidget.defaultVerticalPadding,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: infoWidget.defaultHorizontalPadding,
                    vertical: infoWidget.defaultVerticalPadding),
                child:
                    _userProblems(problemName: 'dbfcn', infoWidget: infoWidget),
              ),
            ],
          ),
        );
      },
    );
  }
}
