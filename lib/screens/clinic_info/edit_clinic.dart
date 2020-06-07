import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthbook/list_of_infomation/list_of_information.dart';
import 'package:healthbook/screens/specific_search/map.dart';

class EditClinic extends StatefulWidget {
  @override
  _EditClinicState createState() => _EditClinicState();
}

class _EditClinicState extends State<EditClinic> {
  Map<String, dynamic> _clinicData = {
    'Clinic Name': '',
    'cliniclocation': '',
    'cliniclat': '',
    'cliniclong': '',
    'watingTime': '',
    'fees': '',
    'workingDays': []
  };
  final FocusNode _hourNode = FocusNode();
  final FocusNode _minNode = FocusNode();
  final FocusNode _clinicLocationNode = FocusNode();
  final FocusNode _fees = FocusNode();
  bool _isClinicLocationEnable = false;
  bool _showWorkingDays = false;
  List<String> _selectedWorkingDays = List<String>();
  List<bool> _clicked = List<bool>.generate(7, (i) => false);
  List<String> _sortedWorkingDays = List<String>.generate(7, (i) => '');
  String _watingTimeHour = '';
  String _wattingTimeMin = '';
  TextEditingController _clinicLocationTextEditingController =
      TextEditingController();

  void selectLocationFromTheMap(String address, double lat, double long) {
    setState(() {
      _clinicLocationTextEditingController.text = address;
    });
    _clinicData['cliniclocation'] = address;
    _clinicData['cliniclat'] = lat.toString();
    _clinicData['cliniclong'] = long.toString();
  }

  void _getClinicLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    _clinicData['cliniclat'] = position.latitude.toString();
    _clinicData['cliniclong'] = position.longitude.toString();
    _clinicData['cliniclocation'] = addresses.first.addressLine;
    setState(() {
      _clinicLocationTextEditingController.text = _clinicData['cliniclocation'];
      _isClinicLocationEnable = true;
    });
    Navigator.of(context).pop();
  }

  void _selectClinicLocationType() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Text(
          'Clinic Location',
          textAlign: TextAlign.center,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _getClinicLocation();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        type: MaterialType.card,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Current Clinic Location',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => GetUserLocation(
                            getAddress: selectLocationFromTheMap)));
                  },
                  child: Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Get Location from Map',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
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
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _sort() {
      for (int i = 0; i < _selectedWorkingDays.length; i++) {
        int getIndex = workingDays.indexOf(_selectedWorkingDays[i]);
        if (!_sortedWorkingDays.contains(_selectedWorkingDays[i])) {
          _sortedWorkingDays.insert(getIndex, _selectedWorkingDays[i]);
        }
      }
    }

    getDays(int index) {
      setState(() {
        _clicked[index] = !_clicked[index];
      });
      if (_clicked[index] == true) {
        _selectedWorkingDays.add(workingDays[index]);
      } else {
        _selectedWorkingDays.remove(workingDays[index]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Clinic Info',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        actions: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(onPressed: (){},
            color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text('Save',style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                height: 60,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Clinic Name',
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
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
              ),
              InkWell(
                  onTap: _selectClinicLocationType,
                  child: Container(
                    padding: EdgeInsets.only(top: 7.0),
                    height: 70,
                    child: TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _clinicLocationTextEditingController,
                      textInputAction: TextInputAction.done,
                      enabled: _isClinicLocationEnable,
                      onFieldSubmitted: (_) {
                        _clinicLocationNode.unfocus();
                        FocusScope.of(context).requestFocus(_hourNode);
                      },
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: _selectClinicLocationType,
                          child: Icon(
                            Icons.my_location,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                        labelText: 'Clinic Location',
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
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Reservation in all days start: ',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    ' From : ',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  TimePickerSpinner(
                    is24HourMode: false,
                    normalTextStyle:
                        TextStyle(fontSize: 18, color: Colors.deepOrange),
                    highlightedTextStyle:
                        TextStyle(fontSize: 18, color: Colors.blue),
                    spacing: 30,
                    itemHeight: 40,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        // _dateTime = time;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    ' To:      ',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  TimePickerSpinner(
                    is24HourMode: false,
                    normalTextStyle:
                        TextStyle(fontSize: 18, color: Colors.deepOrange),
                    highlightedTextStyle:
                        TextStyle(fontSize: 18, color: Colors.blue),
                    spacing: 30,
                    itemHeight: 40,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        // _dateTime = time;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Wating Time for each Patient: ',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      focusNode: _hourNode,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        errorStyle: TextStyle(color: Colors.blue),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      onChanged: (val) {
                        _watingTimeHour = val;
                        if (val.length == 1) {
                          _hourNode.unfocus();
                          FocusScope.of(context).requestFocus(_minNode);
                        }
                      },
                      onFieldSubmitted: (value) {
                        _hourNode.unfocus();
                        FocusScope.of(context).requestFocus(_minNode);
                      },
                    ),
                  ),
                  Text(
                    ' Hour : ',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      focusNode: _minNode,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        errorStyle: TextStyle(color: Colors.blue),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      onChanged: (val) {
                        _wattingTimeMin = val;
                        if (val.length == 2) {
                          _minNode.unfocus();
                          FocusScope.of(context).requestFocus(_fees);
                        }
                      },
                      onFieldSubmitted: (value) {
                        _minNode.unfocus();
                        FocusScope.of(context).requestFocus(_fees);
                      },
                    ),
                  ),
                  Text(
                    ' Minute ',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(

                  children: <Widget>[
                    Text(
                      'Fees: ',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    SizedBox(
                      width: 73,
                    ),
                    Container(
                      height: 50,
                      width: 75,
                      child: TextFormField(
                        focusNode: _fees,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorStyle: TextStyle(color: Colors.blue),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        onChanged: (val) {
                          _clinicData['fees'] = val;
                        },
                        onFieldSubmitted: (value) {
                          _minNode.unfocus();
                        },
                      ),
                    ),
                    Text(
                      '  EGP ',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Material(
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
                            _showWorkingDays = !_showWorkingDays;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(),
                              Text("Working Days",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                _showWorkingDays
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 25,
                              ),
                            ],
                          ),
                        )),
                    _showWorkingDays
                        ? Divider(
                            color: Colors.grey,
                            height: 4,
                          )
                        : SizedBox(),
                    _showWorkingDays
                        ? Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 15, right: 15, top: 6.0),
                            child: Container(
                              height: 325,
                              //width: double.infinity,
                              child: GridView.builder(
                                  itemCount: workingDays.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2.5,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (ctx, index) => InkWell(
                                        onTap: () {
                                          getDays(index);
                                          print(_selectedWorkingDays);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: _clicked[index]
                                                  ? Colors.grey
                                                  : Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              workingDays[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      )),
                            ))
                        : SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
