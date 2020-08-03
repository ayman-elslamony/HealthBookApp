import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/register_user_data.dart';
import 'showDrugs.dart';

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
  bool _showPrescription = false;

  set showPrescriptionSet(bool value) {
    _showPrescription = value;
  }

  bool get showPrescriptionGet => _showPrescription;
  List<Medicine> allMedicine = [];
  List<RadiologyAndAnalysisStructure> allRadiology = [];
  List<RadiologyAndAnalysisStructure> allAnalysis = [];
  Prescription(
      {this.prescriptionName, this.prescriptionDate, this.allMedicine,this.allRadiology,this.allAnalysis});
}

class Medicine {
  String medicineName;
  String medicineDosage;

  Medicine({this.medicineName, this.medicineDosage});
}
class RadiologyAndAnalysisStructure{
  String name;
  String description;
  String image;
  RadiologyAndAnalysisStructure({this.name, this.description, this.image});
}
class DrugList {
  bool _showDiagnose = false;

  set showDiagnoseSet(bool value) {
    _showDiagnose = value;
  }

  bool get showDiagnoseGet => _showDiagnose;

  String diagnoseName;
  String diagnoseDate;
  List<DoctorsInEachDosage> allDoctorsInEachDosage = [];

  DrugList({this.diagnoseName, this.diagnoseDate, this.allDoctorsInEachDosage});
}

class DrugAndRadiologyAndAnalysis extends StatefulWidget {
  final bool isDrugs;
  DrugAndRadiologyAndAnalysis({this.isDrugs=true});
  @override
  _DrugAndRadiologyAndAnalysisState createState() => _DrugAndRadiologyAndAnalysisState();
}

class _DrugAndRadiologyAndAnalysisState extends State<DrugAndRadiologyAndAnalysis> {
  List<DrugList> allDrugList = [
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
                      image: 'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'
                    ),
                    RadiologyAndAnalysisStructure(
                      name: 'ggg',
                      description: 'fgdtet dgtt',
                      image: 'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'
                    ),
                  ],
                  allRadiology: [
                    RadiologyAndAnalysisStructure(
                        name: 'drttrn',
                        description: 'feazg ett',
                        image: 'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'
                    ),
                    RadiologyAndAnalysisStructure(
                        name: 'giuoig',
                        description: 'fgqqet dgtt',
                        image: 'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'
                    ),
                  ]
                ),
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
              ]
          ),
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
                          medicineName: 'zeta',
                          medicineDosage: 'each 2 hour'),
                      Medicine(
                          medicineName: 'beta',
                          medicineDosage: 'each 1 hour'),
                    ]),
                Prescription(
                    prescriptionDate: '8-1-2020',
                    prescriptionName: 'Prescription one',
                    allMedicine: [
                      Medicine(
                          medicineName: 'zeta',
                          medicineDosage: 'each 2 hour'),
                      Medicine(
                          medicineName: 'beta',
                          medicineDosage: 'each 1 hour'),
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

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, infoWidget) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                widget.isDrugs?'Drugs':'Radiology And Analysis',
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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(itemBuilder: (context, index) =>
                  RaisedButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowAllDoctorsInDiagnose(
                      allDrugList: allDrugList,
                       diagnoseName: allDrugList[index].diagnoseName,isShowMedicine: widget.isDrugs,
                      indexForDrugList: index,
                    )));
                  },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:  EdgeInsets.all(8),
                      child: Text(allDrugList[index].diagnoseName, style: infoWidget.titleButton,),
                    ),),itemCount: allDrugList.length,),
            )
        );
      },
    );
  }
}
