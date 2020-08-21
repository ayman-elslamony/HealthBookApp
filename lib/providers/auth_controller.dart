import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:healthbook/models/appointment_reservation.dart';
import 'package:healthbook/models/booking_time.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/models/patient_appointment.dart';
import 'package:healthbook/models/prescription.dart';
import 'package:healthbook/models/search_result.dart';
import 'package:path/path.dart';
import 'package:healthbook/list_of_infomation/list_of_information.dart';
import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/user_data.dart';
import 'package:healthbook/services/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  NetWork _netWork = NetWork();
  String _token;
  String _userId;
  String _email;
  String _userType = 'patient';
  RegisterData rgisterData;

//  =RegisterData(
//    address: '5415212',
//    aboutYou: 'dfdnfgvm cvneryuhtej dvbdcbf',
//    birthDate: '12/12-2012',
//    doctorImage: '',
//    firstName: 'Ayman',
//    gender: 'male',
//    government: 'mansoura',
//    job: 'programmer',
//    lastName: 'elskamony',
//    middleName: 'kamel',
//    number: '01145523795',
//    status: 'single',
//     patientImage: '',
//  );
  static List<DoctorAppointment> appointmentForDoctor = [];
  static List<PatientAppointment> appointmentForPatient = [];
  List<String> _allDiagnoseNames = [];
  List<DoctorsInEachDosage> _allDoctorsInEachDosage = [];
  List<Prescription> _allPrescriptionsForSpecificDoctor = [];

  List<Prescription> get allPrescriptionsForSpecificDoctor =>
      _allPrescriptionsForSpecificDoctor;
  List<String> _allDoctorsId = [];

  List<DoctorsInEachDosage> get allDoctorsInEachDosage =>
      _allDoctorsInEachDosage;
  List<SearchResult> _searchResult = [];
  static ClinicData clinicData;
  List<Appointment> allAppointmentTime = [];
  bool get isAuth {
    return token != null;
  }

  set setUserType(String type) {
    _userType = type;
  }

  String get token {
    return _token;
  }

  RegisterData get userData {
    return rgisterData;
  }

  List<String> get allDiagnose {
    return _allDiagnoseNames;
  }

  ClinicData get getClinicData {
    return clinicData;
  }

  List<SearchResult> get searchResult {
    return _searchResult;
  }

  List<DoctorAppointment> get allAppointment {
    return appointmentForDoctor;
  }

  List<PatientAppointment> get allAppointmentOfPatient {
    return appointmentForPatient;
  }

  String get userId {
    return _userId;
  }

  String get getUserType {
    return _userType;
  }

  String get email {
    return _email;
  }
//finish
  Future<String> signIn(
      {String email, String password, bool isCommingFromSignUp = false}) async {
    print(email);
    print(password);
    var data = await _netWork.postData(
      url: '$_userType/login',
      headers: {'Content-Type': 'application/json'},
      data: {'email': email.trim(), 'password': password.trim()},
    );
    print('ddfhgt7u6yiytrf');
    if (data['message'] == 'Auth success') {
      _token = data['token'];
      _userId = data['_id'];
      _email = email.trim();
//      print(_token);
//      print(_userId);
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('dataToSignIn')) {
        final dataToSignIn = json.encode({
          'email': email.trim(),
          'password': password.trim(),
          'userType': _userType,
        });
        prefs.setString('dataToSignIn', dataToSignIn);
      }
      if (isCommingFromSignUp == false) {
        await getUserData();
      }
    }
    return data['message'];
  }
//finish
  Future<String> signUp(
      {String email, String password, String nationalID}) async {
    _userType = 'patient';
    var data = await _netWork.postData(
      url: 'patient/signup',
      headers: {'Content-Type': 'application/json'},
      data: {
        'email': email,
        'password': password,
        'nationalID': nationalID,
      },
    );
//    _userId = data['createdPatient']['id'];
//    print('data[createdPatient][id] ${data['createdPatient']['id']}');
//    print('data $data');
    print(data['message']);
    return data['message'];
  }
//finish
  Future<void> getUserData() async {
    var userData;
    print('_userType_userType$_userType');
    if (_userType == 'doctor') {
      userData = await _netWork.getData(url: 'doctor/$_userId', headers: {
        'Authorization': 'Bearer $_token',
      });
    } else {
      userData = await _netWork.getData(url: 'patient/$_userId', headers: {
        'Authorization': 'Bearer $_token',
      });
    }
//    print(userData);
    print(userData['patient']);
    if (userData['patient'] != null && _userType == 'patient') {
      print('A');
      rgisterData = RegisterData.fromJson(userData['patient'], 'patient');
      print('B');
      print(rgisterData);
//      print(rgisterData.firstName);
//      print(rgisterData.birthDate);
      print('rgisterData.numberrgisterData.number${rgisterData.number}');
      return;
    }

    if (userData['doctor'] != null && _userType == 'doctor') {
      rgisterData = RegisterData.fromJson(userData['doctor'], 'doctor');
      print('rgisterData.birthDatergisterData.birthDate${rgisterData.birthDate}');
      var dataForClinic =
      await _netWork.getData(url: 'doctor/clinic/$_userId', headers: {
        'Authorization': 'Bearer $_token',
      });
      print('dataForClinicdataForClinicdataForClinic$dataForClinic');
      if (dataForClinic['searchedDoctor'] != null) {
        clinicData = ClinicData.fromJson(dataForClinic['searchedDoctor'][0]);
        print(clinicData);
      }
      return;
    }
  }
//finish
  Future<void> getUserAppointment() async {
    var appointmentData;
    print('Iam Here _userType$_userType');
    if (_userType == 'doctor') {
      appointmentData = await _netWork.getData(
          url: 'appoint/appoint-doctor/$_userId',
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
          },
          isAppoitment: true);
      print('appointmentData$appointmentData');
      if (appointmentData['Doctor'].length != 0) {
        List<DoctorAppointment> allAppointment = [];

        for (int i = 0; i < appointmentData['Doctor'].length; i++) {
          var userData = await _netWork.getData(
              url:
              'patient/search/${appointmentData['Doctor'][i]['patientID']}',
              headers: {
                'Authorization': 'Bearer $_token',
              });
          print(appointmentData['Doctor'][i]['patientID']);
          allAppointment.add(DoctorAppointment.fromJson(
              appointmentData['Doctor'][i], userData['patient']));
        }
        appointmentForDoctor = allAppointment;
        notifyListeners();
      }
    } else {
      appointmentData = await _netWork.getData(
          url: 'appoint/appoint-patient/$_userId',
          headers: {
            'Authorization': 'Bearer $_token',
          },
          isAppoitment: true);
      print('appointmentDataappointmentData$appointmentData');
      print(appointmentData);
      appointmentForPatient.clear();
      if (appointmentData['patient'].length > 0) {
        List<PatientAppointment> allAppointment = [];
        print(userData);
        for (int i = 0; i < appointmentData['patient'].length; i++) {
          var userData = await _netWork.getData(
              url: 'doctor/${appointmentData['patient'][i]['doctorID']}',
              headers: {});
          var clinicData = await _netWork.getData(
              url: 'clinic/${appointmentData['patient'][i]['clinicID']}',
              headers: {
                'Authorization': 'Bearer $_token',
              });
          print(clinicData);
          allAppointment.add(PatientAppointment.fromJson(
              appointmentData['patient'][i],
              userData['doctor'],
              clinicData['clinic']));
        }

        appointmentForPatient = allAppointment;
        print(appointmentForPatient.length);
        notifyListeners();
      }
    }
  }

  Future<void> getDataForSpecificDiagnoseName({String diagnoseName,String patientId}) async {
    var userData;
    var clinicData;
    var _allPrescriptions;
    print(_allDoctorsId.length);
    if(_userType == 'doctor'){
      if (_allDoctorsId.length > 0) {
        for (int i = 0; i < _allDoctorsId.length; i++) {
          print('_allDoctorsId[i]${_allDoctorsId[i]}');
          _allPrescriptions = await _netWork.getData(
              url: 'diagno/$patientId/${_allDoctorsId[i]}',headers: {
            'Authorization': 'Bearer $_token',
          });
          userData = await _netWork.getData(url: 'doctor/${_allDoctorsId[i]}');
          print('_allPrescriptions_allPrescriptions$_allPrescriptions');
          clinicData = await _netWork
              .getData(url: 'doctor/clinic/${_allDoctorsId[i]}', headers: {
            'Authorization': 'Bearer $_token',
          });
          print(userData);
          print(clinicData);
          _allDoctorsInEachDosage.clear();
          _allDoctorsInEachDosage.add(DoctorsInEachDosage.fromJson(
              _allPrescriptions['Diagno'],
              userData['doctor'],
              clinicData['searchedDoctor'][0],
              diagnoseName));
        }
      }
    }else{
      if (_allDoctorsId.length > 0) {
        for (int i = 0; i < _allDoctorsId.length; i++) {
          print('_allDoctorsId[i]${_allDoctorsId[i]}');
          _allPrescriptions = await _netWork.getData(
              url: 'diagno/$_userId/${_allDoctorsId[i]}',headers: {
            'Authorization': 'Bearer $_token',
          });
          userData = await _netWork.getData(url: 'doctor/${_allDoctorsId[i]}');
          print('_allPrescriptions_allPrescriptions$_allPrescriptions');
          clinicData = await _netWork
              .getData(url: 'doctor/clinic/${_allDoctorsId[i]}', headers: {
            'Authorization': 'Bearer $_token',
          });
          print(clinicData['searchedDoctor'][0]);
          print(userData);
          print(clinicData);

          _allDoctorsInEachDosage.clear();
          _allDoctorsInEachDosage.add(DoctorsInEachDosage.fromJson(
              _allPrescriptions['Diagno'],
              userData['doctor'],
              clinicData['searchedDoctor'][0],
              diagnoseName));
        }
      }
    }

    print(
        '_allDoctorsInEachDosage_allDoctorsInEachDosage${_allDoctorsInEachDosage[0]
            .allPrescription.length}');

//    _allDoctorsInEachDosage.clear();
//    if(_allPrescriptions['Diagno'].length > 0 ) {
//      for(int i=0; i<_allPrescriptions['Diagno'].length; i++){
//        if(!_allDoctorsInEachDosage.contains(_allPrescriptions['Diagno'][i]['diagnose'])) {
//         _allDoctorsInEachDosage.add(_allPrescriptions['Diagno'][i]['diagnose']);
//        }
//      }
//    }
    notifyListeners();
  }

  Future<void> getPrescriptionForSpecificDoctor(
      {String patientId, bool enableNotify = true}) async {
      var _allPrescriptions = await _netWork.getData(
          url: 'diagno/$patientId/$_userId');
      if (_allPrescriptions != null && _allPrescriptions['Diagno'].length > 0) {
        _allPrescriptionsForSpecificDoctor.clear();
        for (int i = 0; i < _allPrescriptions['Diagno'].length; i++) {
          _allPrescriptionsForSpecificDoctor
              .add(Prescription.fromJson(_allPrescriptions['Diagno'][i]));
        }
      }
      if (enableNotify) {
        notifyListeners();
      }

    print(
        '_allPrescriptionsForSpecificDoctor_allPrescriptionsForSpecificDoctor${_allPrescriptionsForSpecificDoctor
            .length}');
  }

  Future<void> getAllDiagnoseName({String patientId}) async {
    List<String> allDiagnosesName = [];
    var _allPrescriptions;
    if (patientId != null) {
      _allPrescriptions = await _netWork.getData(
          url: 'diagno/patient/$patientId');
    } else {
      _allPrescriptions =
      await _netWork.getData(url: 'diagno/patient/$_userId');
    }

    print(_allPrescriptions['Diagno']);
    if (_allPrescriptions['Diagno'].length > 0) {
      _allDoctorsId=[];
      for (int i = 0; i < _allPrescriptions['Diagno'].length; i++) {
        if (!allDiagnosesName
            .contains(_allPrescriptions['Diagno'][i]['diagnose'])) {
          allDiagnosesName.add(_allPrescriptions['Diagno'][i]['diagnose']);
        }
        if (!_allDoctorsId
            .contains(_allPrescriptions['Diagno'][i]['doctorID'])) {
          _allDoctorsId.add(_allPrescriptions['Diagno'][i]['doctorID']??'');
        }
      }
//   List<ListOfDiagnoseName> list = List(allDiagnoses.length);
//   print('listlistlist${list.length}');
//   for(int i=0; i<_allPrescriptions['Diagno'].length; i++){
//     for(int x =0; x<allDiagnoses.length; x++){
//       if(allDiagnoses[x] != _allPrescriptions['Diagno'][i]['diagnose']){
//         userData = await _netWork
//             .getData(url: 'doctor/${_allPrescriptions['Diagno'][i]['doctorID']}' );
//         print(_allPrescriptions['Diagno'][i]['diagnose']);
//         list.add(ListOfDiagnoseName.fromJson(_allPrescriptions['Diagno'][i],));
//       }
//       else{
//         userData = await _netWork
//             .getData(url: 'doctor/${_allPrescriptions['Diagno'][i]['doctorID']}' );
//         list[x].allDoctorsInEachDosage.add(DoctorsInEachDosage.fromJson(_allPrescriptions['Diagno'][i],userData['doctor']));
//     }
//     }
//   }
//   print('list.length${list.length}');
//   userData = await _netWork
//       .getData(url: 'doctor/${_allPrescriptions['Diagno'][0]['doctorID']}',
//      );
//   print('rrrrrrrrrrr');
//
//   allDiagnoses.add(ListOfDiagnoseName.fromJson(_allPrescriptions['Diagno'][0],userData['doctor']));
//   print('nnnnnnnnn${_allPrescriptions['Diagno'].length}');
//    print(allDiagnoses.length);
//   for (int i = 0; i < _allPrescriptions['Diagno'].length; i++) {
//     userData = await _netWork
//         .getData(url: 'doctor/${_allPrescriptions['Diagno'][0]['doctorID']}');
//     List<String> all=[];
//     for(int x=0; x<allDiagnoses.length; x++){
//       print('iiiii$i');
//       print(allDiagnoses[x].diagnoseName);
//       print('XXXX$x');
//       all.add(allDiagnoses[x].diagnoseName);
//
//       print('sesallDiagnoses${allDiagnoses.length}');
//     }
//     if(!all.contains(_allPrescriptions['Diagno'][i]['diagnose'])){
//         print(_allPrescriptions['Diagno'][i]['diagnose']);
//         allDiagnoses.add(ListOfDiagnoseName.fromJson(_allPrescriptions['Diagno'][i],userData['doctor']));
//       }
//       else{
//         userData = await _netWork
//             .getData(url: 'doctor/${_allPrescriptions['Diagno'][0]['doctorID']}' );
//         allDiagnoses[x].allDoctorsInEachDosage.add(DoctorsInEachDosage.fromJson(_allPrescriptions['Diagno'][i],userData['doctor']));
//
//     }
//     print('allDiagnosesallDiagnosesallDiagnoses${allDiagnoses.length}');
//   }

      _allDiagnoseNames.clear();
      _allDiagnoseNames = allDiagnosesName;
    }
    notifyListeners();
  }

  Future<bool> deleteAppointmentForPatAndDoc(
      {@required String appointmentId, String type = 'doctor'}) async {
    try {
      var appointmentData;
      if (type == 'doctor') {
        appointmentData = await _netWork.deleteAppointment(
          url: 'appoint/appoint-doctor/$appointmentId',
          headers: {
            'Authorization': 'Bearer $_token',
          },
        );
      } else {
        appointmentData = await _netWork.deleteAppointment(
          url: 'appoint/appoint-patient/$appointmentId',
          headers: {
            'Authorization': 'Bearer $_token',
          },
        );
      }
      print(appointmentData);
      if (appointmentData['message'] == 'Appoint deleted' && type == 'doctor') {
        appointmentForDoctor.removeWhere(
                (appointment) => appointment.appointmentId == appointmentId);
      }
      if (appointmentData['message'] == 'Appoint deleted' &&
          type == 'patient') {
        appointmentForPatient.removeWhere(
                (appointment) => appointment.appointmentId == appointmentId);
      }
      notifyListeners();
      return appointmentData['message'] == 'Appoint deleted' ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }
//finish
  Future<String> registerUserData(
      {Map<String, dynamic> listOfData}) async {
    print(listOfData);
    String birthDate =
        '${listOfData['day']}-${listOfData['month']}-${listOfData['year']}';
    String government = '';
    for (int i = 0; i < governorateList.length; i++) {
      if (listOfData['Location'].contains(governorateList[i])) {
        government = governorateList[i];
      }
    }
    String fileName='';
    print(listOfData['UrlImg']);
    print(listOfData['Phone number'].toString());
    if (!listOfData['UrlImg'].toString().contains('https:')) {
        fileName = listOfData['UrlImg'].path
            .split('/')
            .last;
        print("File Name : $fileName");
    }
    FormData formData;
      formData = FormData.fromMap({
        'phone': '0${listOfData['Phone number']}',
        'address': listOfData['Location'],
        'status': listOfData['materialStatus'],
        'lastName': listOfData['Last name'],
        'firstName': listOfData['First name'],
        'middleName': listOfData['Middle name'],
        'birthDate': birthDate,
        'patientImage': !listOfData['UrlImg'].toString().contains('https:')?await MultipartFile.fromFile(listOfData['UrlImg'].path,
            filename: fileName):null
            ,
        'job': listOfData['Job'],
        'gender': listOfData['gender'],
        'government': government,
      });
    var data = await _netWork
          .updateData(url: 'patient/$_userId', formData: formData, headers: {
        'Authorization': 'Bearer $_token',
      });
    print('data $data');
    if (data != null) {
      rgisterData = RegisterData.fromJson(data['patient'], 'patient');
      return 'success';
    } else {
      return 'failed';
    }
  }

 Future<bool> editProfile({String type,String address,String phone,File image,String job,String social,String bio})async{
    FormData formData;
    var data;
    try{
      if(type =='bio'){
        formData = FormData.fromMap({
          'bio': bio,
        });
        data = await _netWork
            .updateData(url: 'doctor/$_userId', formData: formData, headers: {
          'Authorization': 'Bearer $_token',
        });
        print('data $data');
      }
      if(type == 'image'){
        String fileName = image.path
            .split('/')
            .last;
        if(_userType == 'doctor'){
          formData = FormData.fromMap({
            'doctorImage': await MultipartFile.fromFile(image.path,
                filename: fileName)
          });
        }else{
          formData = FormData.fromMap({
            'patientImage': await MultipartFile.fromFile(image.path,
                filename: fileName)
          });
        }
        data = await _netWork
            .updateData(url: _userType=='doctor'?'doctor/$_userId':'patient/$_userId', formData: formData, headers: {
          'Authorization': 'Bearer $_token',
        });
        print(data);
      }
      if(type == 'job'){
        formData = FormData.fromMap({
          'job': job,
        });
        data = await _netWork
            .updateData(url: _userType=='doctor'?'doctor/$_userId':'patient/$_userId', formData: formData, headers: {
          'Authorization': 'Bearer $_token',
        });
        print('data $data');
      }
      if(type == 'address'){
        String government = '';
        for (int i = 0; i < governorateList.length; i++) {
          if (address.contains(governorateList[i])) {
            government = governorateList[i];
          }
        }
        formData = FormData.fromMap({
          'address': address,
          'government': government,
        });
        data = await _netWork
            .updateData(url: _userType=='doctor'?'doctor/$_userId':'patient/$_userId', formData: formData, headers: {
          'Authorization': 'Bearer $_token',
        });
        print('data $data');
      }
      if(type == 'phone'){
        if(_userType == 'doctor') {
          formData = FormData.fromMap({
            'number': '0$phone',
          });
        }else{
          formData = FormData.fromMap({
            'phone': '0$phone',
          });
        }
        data = await _netWork
            .updateData(url: _userType=='doctor'?'doctor/$_userId':'patient/$_userId', formData: formData, headers: {
          'Authorization': 'Bearer $_token',
        });
        print('data $data');
      }
      if(type == 'social'){
        formData = FormData.fromMap({
          'status': social,
        });
        data = await _netWork
            .updateData(url: _userType=='doctor'?'doctor/$_userId':'patient/$_userId', formData: formData, headers: {
          'Authorization': 'Bearer $_token',
        });
        print('data $data');
      }
      if (data != null) {
        if(_userType =='doctor'){
          rgisterData = RegisterData.fromJson(data['doctor'], 'doctor');
        }else{
          rgisterData = RegisterData.fromJson(data['patient'], 'patient');
        }
        print('svfdsb');
        notifyListeners();
        return true;
      }else{
        return false;
      }
    }catch (e){
      print(e);
      return false;
    }
  }
  //not enabled
  Future<String> registerClinicDataAndEditing(
      {Map<String, dynamic> listOfClinicData, bool isEditing = false}) async {
    print('clinicDataclinicDataclinicData$clinicData');

    String government = '';
    for (int i = 0; i < governorateList.length; i++) {
      if (listOfClinicData['cliniclocation'].contains(governorateList[i])) {
        government = governorateList[i];
      }
    }
    var data;
    Map<String, dynamic> _clinicData = {
      'clinicName': listOfClinicData['Clinic Name'],
      'waitingTime': listOfClinicData['watingTime'],
//    'workingDays': listOfClinicData['workingDays'],
//    'openingTime': listOfClinicData['startTime'],
//    'clossingTime': listOfClinicData['endTime'],
//    'number': [listOfClinicData['number']],
//    'government': government,
//    'address': listOfClinicData['cliniclocation'],
//    'fees': listOfClinicData['fees'],
//    'doctorID': _userId,
    };
    if (isEditing) {
      data = await _netWork.updateData(
          url: 'clinic/5ec8a43dfa6d9b35d08f005a',
          data: _clinicData,
          headers: {
            'Authorization': 'Bearer $_token',
          });
      print('data $data');
    } else {
      data =
      await _netWork.postData(url: 'clinic/', data: _clinicData, headers: {
        'Authorization': 'Bearer $_token',
      });
      print('data $data');
    }
    //'aboutYou': listOfData['aboutYouOrBio'],
//       'lat': listOfData['lat'],
//       'long': listOfData['long'],
    return data['message'];
  }

  Future<bool> newPrescription({
    String diagnose,
    String diagnoseDesc,
    List<String> medicine,
    List<String> dosage,
    File radioImage,
    String radioName,
    String radioDesc,
    String patientID,
    String analysisName,
    String analysisDesc,
    String diagnoNum,
  }) async {
    String fileName;
    var formData;
    DateTime time = DateTime.now();
    if (radioName != null) {
      if(radioImage!=null &&!radioImage.toString().contains('https:')){
        fileName = radioImage.path
            .split('/')
            .last;
      }
      formData = FormData.fromMap({
        'diagnose': diagnose,
        'diagnoseDesc':diagnoseDesc,
        'medicine':medicine,
        'dosage':dosage,
        'radioImage':!radioImage.toString().contains('https:') && radioImage !=null?await MultipartFile.fromFile(radioImage.path,
            filename: fileName):null,
        'radioName':radioName,
        'radioDesc':radioDesc,
        'patientID':patientID ,
        'doctorID':_userId,
        'analysisName':analysisName,
        'analysisDesc':analysisDesc,
        'diagnoNum':diagnoNum,
        'date': '${time.day}-${time.month}-${time.year}'
      });
    }else{
      formData = FormData.fromMap({
        'diagnose': diagnose,
        'diagnoseDesc':diagnoseDesc,
        'medicine':medicine,
        'dosage':dosage,
        'radioName':radioName,
        'radioDesc':radioDesc,
        'patientID':patientID ,
        'doctorID':_userId,
        'analysisName':analysisName,
        'analysisDesc':analysisDesc,
        'diagnoNum':diagnoNum,
        'date': '${time.day}-${time.month}-${time.year}'
      });
    }
    try{
      var data = await _netWork
          .postData(url: 'diagno/', formData: formData, headers: {
        'Authorization': 'Bearer $_token',
      });
      print('data$data');
      return data['message']=='Diagnose created'?true:false;
    }catch (e){
      print(e);
      return false;
    }
  }

  Future<bool> getAllSearchResult({String name,String speciality,String governorate}) async {
var result;
bool x=true;
    if(name != ''){
      result = await _netWork.postData(
          url: 'patient/name/doctor'
          ,headers: {
        'Authorization':'Bearer $_token'
      },
          data: {
            'firstName' : name
          }

      );

    }else
    if(speciality !=null){
        result = await _netWork.postData(
        url: 'patient/speciality/doctor'
        ,headers: {
          'Authorization':'Bearer $_token'
        },
          data: {
            'speciality' : speciality
          }

        );

    }
    else if(governorate !=null){
      result = await _netWork.postData(
          url: 'patient/govern/doctor'
          ,headers: {
        'Authorization':'Bearer $_token'
      },
          data: {
            'government' : governorate
          }

      );

    }else{
      x = false;
    }
    print('resultresult$result');
    if(result != null){
    print(result['searchedDoctor'].length);
      List<SearchResult> allResult = [];
      for(int i=0; i <result['searchedDoctor'].length; i++){
        print(result['searchedDoctor'][i]['_id']);
        var clinicData = await _netWork
            .getData(url: 'doctor/clinic/${result['searchedDoctor'][i]['_id']}');
        print(clinicData);
        allResult.add(SearchResult.fromJson(result['searchedDoctor'][i], clinicData['searchedDoctor'][0]));
      }
      _searchResult = allResult;
      notifyListeners();
    }
    return x;
  }

  Future<List<Appointment>> availableTime({String clinicId}) async {
    if(allAppointmentTime.length ==0){
    var appointmentData;
    appointmentData = await _netWork.getData(
        url: 'appoint/appoint-clinic/$clinicId',
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        isAppoitment: true);
    print('appointmentData$appointmentData');
    if (appointmentData['clinic'].length != 0) {
      for (int i = 0; i < appointmentData['clinic'].length; i++) {
        allAppointmentTime.add(Appointment.fromJson(appointmentData['clinic'][i]));
      }
    }
    print('allAppointment${allAppointmentTime.length}');
    }
    return allAppointmentTime;
  }

  Future<bool> patientReservationInDoctor(
      {String appointStart, int index}) async {
    var appointmentData;
    DateTime dateTime = DateTime.now();
    try {
      int time;
      int wattingTime=0;
      if (appointStart.contains(':')) {
        List<String> splitTime = appointStart.split(':');
        time = int.parse(splitTime[0]) * 60 + int.parse(splitTime[1]);
      } else {
        time = int.parse(appointStart);
      }
      if (_searchResult[index].clinicData.waitingTime.contains(':')) {
        List<String> splitTime = _searchResult[index].clinicData.waitingTime.split(':');
        wattingTime = int.parse(splitTime[1]);
      } else {
        wattingTime = int.parse(appointStart);
      }

      time = time + wattingTime;
      int hour = time ~/ 60;
      int minutes = time % 60;
      appointmentData = await _netWork.postData(url: 'appoint/', headers: {
        'Authorization': 'Bearer $_token',
      }, data: {
        'appointStart': appointStart,
        'appointEnd': '${minutes == 0 ? '$hour' : '$hour:$minutes'}',
        'appointDate': '${dateTime.day}-${dateTime.month}-${dateTime.year}',
        'appointStatus': 'none',
        'doctorID': _searchResult[index].doctorData.id,
        "patientID": _userId,
        'clinicID': _searchResult[index].clinicData.sId
      });
      if(appointmentData['message'] == 'Appointement created'){
        appointmentForPatient=[];
      }
      print(appointmentData);
      return appointmentData['message'] == 'Appointement created'
          ? true
          : false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> tryToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('dataToSignIn')) {
      return false;
    }
    final dataToSignIn =
    json.decode(prefs.getString('dataToSignIn')) as Map<String, Object>;
    print('${dataToSignIn['password']}');
    print('${dataToSignIn['email']}');
    print('${dataToSignIn['userType']}');
    _userType = dataToSignIn['userType'];
    await signIn(
      password: dataToSignIn['password'],
      email: dataToSignIn['email'],
    );
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _email = null;
    _userType = 'patient';
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
