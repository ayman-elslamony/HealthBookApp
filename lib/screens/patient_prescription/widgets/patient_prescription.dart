import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:healthbook/screens/patient_prescription/previous_prescription.dart';

import 'ShowImage.dart';
import 'add_radiology_and_analysis.dart';

class PatientPrescription extends StatefulWidget {
  static const routeName = '/PatientPrescription';

  @override
  _PatientPrescriptionState createState() => _PatientPrescriptionState();
}

class RadiologyAndAnalysisResult {
  String name;
  String description;
  String imgUrl;

  RadiologyAndAnalysisResult({this.name, this.description, this.imgUrl});
}

class _PatientPrescriptionState extends State<PatientPrescription>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _isProblemSelected = false;
  bool _showRadiology = false;
  bool _showAnalysis = false;
  bool _showVitals = false;
  bool _showLavResult = false;


  Map<String, String> _vitalAndLabResultMap = {
    'BloodPressure': '',
    'PlusRate': '',
    'OxygenSaturation': '',
    'RespiratoryRate': '',
    'WBC': '',
    'HGB': '',
  };

  List<RadiologyAndAnalysisResult> _radiologyList = [];
  List<RadiologyAndAnalysisResult> _analysisList = [];
  String _name = '';
  String _description = '';
  String _URL =
      'https://lh3.googleusercontent.com/proxy/L_7HnbwuGpU3Nxvk46kVOh4xKclOc7J0HPJAkVhEueXH8Cl4IHBNczC2gLungfWnIYYom8RNnxidfaUp';

  String _diagnose = '';
  String _selectedProblem =
      ' Selected Problem ';
  List<String> _listOfProblems = ['A', 'B', 'C', 'D', 'Add Problem'];
  int _counterImgRadiology = 0;
  int _activeTabIndex=0;
  List<Widget> _allMedicine = List<Widget>();
  List<String> _listMedicineName = List<String>();
  List<String> _listMedicineDosage = List<String>();
  static final _formKey = new GlobalKey<FormState>();
  static final _addProblemFormKey = new GlobalKey<FormState>();
  static final _addRadiologyFormKey = new GlobalKey<FormState>();
  static final _addAnalysisFormKey = new GlobalKey<FormState>();

  _cardWithTextForm({String typeName, String measureType, String hintText}) {
    return Material(
        shadowColor: Colors.blueAccent,
        elevation: 8.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        type: MaterialType.card,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  typeName,
                  presetFontSizes: [18, 16, 14],
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 90,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
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
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      hintText: hintText,
                    ),
// ignore: missing_return
                    onChanged: (val) {
                      _vitalAndLabResultMap[typeName] = val;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  measureType,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ));
  }

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
                      textInputAction: TextInputAction.newline,
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
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_setActiveTabIndex);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _radiologyData(String name, String description, String url) {
      print(name);
      print(description);
      print(url);
      setState(() {
        _name = name;
        _description = description;
        _URL = url;
      });
    }

    _analysisData(String name, String description, String url) {
      print(name);
      print(description);
      print(url);
      setState(() {
        _name = name;
        _description = description;
        _URL = url;
      });
    }

    _addRadiologyAndAnalysisResult({String type}) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(
            'Add $type',
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
                        name: _name, description: _description, imgUrl: _URL));
                  } else {
                    _analysisList.add(RadiologyAndAnalysisResult(
                        name: _name, description: _description, imgUrl: _URL));
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
      return Dismissible(
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
            child: Container(
              //height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShowImage(
                                ImageURL: type == 'Radiology'
                                    ? _radiologyList[index].imgUrl
                                    : _analysisList[index].imgUrl,
                              )));
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          border: Border.all(color: Colors.blue),
                          image: DecorationImage(
                              image: NetworkImage(
                                type == 'Radiology'
                                    ? _radiologyList[index].imgUrl
                                    : _analysisList[index].imgUrl,
                              ),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Padding(
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
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, right: 8.0, left: 8.0),
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
          ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        actions: <Widget>[
          _activeTabIndex == 0? Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.blue,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ):SizedBox(width: 0.1,)
        ],
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          labelColor: Colors.red,
          tabs: [
            new Tab(
              text: 'New PRESCRIPTION',
            ),
            new Tab(
              text: 'Previous PRESCRIPTION',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/user.png'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Mahmoud Essam',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('30 years old',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('texas,united states',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 17,
                        ),
                        Text('prescription one',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text('04-07-2020',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),

//              Container(
//                  color: Colors.black54,
//                  width: MediaQuery.of(context).size.width,
//                  //  height: MediaQuery.of(context).size.height*0.16,
//                  child: Padding(
//                    padding: const EdgeInsets.only(
//                        left: 20, right: 20, top: 15, bottom: 15),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.only(left: 8.0),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text('Dr: Mahmoud Essam',
//                                  style: TextStyle(
//                                      color: Colors.white,
//                                      fontSize: 18,
//                                      fontWeight: FontWeight.bold)),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 8.0),
//                                child: Text('Surgeon',
//                                    style: TextStyle(
//                                        color: Colors.white70,
//                                        fontSize: 17,
//                                        fontWeight: FontWeight.bold)),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 8.0),
//                                child: Text('Clinic Name',
//                                    style: TextStyle(
//                                        color: Colors.white70,
//                                        fontSize: 17,
//                                        fontWeight: FontWeight.bold)),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 8.0),
//                                child: Text('texas,united states',
//                                    style: TextStyle(
//                                        color: Colors.white70,
//                                        fontSize: 17,
//                                        fontWeight: FontWeight.bold)),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            SizedBox(
//                              width: 75,
//                              height: 75,
//                              child: CircleAvatar(
//                                backgroundColor: Colors.white,
//                                backgroundImage: AssetImage('assets/user.png'),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  )),
              SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Diagnose:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Material(
                      color: Colors.blue,
//                  shadowColor: Colors.blueAccent,
//                  elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: AutoSizeText(_selectedProblem,
                                   presetFontSizes: [16,14,12],
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white))),
                            Container(
                              height: 40,
                              width: 35,
                              child: PopupMenuButton(
                                tooltip: 'Select Problem',
                                itemBuilder: (ctx) => _listOfProblems
                                    .map((String val) => PopupMenuItem<String>(
                                          value: val,
                                          child: Text(val.toString()),
                                        ))
                                    .toList(),
                                onSelected: (val) async {
                                  if (val == 'Add Problem') {
                                    await showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.0))),
                                        contentPadding:
                                            EdgeInsets.only(top: 10.0),
                                        title: Text(
                                          'Add Problem',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Form(
                                          key: _addProblemFormKey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
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
                                                hintText: 'Problem',
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
                                ),
                              ),
                            ),
                          ],
                        ),
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
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      Expanded(
                        //width: 80,
                        child: TextFormField(
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
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: _addMedicine,
                      color: Colors.blue,
                      child: Text('Add Medicine',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                _allMedicine.length == 0
                    ? SizedBox()
                    : SizedBox(
                        height: 135.0 * _allMedicine.length,
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          key: _formKey,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final Widget item = _allMedicine[index];
                              return Dismissible(
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
                        )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Color(0xfffafbff),
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
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
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Icon(
                                    _showRadiology
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 25,
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
                                    SizedBox(
                                        height: 170.0 * _radiologyList.length,
                                        child: _radiologyList.length == 0
                                            ? SizedBox()
                                            : ListView.builder(
                                                itemBuilder: (context, index) =>
                                                    _radiologyAndAnalysisContent(
                                                        type: 'Radiology',
                                                        index: index),
                                                itemCount:
                                                    _radiologyList.length,
                                              )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: RaisedButton(
                                        onPressed: () {
                                          _addRadiologyAndAnalysisResult(
                                              type: 'Radiology');
                                        },
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'Add Radiology',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
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
                    elevation: 8.0,
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
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Icon(
                                    _showAnalysis
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 25,
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
                                    SizedBox(
                                        height: 170.0 * _analysisList.length,
                                        child: _analysisList.length == 0
                                            ? SizedBox()
                                            : ListView.builder(
                                                itemBuilder: (context, index) =>
                                                    _radiologyAndAnalysisContent(
                                                        type: 'Analysis',
                                                        index: index),
                                                itemCount: _analysisList.length,
                                              )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: RaisedButton(
                                        onPressed: () {
                                          _addRadiologyAndAnalysisResult(
                                              type: 'Analysis');
                                        },
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'Add Analysis',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
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
                    elevation: 8.0,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              setState(() {
                                _showVitals = !_showVitals;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(),
                                  Text("Vitals Result",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Icon(
                                    _showVitals
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 25,
                                  ),
                                ],
                              ),
                            )),
                        _showVitals
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 4,
                                ),
                              )
                            : SizedBox(),
                        _showVitals
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, left: 15, right: 15, top: 6.0),
                                child: Container(
                                    height: 280,
                                    //width: double.infinity,
                                    child: GridView(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 8,
                                              childAspectRatio: 1.4,
                                              crossAxisSpacing: 8),
                                      children: <Widget>[
                                        _cardWithTextForm(
                                            typeName: 'BloodPressure',
                                            measureType: 'mmHg',
                                            hintText: '120/56'),
                                        _cardWithTextForm(
                                            typeName: 'PlusRate',
                                            measureType: 'bpm',
                                            hintText: '55'),
                                        _cardWithTextForm(
                                            typeName: 'OxygenSaturation',
                                            measureType: '%',
                                            hintText: '80'),
                                        _cardWithTextForm(
                                            typeName: 'RespiratoryRate',
                                            measureType: 'br/min',
                                            hintText: '60'),
                                      ],
                                    )))
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
                  child: Material(
                    color: Color(0xfffafbff),
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              setState(() {
                                _showLavResult = !_showLavResult;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(),
                                  Text("Lab Result",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Icon(
                                    _showLavResult
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 25,
                                  ),
                                ],
                              ),
                            )),
                        _showLavResult
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 4,
                                ),
                              )
                            : SizedBox(),
                        _showLavResult
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, left: 15, right: 15, top: 6.0),
                                child: Container(
                                    height: 135,
                                    //width: double.infinity,
                                    child: GridView(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 8,
                                              childAspectRatio: 1.4,
                                              crossAxisSpacing: 8),
                                      children: <Widget>[
                                        _cardWithTextForm(
                                            typeName: 'WBC',
                                            measureType: 'K/mm3',
                                            hintText: '10.1'),
                                        _cardWithTextForm(
                                            typeName: 'HGB',
                                            measureType: 'Gm/dl',
                                            hintText: '11'),
                                      ],
                                    )))
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
  }
}
