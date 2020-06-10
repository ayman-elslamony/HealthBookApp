import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/specific_search/map.dart';
import 'package:provider/provider.dart';
import '../../list_of_infomation/list_of_information.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../main_screen.dart';

class RegisterUserData extends StatefulWidget {
  static const routeName = '/UserSignUp';
  bool isEditingEnable;

  RegisterUserData({this.isEditingEnable=false});

  @override
  _RegisterUserDataState createState() => _RegisterUserDataState();
}



class _RegisterUserDataState extends State<RegisterUserData> {
  GlobalKey<FormState> _newAcountKeyOne = GlobalKey<FormState>();
  GlobalKey<FormState> _newAcountKeyTwo = GlobalKey<FormState>();
  bool _showWorkingDays = false;
  bool _isLoading = false;
  List<String> _selectedWorkingDays = List<String>();
  List<bool> _clicked = List<bool>.generate(7, (i) => false);
  List<String> _sortedWorkingDays = List<String>.generate(7, (i) => '');
  int currentStep = 0;
  String _watingTimeHour = '';
  String _wattingTimeMin = '';
  bool complete = false;
  bool _isClinicLocationEnable = false;
  bool _isEditLocationEnable = false;
  bool _selectUserLocationFromMap = false;
  bool _isDoctor = false;
  bool _isClinic = false;
  bool _isMaterialStatus = false;
  bool _isDaySelected = false;
  bool _isMonthSelected = false;
  bool _isYearSelected = false;
  bool _isGenderSelected = false;
  bool _isSpecialtySelected = false;
  TextEditingController _locationTextEditingController =
      TextEditingController();
  TextEditingController _clinicLocationTextEditingController =
      TextEditingController();

  File _imageFile;
  List<int> _dayist = List.generate(31, (index) {
    return (5 + index);
  });
  List<int> _dayList = List.generate(31, (index) {
    return (1 + index);
  });
  List<int> _monthList = List.generate(12, (index) {
    return (1 + index);
  });
  List<int> _yearList = List.generate(80, (index) {
    return (index + 1960);
  });
  Map<String, dynamic> _clinicData = {
    'Clinic Name': '',
    'cliniclocation': '',
    'cliniclat': '',
    'cliniclong': '',
    'watingTime': '',
    'startTime':'',
    'endTime':'',
    'fees': '',
    'workingDays': []
  };
  Map<String, dynamic> _accountData = {
    'First name': '',
    'Middle name': '',
    'Last name': '',
    'National ID': '',
    'Phone number': '',
    'UrlImg': '',
    'Job': '',
    'gender': '',
    'day': '',
    'month': '',
    'year': '',
    'Location': '',
    'lat': '',
    'long': '',
    'materialStatus': '',
    'aboutYouOrBio': '',
    'speciatly': '',
  };
  final FocusNode _middleNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _nationalIDNode = FocusNode();
  final FocusNode _phoneNumberNode = FocusNode();
  Auth _auth ;
  final FocusNode _jobNode = FocusNode();
  final FocusNode _hourNode = FocusNode();
  final FocusNode _minNode = FocusNode();
  final FocusNode _clinicLocationNode = FocusNode();
  final FocusNode _fees = FocusNode();
  final ImagePicker _picker = ImagePicker();

  TextEditingController _firstTextEditingController =
  TextEditingController();
  TextEditingController _middleTextEditingController =
  TextEditingController();
  TextEditingController _lastTextEditingController =
  TextEditingController();
  TextEditingController _phoneTextEditingController =
  TextEditingController();
  TextEditingController _jobTextEditingController =
  TextEditingController();
  TextEditingController _aboutEditingController =
  TextEditingController();

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
  @override
  void initState() {
    super.initState();
    _auth =Provider.of<Auth>(context, listen: false);
  if(widget.isEditingEnable){
    _firstTextEditingController.text= _auth.userData.firstName;
    _middleTextEditingController.text= _auth.userData.middleName;
    _lastTextEditingController.text= _auth.userData.lastName;
    _phoneTextEditingController.text= _auth.userData.number;
    _jobTextEditingController.text= _auth.userData.job;
    _aboutEditingController.text= _auth.userData.aboutYou;
    _locationTextEditingController.text = _auth.userData.address;

    _isDaySelected=true;
    _isMonthSelected=true;
    _isYearSelected=true;
    _isGenderSelected=true;
    _isMaterialStatus=true;
    _accountData['materialStatus']= _auth.userData.status;
    _accountData['gender']= _auth.userData.gender;
    List<String> birth=_auth.userData.birthDate.split('/');
    _accountData['year']= birth[2];
    _accountData['month']= birth[1];
    _accountData['day']= birth[0];
    _imageFile =File(_auth.userData.patientImage);
    if(_auth.getUserType =='doctor'){
      _isSpecialtySelected=true;
      _accountData['speciatly']= _auth.userData.speciality;
    }
  }

  }


  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }
  Widget _createTextForm({
    String labelText,
    FocusNode currentFocusNode,
    FocusNode nextFocusNode,
    TextInputType textInputType = TextInputType.text,
    bool isSuffixIcon = false,
    Function validator,
    IconData suffixIcon,
    bool isStopped = false,
    bool isEnable = true,
    TextEditingController controller
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.0),
      height: 80,
      child: TextFormField(
        controller: controller,
        autofocus: false,
        textInputAction:
        isStopped ? TextInputAction.done : TextInputAction.next,
        focusNode: currentFocusNode == null ? null : currentFocusNode,
        enabled: isEnable,
        decoration: InputDecoration(
          suffixIcon: Icon(
            suffixIcon,
            size: 20,
            color: Colors.blue,
          ),
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
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
        ),
        keyboardType: textInputType,
// ignore: missing_return
        validator: validator,
        onSaved: (value) {
          labelText == 'Clinic Name'
              ? _clinicData['$labelText'] = value.trim()
              : _accountData['$labelText'] = value.trim();
          if (currentFocusNode != null) {
            currentFocusNode.unfocus();
          }
          if (isStopped == false) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
        onChanged: (value) {
          labelText == 'Clinic Name'
              ? _clinicData['$labelText'] = value.trim()
              : _accountData['$labelText'] = value.trim();
        },
        onFieldSubmitted: (_) {
          if (currentFocusNode != null) {
            currentFocusNode.unfocus();
          }
          if (isStopped == false) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
      ),
    );
  }
  Future<String> _getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates =
    new Coordinates(position.latitude, position.longitude);

    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    if (_isClinic) {
      _clinicData['cliniclat'] = position.latitude.toString();
      _clinicData['cliniclong'] = position.longitude.toString();
      _isClinic = false;
    } else {
      _accountData['lat'] = position.latitude.toString();
      _accountData['long'] = position.longitude.toString();
    }
    return addresses.first.addressLine;
  }
  void _getUserLocation() async {
    _accountData['Location'] = await _getLocation();
    setState(() {
      _locationTextEditingController.text = _accountData['Location'];
      _isEditLocationEnable = true;
      _selectUserLocationFromMap = !_selectUserLocationFromMap;
    });
    Navigator.of(context).pop();
  }

  void selectLocationFromTheMap(String address, double lat, double long) {
    if (_isClinic) {
      setState(() {
        _clinicLocationTextEditingController.text = address;
      });
      _clinicData['cliniclocation'] = address;
      _clinicData['cliniclat'] = lat.toString();
      _clinicData['cliniclong'] = long.toString();
      _isClinic = false;
    } else {
      setState(() {
        _locationTextEditingController.text = address;
      });
      _accountData['Location'] = address;
      _accountData['lat'] = lat.toString();
      _accountData['long'] = long.toString();
    }
  }

  void selectUserLocationType() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Text(
          'Location',
          textAlign: TextAlign.center,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: _getUserLocation,
                  child: Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Get current Location',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => GetUserLocation(
                          getAddress: selectLocationFromTheMap,
                        )));
                    setState(() {
                      _isEditLocationEnable = true;
                      _selectUserLocationFromMap =
                      !_selectUserLocationFromMap;
                    });
                  },
                  child: Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select Location from Map',
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

  void _getClinicLocation() async {
    setState(() {
      _isClinic = true;
    });
    _clinicData['cliniclocation'] = await _getLocation();
    setState(() {
      _clinicLocationTextEditingController.text =
      _clinicData['cliniclocation'];
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
                    setState(() {
                      _clinicData['cliniclocation'] =
                      _accountData['Location'];
                      _clinicData['cliniclat'] = _accountData['lat'];
                      _clinicData['cliniclong'] = _accountData['long'];
                      _clinicLocationTextEditingController.text =
                      _accountData['Location'];
                      _isClinicLocationEnable = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        type: MaterialType.card,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Same location',
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
                    setState(() {
                      _isClinic = true;
                    });
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

//    Future<void> uploadPic(BuildContext context) async {
////      StorageReference storageReference = FirebaseStorage.instance
////          .ref()
////          .child('profiles/${basename(_imageFile.path)}}');
////      StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
////      await uploadTask.onComplete;
////      storageReference.getDownloadURL().then((fileURL) {
////        _accountData['UrlImg'] = fileURL;
////      });
//    }

  Future<void> _getImage(ImageSource source) async {
    await _picker
        .getImage(source: source, maxWidth: 400.0)
        .then((PickedFile image) {
      if (image != null) {
        File x = File(image.path);
        _accountData['UrlImg'] = x;
        setState(() {
          _imageFile = x;
        });
      }
      Navigator.pop(context);
    });
  }

  void _openImagePicker() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Pick an Image',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    textColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Use Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _getImage(ImageSource.camera);
                      // Navigator.of(context).pop();
                    },
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    textColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Use Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _getImage(ImageSource.gallery);
                      // Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ]),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Widget _createBirthDate({String name, List<int> list, Function fun,int initialValue}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Material(
          shadowColor: Colors.blueAccent,
          elevation: 8.0,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          type: MaterialType.card,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 40,
                width: 35,
                child: PopupMenuButton(
                  initialValue: initialValue,
                  tooltip: 'Select Birth',
                  itemBuilder: (ctx) => list
                      .map((int val) => PopupMenuItem<int>(
                    value: val,
                    child: Text(val.toString()),
                  ))
                      .toList(),
                  onSelected: fun,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    List<Step> steps = _auth.getUserType =='doctor'
        ? [
      Step(
        title: const Text('New Account'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: _newAcountKeyOne,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _createTextForm(
                controller: _firstTextEditingController,
                  labelText: 'First name',
                  nextFocusNode: _middleNameNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter first name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                controller: _middleTextEditingController,
                  labelText: 'Middle name',
                  currentFocusNode: _middleNameNode,
                  nextFocusNode: _lastNameNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter middle name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                controller: _lastTextEditingController,
                  labelText: 'Last name',
                  currentFocusNode: _lastNameNode,
                  nextFocusNode: _nationalIDNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter last name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                  labelText: 'National ID',
                  currentFocusNode: _nationalIDNode,
                  textInputType: TextInputType.number,
                  nextFocusNode: _phoneNumberNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length != 14) {
                      return 'Please enter National ID';
                    }
                    if (val.trim().length != 14) {
                      return 'Invalid National ID';
                    }
                  }),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                height: 80,
                child: TextFormField(
                  controller: _phoneTextEditingController,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  focusNode: _phoneNumberNode,
                  decoration: InputDecoration(
                    prefix: Container(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "+20",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    labelText: "Phone number",
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
                  keyboardType: TextInputType.phone,
// ignore: missing_return
                  validator: (String value) {
                    if (value.trim().isEmpty || value.trim().length != 10) {
                      return "Please enter Phone number!";
                    }
                    if (value.trim().length != 10) {
                      return "Invalid Phone number!";
                    }
                  },
                  onSaved: (value) {
                    _accountData['Phone number'] = value.trim();
                    _phoneNumberNode.unfocus();
                  },
                  onFieldSubmitted: (_) {
                    _phoneNumberNode.unfocus();
                    FocusScope.of(context).requestFocus(_jobNode);
                  },
                ),
              ),
              _createTextForm(
                controller: _jobTextEditingController,
                  labelText: 'Job',
                  currentFocusNode: _jobNode,
                  // ignore: missing_return
                  validator: (_) {},
                  isStopped: true),
            ],
          ),
        ),
      ),
      Step(
        isActive: true,
        state: StepState.indexed,
        title: const Text('complete Your Data'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Birth Date:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _createBirthDate(
                  initialValue: 10,
                  name: _isDaySelected ? _accountData['day'] : 'Day',
                  list: _dayList,
                  fun: (int val) {
                    setState(() {
                      _accountData['day'] = val.toString();
                      _isDaySelected = true;
                    });
                  },
                ),
                _createBirthDate(
                    initialValue: 10,
                    name: _isMonthSelected
                        ? _accountData['month']
                        : 'Month',
                    list: _monthList,
                    fun: (int val) {
                      setState(() {
                        _accountData['month'] = val.toString();
                        _isMonthSelected = true;
                      });
                    }),
                _createBirthDate(
                    initialValue: 1990,
                    name: _isYearSelected ? _accountData['year'] : 'Year',
                    list: _yearList,
                    fun: (int val) {
                      setState(() {
                        _accountData['year'] = val.toString();
                        _isYearSelected = true;
                      });
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 17),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      'Gender:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      shadowColor: Colors.blueAccent,
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                                _isGenderSelected == false
                                    ? 'gender'
                                    : _accountData['gender'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 40,
                            width: 35,
                            child: PopupMenuButton(
                              initialValue: 'Male',
                              tooltip: 'Select Gender',
                              itemBuilder: (ctx) => ['Male', 'Female']
                                  .map((String val) =>
                                  PopupMenuItem<String>(
                                    value: val,
                                    child: Text(val.toString()),
                                  ))
                                  .toList(),
                              onSelected: (val) {
                                setState(() {
                                  _accountData['gender'] = val.trim();
                                  _isGenderSelected = true;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Social status:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FittedBox(
                            child: Text(
                                _isMaterialStatus == false
                                    ? 'Social status'
                                    : _accountData['materialStatus'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 35,
                          child: PopupMenuButton(
                            initialValue: 'Single',
                            tooltip: 'Select social status',
                            itemBuilder: (ctx) => materialStatus
                                .map(
                                    (String val) => PopupMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString()),
                                ))
                                .toList(),
                            onSelected: (val) {
                              setState(() {
                                _accountData['materialStatus'] = val.trim();
                                _isMaterialStatus = true;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _isDoctor
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Speciatly:',
                style: TextStyle(fontSize: 18),
              ),
            )
                : SizedBox(),
            _isDoctor
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FittedBox(
                            child: Text(
                                _isSpecialtySelected == false
                                    ? 'Speciatly'
                                    : _accountData['speciatly'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 35,
                          child: PopupMenuButton(
                            tooltip: 'Select Speciatly',
                            itemBuilder: (ctx) => listSpecialty
                                .map((String val) =>
                                PopupMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString()),
                                ))
                                .toList(),
                            onSelected: (val) {
                              setState(() {
                                _accountData['speciatly'] = val.trim();
                                _isSpecialtySelected = true;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
      Step(
          isActive: true,
          state: StepState.indexed,
          title: Text(
              _isDoctor ? 'Address and Bio' : 'Address and about you'),
          content: Column(
            children: <Widget>[
              InkWell(
                  onTap: selectUserLocationType,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    height: 80,
                    child: TextFormField(
                      autofocus: false,
                      style: TextStyle(fontSize: 15),
                      controller: _locationTextEditingController,
                      textInputAction: TextInputAction.done,
                      enabled: _isEditLocationEnable,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: selectUserLocationType,
                          child: Icon(
                            Icons.my_location,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                        labelText: 'Location',
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
                      keyboardType: TextInputType.text,
                      autovalidate: true,
// ignore: missing_return
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return 'Invalid Location';
                        }
                      },
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                height: 90,
                child: TextFormField(
                  controller: _aboutEditingController,
                  autofocus: false,
                  focusNode: null,
                  onChanged: (val) {
                    _accountData['aboutYouOrBio'] = val.trim();
                  },
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: _isDoctor ? "Bio" : 'About You',
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
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          )),
      Step(
          isActive: true,
          state: _isDoctor ? StepState.indexed : StepState.complete,
          title: const Text('Profile picture'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _openImagePicker();
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Select Image",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(color: Colors.white, fontSize: 17),
                      ),
                      Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: _imageFile == null
                      ? AssetImage('assets/user.png')
                      : FileImage(_imageFile),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          )),
      Step(
          isActive: true,
          state: StepState.indexed,
          title: const Text('Clinic Data'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _createTextForm(
                labelText: 'Clinic Name',
                nextFocusNode: null,
                isStopped: true,
                currentFocusNode: null,
                validator: (_) {},
              ),
              InkWell(
                  onTap: _selectClinicLocationType,
                  child: Container(
                    padding: EdgeInsets.only(top: 7.0),
                    height: 80,
                    child: TextFormField(
                      autofocus: false,
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
                      _clinicData['startTime']=time.toIso8601String();
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

                      _clinicData['endTime']=time.toIso8601String();
//                            setState(() {
//                              // _dateTime = time;
//                            });
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
                      autofocus: false,
                      focusNode: _hourNode,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
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
                        errorStyle: TextStyle(color: Colors.blue),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      onChanged: (val) {
                        _watingTimeHour = val.trim();
                        if (val.trim().length == 1) {
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
                      autofocus: false,
                      focusNode: _minNode,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
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
                        errorStyle: TextStyle(color: Colors.blue),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      onChanged: (val) {
                        _wattingTimeMin = val.trim();
                        if (val.trim().length == 2) {
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
                      width: 43,
                    ),
                    Container(
                      height: 50,
                      width: 75,
                      child: TextFormField(
                        autofocus: false,
                        focusNode: _fees,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
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
                          errorStyle: TextStyle(color: Colors.blue),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        onChanged: (val) {
                          _clinicData['fees'] = val.trim();
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
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
                            bottom: 8.0,
                            left: 15,
                            right: 15,
                            top: 6.0),
                        child: Container(
                          height: 135,
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
                                      BorderRadius.circular(
                                          10)),
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
              )
            ],
          ))
    ]
        : widget.isEditingEnable?
    [
      Step(
        title: const Text('New Account'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: _newAcountKeyOne,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _createTextForm(
                  controller: _firstTextEditingController,
                  labelText: 'First name',
                  nextFocusNode: _middleNameNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter first name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                  controller: _middleTextEditingController,
                  labelText: 'Middle name',
                  currentFocusNode: _middleNameNode,
                  nextFocusNode: _lastNameNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter middle name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                  controller: _lastTextEditingController,
                  labelText: 'Last name',
                  currentFocusNode: _lastNameNode,
                  nextFocusNode: _nationalIDNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter last name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                height: 80,
                child: TextFormField(
                  controller: _phoneTextEditingController,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  focusNode: _phoneNumberNode,
                  decoration: InputDecoration(
                    prefix: Container(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "+20",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    labelText: "Phone number",
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
                  keyboardType: TextInputType.phone,
// ignore: missing_return
                  validator: (String value) {
                    if (value.trim().isEmpty || value.trim().length != 10) {
                      return "Please enter Phone number!";
                    }
                    if (value.trim().length != 10) {
                      return "Invalid Phone number!";
                    }
                  },
                  onSaved: (value) {
                    _accountData['Phone number'] = value.trim();
                    _phoneNumberNode.unfocus();
                  },
                  onFieldSubmitted: (_) {
                    _phoneNumberNode.unfocus();
                    FocusScope.of(context).requestFocus(_jobNode);
                  },
                ),
              ),
              _createTextForm(
                  controller: _jobTextEditingController,
                  labelText: 'Job',
                  currentFocusNode: _jobNode,
                  // ignore: missing_return
                  validator: (_) {},
                  isStopped: true),
            ],
          ),
        ),
      ),
      Step(
        isActive: true,
        state: StepState.indexed,
        title: const Text('complete Your Data'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Birth Date:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _createBirthDate(
                  initialValue: 10,
                  name: _isDaySelected ? _accountData['day'] : 'Day',
                  list: _dayList,
                  fun: (int val) {
                    setState(() {
                      _accountData['day'] = val.toString();
                      _isDaySelected = true;
                    });
                  },
                ),
                _createBirthDate(
                    initialValue: 10,
                    name: _isMonthSelected
                        ? _accountData['month']
                        : 'Month',
                    list: _monthList,
                    fun: (int val) {
                      setState(() {
                        _accountData['month'] = val.toString();
                        _isMonthSelected = true;
                      });
                    }),
                _createBirthDate(
                    initialValue: 1990,
                    name: _isYearSelected ? _accountData['year'] : 'Year',
                    list: _yearList,
                    fun: (int val) {
                      setState(() {
                        _accountData['year'] = val.toString();
                        _isYearSelected = true;
                      });
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 17),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      'Gender:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      shadowColor: Colors.blueAccent,
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                                _isGenderSelected == false
                                    ? 'gender'
                                    : _accountData['gender'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 40,
                            width: 35,
                            child: PopupMenuButton(
                              initialValue: 'Male',
                              tooltip: 'Select Gender',
                              itemBuilder: (ctx) => ['Male', 'Female']
                                  .map((String val) =>
                                  PopupMenuItem<String>(
                                    value: val,
                                    child: Text(val.toString()),
                                  ))
                                  .toList(),
                              onSelected: (val) {
                                setState(() {
                                  _accountData['gender'] = val.trim();
                                  _isGenderSelected = true;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Social status:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FittedBox(
                            child: Text(
                                _isMaterialStatus == false
                                    ? 'Social status'
                                    : _accountData['materialStatus'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 35,
                          child: PopupMenuButton(
                            initialValue: 'Single',
                            tooltip: 'Select social status',
                            itemBuilder: (ctx) => materialStatus
                                .map(
                                    (String val) => PopupMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString()),
                                ))
                                .toList(),
                            onSelected: (val) {
                              setState(() {
                                _accountData['materialStatus'] = val.trim();
                                _isMaterialStatus = true;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _auth.getUserType =='doctor'
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Speciatly:',
                style: TextStyle(fontSize: 18),
              ),
            )
                : SizedBox(),
            _isDoctor
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FittedBox(
                            child: Text(
                                _isSpecialtySelected == false
                                    ? 'Speciatly'
                                    : _accountData['speciatly'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 35,
                          child: PopupMenuButton(
                            tooltip: 'Select Speciatly',
                            itemBuilder: (ctx) => listSpecialty
                                .map((String val) =>
                                PopupMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString()),
                                ))
                                .toList(),
                            onSelected: (val) {
                              setState(() {
                                _accountData['speciatly'] = val.trim();
                                _isSpecialtySelected = true;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
      Step(
          isActive: true,
          state: StepState.indexed,
          title: Text(
              _isDoctor ? 'Address and Bio' : 'Address and about you'),
          content: Column(
            children: <Widget>[
              InkWell(
                  onTap: selectUserLocationType,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    height: 80,
                    child: TextFormField(
                      autofocus: false,
                      style: TextStyle(fontSize: 15),
                      controller: _locationTextEditingController,
                      textInputAction: TextInputAction.done,
                      enabled: _isEditLocationEnable,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: selectUserLocationType,
                          child: Icon(
                            Icons.my_location,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                        labelText: 'Location',
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
                      keyboardType: TextInputType.text,
                      autovalidate: true,
// ignore: missing_return
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return 'Invalid Location';
                        }
                      },
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                height: 90,
                child: TextFormField(
                  controller: _aboutEditingController,
                  autofocus: false,
                  focusNode: null,
                  onChanged: (val) {
                    _accountData['aboutYouOrBio'] = val.trim();
                  },
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: _isDoctor ? "Bio" : 'About You',
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
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          )),
      Step(
          isActive: true,
          state: _isDoctor ? StepState.indexed : StepState.complete,
          title: const Text('Profile picture'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _openImagePicker();
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Select Image",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(color: Colors.white, fontSize: 17),
                      ),
                      Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: _imageFile == null
                      ? AssetImage('assets/user.png')
                      : FileImage(_imageFile),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          )),
    ]:[
      Step(
        title: const Text('New Account'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: _newAcountKeyOne,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _createTextForm(
                  controller: _firstTextEditingController,
                  labelText: 'First name',
                  nextFocusNode: _middleNameNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter first name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                  controller: _middleTextEditingController,
                  labelText: 'Middle name',
                  currentFocusNode: _middleNameNode,
                  nextFocusNode: _lastNameNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter middle name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                  controller: _lastTextEditingController,
                  labelText: 'Last name',
                  currentFocusNode: _lastNameNode,
                  nextFocusNode: _nationalIDNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length < 2) {
                      return 'Please enter last name';
                    }
                    if (val.trim().length < 2) {
                      return 'Invalid Name';
                    }
                  }),
              _createTextForm(
                  labelText: 'National ID',
                  currentFocusNode: _nationalIDNode,
                  textInputType: TextInputType.number,
                  nextFocusNode: _phoneNumberNode,
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.trim().isEmpty || val.trim().length != 14) {
                      return 'Please enter National ID';
                    }
                    if (val.trim().length != 14) {
                      return 'Invalid National ID';
                    }
                  }),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                height: 80,
                child: TextFormField(
                  controller: _phoneTextEditingController,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  focusNode: _phoneNumberNode,
                  decoration: InputDecoration(
                    prefix: Container(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "+20",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    labelText: "Phone number",
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
                  keyboardType: TextInputType.phone,
// ignore: missing_return
                  validator: (String value) {
                    if (value.trim().isEmpty || value.trim().length != 10) {
                      return "Please enter Phone number!";
                    }
                    if (value.trim().length != 10) {
                      return "Invalid Phone number!";
                    }
                  },
                  onSaved: (value) {
                    _accountData['Phone number'] = value.trim();
                    _phoneNumberNode.unfocus();
                  },
                  onFieldSubmitted: (_) {
                    _phoneNumberNode.unfocus();
                    FocusScope.of(context).requestFocus(_jobNode);
                  },
                ),
              ),
              _createTextForm(
                  controller: _jobTextEditingController,
                  labelText: 'Job',
                  currentFocusNode: _jobNode,
                  // ignore: missing_return
                  validator: (_) {},
                  isStopped: true),
            ],
          ),
        ),
      ),
      Step(
        isActive: true,
        state: StepState.indexed,
        title: const Text('complete Your Data'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Birth Date:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _createBirthDate(
                  initialValue: 10,
                  name: _isDaySelected ? _accountData['day'] : 'Day',
                  list: _dayList,
                  fun: (int val) {
                    setState(() {
                      _accountData['day'] = val.toString();
                      _isDaySelected = true;
                    });
                  },
                ),
                _createBirthDate(
                    initialValue: 10,
                    name: _isMonthSelected
                        ? _accountData['month']
                        : 'Month',
                    list: _monthList,
                    fun: (int val) {
                      setState(() {
                        _accountData['month'] = val.toString();
                        _isMonthSelected = true;
                      });
                    }),
                _createBirthDate(
                    initialValue: 1990,
                    name: _isYearSelected ? _accountData['year'] : 'Year',
                    list: _yearList,
                    fun: (int val) {
                      setState(() {
                        _accountData['year'] = val.toString();
                        _isYearSelected = true;
                      });
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 17),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      'Gender:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      shadowColor: Colors.blueAccent,
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                                _isGenderSelected == false
                                    ? 'gender'
                                    : _accountData['gender'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 40,
                            width: 35,
                            child: PopupMenuButton(
                              initialValue: 'Male',
                              tooltip: 'Select Gender',
                              itemBuilder: (ctx) => ['Male', 'Female']
                                  .map((String val) =>
                                  PopupMenuItem<String>(
                                    value: val,
                                    child: Text(val.toString()),
                                  ))
                                  .toList(),
                              onSelected: (val) {
                                setState(() {
                                  _accountData['gender'] = val.trim();
                                  _isGenderSelected = true;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Social status:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FittedBox(
                            child: Text(
                                _isMaterialStatus == false
                                    ? 'Social status'
                                    : _accountData['materialStatus'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 35,
                          child: PopupMenuButton(
                            initialValue: 'Single',
                            tooltip: 'Select social status',
                            itemBuilder: (ctx) => materialStatus
                                .map(
                                    (String val) => PopupMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString()),
                                ))
                                .toList(),
                            onSelected: (val) {
                              setState(() {
                                _accountData['materialStatus'] = val.trim();
                                _isMaterialStatus = true;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _isDoctor
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'Speciatly:',
                style: TextStyle(fontSize: 18),
              ),
            )
                : SizedBox(),
            _isDoctor
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shadowColor: Colors.blueAccent,
                    elevation: 8.0,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.card,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FittedBox(
                            child: Text(
                                _isSpecialtySelected == false
                                    ? 'Speciatly'
                                    : _accountData['speciatly'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 35,
                          child: PopupMenuButton(
                            tooltip: 'Select Speciatly',
                            itemBuilder: (ctx) => listSpecialty
                                .map((String val) =>
                                PopupMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString()),
                                ))
                                .toList(),
                            onSelected: (val) {
                              setState(() {
                                _accountData['speciatly'] = val.trim();
                                _isSpecialtySelected = true;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
      Step(
          isActive: true,
          state: StepState.indexed,
          title: Text(
              _isDoctor ? 'Address and Bio' : 'Address and about you'),
          content: Column(
            children: <Widget>[
              InkWell(
                  onTap: selectUserLocationType,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    height: 80,
                    child: TextFormField(
                      autofocus: false,
                      style: TextStyle(fontSize: 15),
                      controller: _locationTextEditingController,
                      textInputAction: TextInputAction.done,
                      enabled: _isEditLocationEnable,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: selectUserLocationType,
                          child: Icon(
                            Icons.my_location,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                        labelText: 'Location',
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
                      keyboardType: TextInputType.text,
                      autovalidate: true,
// ignore: missing_return
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return 'Invalid Location';
                        }
                      },
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                height: 90,
                child: TextFormField(
                  controller: _aboutEditingController,
                  autofocus: false,
                  focusNode: null,
                  onChanged: (val) {
                    _accountData['aboutYouOrBio'] = val.trim();
                  },
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: _isDoctor ? "Bio" : 'About You',
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
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          )),
      Step(
          isActive: true,
          state: _isDoctor ? StepState.indexed : StepState.complete,
          title: const Text('Profile picture'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _openImagePicker();
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Select Image",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(color: Colors.white, fontSize: 17),
                      ),
                      Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: _imageFile == null
                      ? AssetImage('assets/user.png')
                      : FileImage(_imageFile),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          )),
    ];
    verifyUserData() async{
      if (_accountData['First name'] == '' ||
          _accountData['Middle name'] == '' ||
          _accountData['Last name'] == '' ||
          _accountData['National ID'] == '' ||
          _accountData['Phone number'] == '' ||
          _accountData['UrlImg'] == '' ||
          _accountData['gender'] == '' ||
          _accountData['day'] == '' ||
          _accountData['month'] == '' ||
          _accountData['year'] == '' ||
          _accountData['Location'] == '' ||
          _accountData['lat'] == '' ||
          _accountData['long'] == '' ||
          _accountData['materialStatus'] == '') {
        Toast.show("Please complete your Data", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        if (_isDoctor) {
          if (_accountData['speciatly'] == '' ||
              _clinicData['Clinic Name'] == '' ||
              _clinicData['cliniclocation'] == '' ||
              _clinicData['cliniclat'] == '' ||
              _clinicData['cliniclong'] == '' ||
              _clinicData['watingTime'] == '' ||
              _clinicData['fees'] == '' ||
              _clinicData['workingDays'] == []) {
            print(_clinicData);
            Toast.show(
                "Please complete clinic Data and select speciatly", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        }
      } else {
        print('hhhhhhh');
        setState(() {
          _isLoading =true;
        });
        bool isScuess = await Provider.of<Auth>(context,listen: false).registerUserData(listOfData: _accountData);
        if(isScuess){
          _isLoading =false;
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              title: Text("Profile Created"),
              content: Text(
                "Welcome ${_accountData['First name']}",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(HomeScreen.routeName);
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() => complete = true);
                  },
                ),
              ],
            ),
          );
        }else{
          setState(() {
            _isLoading =false;
          });
          Toast.show(
              "Please try again", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }

      }
    }
    _incrementStep() {
      currentStep + 1 == steps.length
          ? setState(() => complete = true)
          : goTo(currentStep + 1);
    }
    nextStep() async {
      print(steps.length);
      print(currentStep);

      if (currentStep == 0) {
        if(_isDoctor){
          if (_newAcountKeyOne.currentState.validate()) {
            _newAcountKeyOne.currentState.save();
            _middleNameNode.unfocus();
            _lastNameNode.unfocus();
            _nationalIDNode.unfocus();
            _phoneNumberNode.unfocus();
            _jobNode.unfocus();
            _incrementStep();
            return;
          }
        }else{
          if (_newAcountKeyTwo.currentState.validate()) {
            _newAcountKeyTwo.currentState.save();
            _middleNameNode.unfocus();
            _lastNameNode.unfocus();
            _nationalIDNode.unfocus();
            _phoneNumberNode.unfocus();
            _jobNode.unfocus();
            _incrementStep();
            return;
          }
        }

      }
      if (currentStep == 1) {
        if (_isDoctor) {
          if (_accountData['day'] == '' ||
              _accountData['month'] == '' ||
              _accountData['year'] == '' ||
              _accountData['gender'] == '' ||
              _accountData['materialStatus'] == '' ||
              _accountData['speciatly'] == '') {
            Toast.show("Please Complete your data", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else {
            _incrementStep();
            return;
          }
        } else {
          if (_accountData['day'] == '' ||
              _accountData['month'] == '' ||
              _accountData['year'] == '' ||
              _accountData['gender'] == '' ||
              _accountData['materialStatus'] == '') {
            Toast.show("Please Complete your data", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else {
            _incrementStep();
            return;
          }
        }
      }
      if (currentStep == 2) {
        if (_accountData['Location'] == '') {
          Toast.show("Please add your location", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        } else {
          _incrementStep();
          return;
        }
      }
      if (currentStep == 3) {
        print('dxvb');
        !_isDoctor ? verifyUserData() : _incrementStep();
        return;
      }
      if (currentStep == 4) {
        print(currentStep);
        print(steps.length);
        if (_clinicData['Clinic Name'] == '' ||
            _clinicData['cliniclocation'] == '' ||
            _clinicData['cliniclat'] == '' ||
            _clinicData['cliniclong'] == '' ||
            _clinicData['fees'] == '') {
          Toast.show("Please complete clinic Data", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        } else {
          double hour = _watingTimeHour == ''
              ? 0.0
              : (double.parse(_watingTimeHour) * 60.0);
//          print(_watingTimeHour);
//          print(hour);
          double min =
          _wattingTimeMin == '' ? 0.0 : double.parse(_wattingTimeMin);
//          print(_wattingTimeMin);
//          print(min);

          double result = hour + min;
          _clinicData['watingTime'] = result.toString();
          _sortedWorkingDays = List<String>.generate(7, (i) => '');
          _sort();
          _clinicData['workingDays'] = _sortedWorkingDays;
          verifyUserData();
        }
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navigator.of(context).canPop()?AppBar(
        leading: BackButton(
          color: Colors.blue,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ):null,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                    child: Stepper(
                      steps: steps,
                      currentStep: currentStep,
                      onStepContinue: nextStep,
                      onStepTapped: (step) => goTo(step),
                      onStepCancel: cancel,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
