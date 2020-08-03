import 'dart:io';

import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:healthbook/core/models/device_info.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/screens/patient_prescription/previous_prescription.dart';

import 'ShowImage.dart';
import 'add_radiology_and_analysis.dart';
class RadiologyAndAnalysisResult {
  String name;
  String description;
  File imgUrl;

  RadiologyAndAnalysisResult({this.name, this.description, this.imgUrl});
}

class PatientPrescription extends StatefulWidget {
  static const routeName = '/PatientPrescription';
  final DoctorAppointment doctorAppointment;

  PatientPrescription({this.doctorAppointment});

  @override
  _PatientPrescriptionState createState() => _PatientPrescriptionState();
}
class _PatientPrescriptionState extends State<PatientPrescription>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _showRadiology = false;
  bool _showAnalysis = false;
  bool _isProblemSelected = false;
  List<RadiologyAndAnalysisResult> _radiologyList = [];
  List<RadiologyAndAnalysisResult> _analysisList = [];
  String _name = '';
  String _description = '';
  File _imageFile;
  AgeDuration birthDate;
  String _diagnose = '';
  String _selectedProblem = ' Selected Diagnose ';
  List<String> _listOfProblems = ['A', 'B', 'C', 'D', 'Add Diagnose'];
  int _counterImgRadiology = 0;
  int _activeTabIndex = 0;
  List<Widget> _allMedicine = List<Widget>();
  List<String> _listMedicineName = List<String>();
  List<String> _listMedicineDosage = List<String>();
  static final _formKey = new GlobalKey<FormState>();
  static final _addProblemFormKey = new GlobalKey<FormState>();
  static final _addRadiologyFormKey = new GlobalKey<FormState>();
  static final _addAnalysisFormKey = new GlobalKey<FormState>();
  List<String> mybirth=[];
  DateTime today;
  _addMedicine() {
    Padding _medicineContainer = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  prefixIcon: Icon(
                    Icons.note,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: 'Medicine Name',
                ),
                // ignore: missing_return
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Please enter medicine';
                  }
                },
                onSaved: (String val) {
                  _listMedicineName.add(val);
                },
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        prefixIcon: Icon(
                          Icons.note,
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: 'Medicine Dosage',
                      ),
                      // ignore: missing_return
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Please enter dosage';
                        }
                      },
                      onSaved: (val) {
                        _listMedicineDosage.add(val);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (_allMedicine.length != 0) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _allMedicine.add(_medicineContainer);
        });
      }
    } else {
      setState(() {
        _allMedicine.add(_medicineContainer);
      });
    }
  }

  void _setActiveTabIndex() {
    setState(() {
      _activeTabIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this,);
    _tabController.addListener(_setActiveTabIndex);
    today= DateTime.now();
    mybirth=widget.doctorAppointment.registerData.birthDate.split('/');
    print(mybirth);
    DateTime birthday = DateTime(mybirth.length!=3?2020:int.parse(mybirth[2]),mybirth.length!=3?1:int.parse(mybirth[1]),mybirth.length!=3?1: int.parse(mybirth[0]));
    birthDate = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
    super.initState();
  }

  _radiologyData(String name, String description, File url) {
    print(name);
    print(description);
    print(url);
    setState(() {
      _name = name;
      _description = description;
      _imageFile = url;
    });
  }

  _analysisData(String name, String description, File url) {
    print(name);
    print(description);
    print(url);
    setState(() {
      _name = name;
      _description = description;
      _imageFile = url;
    });
  }

  _addRadiologyAndAnalysisResult({String type,TextStyle textStyle}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Text(
          'Add $type',
          style: textStyle.copyWith(color: Colors.blue),
          textAlign: TextAlign.center,
        ),
        content: AddRadiologyAndAnalysis(
          type: type,
          function: type == 'Radiology' ? _radiologyData : _analysisData,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              setState(() {
                if (type == 'Radiology') {
                  _radiologyList.add(RadiologyAndAnalysisResult(
                      name: _name,
                      description: _description,
                      imgUrl: _imageFile));
                } else {
                  _analysisList.add(RadiologyAndAnalysisResult(
                      name: _name,
                      description: _description,
                      imgUrl: _imageFile));
                }
              });
              Navigator.of(ctx).pop();
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Widget _radiologyAndAnalysisContent({String type, int index}) {
    String uniqueKey = '$type _ $index';
    RadiologyAndAnalysisResult item =
        type == 'Radiology' ? _radiologyList[index] : _analysisList[index];
    return SizedBox(
      child: Dismissible(
          background: Container(
            color: Colors.red,
            child: Center(
                child: Icon(
              Icons.delete,
              size: 35,
            )),
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Center(
                child: Icon(
              Icons.delete,
              size: 35,
            )),
            alignment: Alignment.centerLeft,
          ),
          key: ObjectKey(uniqueKey),
          onDismissed: (DismissDirection direction) {
            setState(() {
              type == 'Radiology'
                  ? _radiologyList.removeAt(index)
                  : _analysisList.removeAt(index);
            });
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                  "${type == 'Radiology' ? 'Radiology ' : 'Analysis '}${index + 1} is dismissed"),
              action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    setState(() {
                      type == 'Radiology'
                          ? _radiologyList.insert(index, item)
                          : _analysisList.insert(index, item);
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${type == 'Radiology' ? 'Radiology ' : 'Analysis '}${index + 1} is Added"),
                      duration: Duration(seconds: 1),
                    ));
                  }),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: Container(
                //height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: <Widget>[
                    type == 'Radiology'
                        ? _radiologyList[index].imgUrl == null
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ShowImage(
                                            imageURL: type == 'Radiology'
                                                ? _radiologyList[index].imgUrl
                                                : _analysisList[index].imgUrl,
                                          )));
                                },
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      border: Border.all(color: Colors.blue),
                                      image: DecorationImage(
                                          image: FileImage(
                                            type == 'Radiology'
                                                ? _radiologyList[index].imgUrl
                                                : _analysisList[index].imgUrl,
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              )
                        : _analysisList[index].imgUrl == null
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ShowImage(
                                            imageURL: type == 'Radiology'
                                                ? _radiologyList[index].imgUrl
                                                : _analysisList[index].imgUrl,
                                          )));
                                },
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      border: Border.all(color: Colors.blue),
                                      image: DecorationImage(
                                          image: FileImage(
                                            type == 'Radiology'
                                                ? _radiologyList[index].imgUrl
                                                : _analysisList[index].imgUrl,
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                    _radiologyList[index].name==null?SizedBox():Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '$type Name:',
                              style: TextStyle(fontSize: 16),
                            ),
                            AutoSizeText(
                              type == 'Radiology'
                                  ? _radiologyList[index].name
                                  : _analysisList[index].name,
                              presetFontSizes: [16, 14, 12],
                            ),
                          ],
                        ),
                      ),
                    ),
                    _radiologyList[index].description ==null?SizedBox():Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Description of $type: ',
                              style: TextStyle(fontSize: 16),
                            ),
                            AutoSizeText(
                              type == 'Radiology'
                                  ? _radiologyList[index].description
                                  : _analysisList[index].description,
                              presetFontSizes: [16, 14, 12],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context,infoWidget){
        return Scaffold(
          appBar: AppBar(
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
                }),
            actions: <Widget>[
              _activeTabIndex == 0
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {},
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: Text(
                    'Save',
                    style: infoWidget.subTitle.copyWith(color: Colors.blue),
                  ),
                ),
              )
                  : SizedBox(
                width: 0.1,
              )
            ],
            bottom: TabBar(
              unselectedLabelColor:  Color(0xff484848),
              labelColor: Colors.white,
              labelStyle: infoWidget.subTitle,
              tabs: [
                new Tab(
                  text: 'NEW PRESCRIPTION',
                ),
                new Tab(
                  text: 'PREVIOUS PRESCRIPTION',
                ),
              ],
              controller: _tabController,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            bottomOpacity: 1,
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
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
                                  image: '${widget.doctorAppointment.registerData.patientImage}',
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
                                        '${widget.doctorAppointment.registerData.firstName} ${widget.doctorAppointment.registerData.lastName}'
                                        ,maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: infoWidget.title),
                                  ),
                                  Text(
                                    '${today.year}-${today.month}-${today.day}',
                                    style:
                                    infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],)
                              ,
                              mybirth.length!=3?SizedBox():Padding(
                                padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('Age: ${birthDate.years} years',
                                          style: infoWidget.subTitle),
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
                                        'Prescription: one',
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
                                        'Appointement at ${widget.doctorAppointment.appointStart} PM',
                                        style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Diagnose:',
                            style: infoWidget.titleButton.copyWith( color: Colors.blue,)),
                        Material(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          type: MaterialType.card,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ConstrainedBox(
                               constraints: BoxConstraints(
                                 maxWidth: infoWidget.screenWidth*0.60,
                                 minWidth: infoWidget.screenWidth*0.05
                               )
                                ,child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,bottom: 5,top: 5,right: 5),
                                    child: Text(_selectedProblem,
                                        maxLines: 4,
                                        style: infoWidget.subTitle.copyWith(color: Colors.white))),
                              ),
                              Container(
                                height: infoWidget.screenWidth*0.1,
                                width: infoWidget.screenWidth*0.11,
                                child: PopupMenuButton(
                                  tooltip: 'Select Diagnose',
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  itemBuilder: (ctx) => _listOfProblems
                                      .map((String val) => PopupMenuItem<String>(
                                    value: val,
                                    child: Center(child: Text(val.toString())),
                                  ))
                                      .toList(),
                                  onSelected: (val) async {
                                    if (val == 'Add Diagnose') {
                                      await showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0))),
                                          contentPadding:
                                          EdgeInsets.only(top: 10.0),
                                          title: Text(
                                            'Add Diagnose',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Form(
                                            key: _addProblemFormKey,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.all(8.0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  focusedBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10.0)),
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  disabledBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10.0)),
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                  hintStyle:
                                                  TextStyle(fontSize: 14),
                                                  hintText: 'Diagnose',
                                                ),
                                                // ignore: missing_return
                                                validator: (String val) {
                                                  if (val.isEmpty) {
                                                    return 'Please enter Problem';
                                                  }
                                                },
                                                onSaved: (String val) {
                                                  setState(() {
                                                    _isProblemSelected = true;
                                                    _selectedProblem = val;
                                                    _listOfProblems.insert(
                                                        _listOfProblems.length -
                                                            1,
                                                        val);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                if (_addProblemFormKey
                                                    .currentState
                                                    .validate()) {
                                                  _addProblemFormKey.currentState
                                                      .save();
                                                  Navigator.of(ctx).pop();
                                                }
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        _selectedProblem = val;
                                        _isProblemSelected = true;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.065:infoWidget.screenWidth*0.049,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Diagnose description: ',
                          style: infoWidget.titleButton.copyWith( color: Colors.blue,)),
                          Expanded(
                            //width: 80,
                            child: TextFormField(
                              autofocus: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              maxLines: 3,
                              onChanged: (val) {
                                _diagnose = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Medicine:',
                            style: infoWidget.titleButton.copyWith( color: Colors.blue,)),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: _addMedicine,
                          color: Colors.blue,
                          child: Text('Add Medicine',
                              style: infoWidget.subTitle.copyWith(color: Colors.white))),
                      ],
                    ),
                    _allMedicine.length == 0
                        ? SizedBox()
                        : Form(
                          key: _formKey,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final Widget item = _allMedicine[index];
                              return Dismissible(
                                  background: Container(
                                    color: Colors.blue,
                                    child: Center(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.065:infoWidget.screenWidth*0.049,
                                        )),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.blue,
                                    child: Center(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.065:infoWidget.screenWidth*0.049,
                                        )),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  key: ObjectKey(item),
                                  //UniqueKey(),
                                  onDismissed: (DismissDirection direction) {
                                    if (_allMedicine.contains(item)) {
                                      setState(() {
                                        _allMedicine.removeAt(index);
                                      });
                                    }
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          "medicine ${index + 1} is dismissed"),
                                      action: SnackBarAction(
                                          label: 'UNDO',
                                          onPressed: () {
                                            if (!_allMedicine.contains(item)) {
                                              setState(() {
                                                _allMedicine.insert(
                                                    index, item);
                                              });
                                            }
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "medicine ${index + 1} is Added"),
                                              duration: Duration(seconds: 1),
                                            ));
                                          }),
                                    ));
                                  },
                                  child: _allMedicine[index]);
                            },
                            itemCount: _allMedicine.length,
                          ),
                        ),
                    Padding(
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
                                    _showRadiology = !_showRadiology;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(),
                                      Text("Radiology Result",
                                          style: infoWidget.titleButton.copyWith( color: Colors.blue,)),
                                      Icon(
                                        _showRadiology
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.065:infoWidget.screenWidth*0.049,
                                      ),
                                    ],
                                  ),
                                )),
                            _showRadiology
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Divider(
                                color: Colors.grey,
                                height: 4,
                              ),
                            )
                                : SizedBox(),
                            _showRadiology
                                ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 15, right: 15, top: 6.0),
                              child: Column(
                                children: <Widget>[
                                  _radiologyList.length == 0
                                      ? SizedBox()
                                      : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        _radiologyAndAnalysisContent(
                                            type: 'Radiology',
                                            index: index),
                                    itemCount:
                                    _radiologyList.length,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 8.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        _addRadiologyAndAnalysisResult(
                                            type: 'Radiology',textStyle: infoWidget.titleButton);
                                      },
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Text(
                                        'Add Radiology',
                                          style: infoWidget.subTitle.copyWith(color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
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
                                    _showAnalysis = !_showAnalysis;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(),
                                      Text("Analysis Result",
                                          style: infoWidget.titleButton.copyWith( color: Colors.blue,)),
                                      Icon(
                                        _showAnalysis
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.065:infoWidget.screenWidth*0.049,
                                      ),
                                    ],
                                  ),
                                )),
                            _showAnalysis
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Divider(
                                color: Colors.grey,
                                height: 4,
                              ),
                            )
                                : SizedBox(),
                            _showAnalysis
                                ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 15, right: 15, top: 6.0),
                              child: Column(
                                children: <Widget>[
                                  _analysisList.length == 0
                                      ? SizedBox()
                                      : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        _radiologyAndAnalysisContent(
                                            type: 'Analysis',
                                            index: index),
                                    itemCount: _analysisList.length,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 8.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        _addRadiologyAndAnalysisResult(
                                            type: 'Analysis',textStyle: infoWidget.titleButton);
                                      },
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Text(
                                        'Add Analysis',
                                        style: infoWidget.subTitle.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PreviousPrescription()
            ],
          ),
        );
      },
    );
  }
}
