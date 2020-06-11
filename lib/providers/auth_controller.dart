import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:healthbook/models/appointment.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/models/patient_appointment.dart';
import 'package:path/path.dart';
import 'package:healthbook/list_of_infomation/list_of_information.dart';
import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/register_user_data.dart';
import 'package:healthbook/models/sign_in_and_up.dart';
import 'package:healthbook/services/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  NetWork _netWork = NetWork();
  SignInAndUp _signInAndUpModel;
  static String _token;
  static String _userId;
  String _email;
  String _userType = 'patient';
  static RegisterData rgisterData;
  static List<DoctorAppointment> appointmentForDoctor=[];
  static List<PatientAppointment> appointmentForPatient=[];
  static ClinicData clinicData;
  bool get isAuth {
    return token != null;
  }
  set setUserType(String type) {
    _userType =type;
  }
  String get token {
    return _token;
  }
  RegisterData get userData{
    return rgisterData;
  }
  ClinicData get getClinicData{
    return clinicData;
  }
  List<DoctorAppointment> get allAppointment{
    return appointmentForDoctor;
  }
  List<PatientAppointment> get allAppointmentOfPatient{
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

  Future<String> signIn(
      {String email, String password}) async {
    print(email);
    print(password);
    _signInAndUpModel =
        SignInAndUp(email: email.trim(), password: password.trim());
//    FormData formData = FormData.fromMap(_signInAndUpModel.toJson());
//    print(formData);
    var data = await _netWork.postData(
      url: '$_userType/login',
      data: _signInAndUpModel.toJson(),
    );
    print(data);

    if (data['message'] == 'Auth success') {
      _token = data['token'];
      print(_token);
      _email = email;
      final prefs = await SharedPreferences.getInstance();
      print(_userId);
      if(!prefs.containsKey('dataToSignIn')){
        final dataToSignIn = json.encode({
          'email': email,
          'password': password,
          'userType': _userType,
          'userId': _userId,
        });
        prefs.setString('dataToSignIn', dataToSignIn);
      }
      await getUserData();
    }
    return data['message'];
  }
  Future<String> signUp({String email, String password}) async {
    _userType = 'patient';
    _signInAndUpModel =
        SignInAndUp(email: email.trim(), password: password.trim());
    print(_signInAndUpModel.toJson());
    var data = await _netWork.postData(
      url: 'patient/signup',
      headers: {'Content-Type': 'application/json'},
      data: {'email': email.trim(), 'password': password.trim()},
    );
//    _userId = data['createdPatient']['id'];
//    print('data[createdPatient][id] ${data['createdPatient']['id']}');
//    print('data $data');
    print(data['message']);
    return data['message'];
  }
  Future<void>  getUserData()async{
    var userData;
    print('_userType_userType$_userType');
    if(_userType=='doctor'){
      userData = await _netWork
          .getData(url: 'doctor/5ec8a319fa6d9b35d08f0058', headers: {
        'Authorization': 'Bearer $_token',
      });
    }else{
      userData = await _netWork
          .getData(url: 'patient/5ec8a00afa6d9b35d08f0055', headers: {
        'Authorization': 'Bearer $_token',
      });
    }
    print(userData);
    print(userData['patient']);
    if (userData['patient'] != null && _userType =='patient') {
      rgisterData=RegisterData.fromJson(userData['patient'],'patient');
      print(rgisterData.gender);
      print(rgisterData.birthDate);
      print(rgisterData.patientImage);
      return;
    }

    if(userData['doctor'] != null && _userType =='doctor'){
      rgisterData=RegisterData.fromJson(userData['doctor'],'doctor');
      print(rgisterData.gender);
      print(rgisterData.birthDate);
      print('rgisterData.doctorImage${rgisterData.doctorImage}');
      var dataForClinic =await _netWork
          .getData(url: 'clinic/5ed6899e7966c600175a388b', headers: {
        'Authorization': 'Bearer $_token',
      });
      print(dataForClinic);
      if(dataForClinic['clinic'] !=null){
        clinicData = ClinicData.fromJson(dataForClinic['clinic']);
        print(clinicData);
      }
      return ;
    }

  }
  Future<void>  getUserAppointment()async{
    var appointmentData;
    print('_userType_userType$_userType');
    if(_userType=='doctor'){
      appointmentData = await _netWork
          .getData(url: 'appoint/', headers: {
        'Authorization': 'Bearer $_token',
      });
      if(appointmentData['appoint'] !=null){
        List<DoctorAppointment> allAppointment=[];
        var userData = await _netWork
            .getData(url: 'patient/5ec8a00afa6d9b35d08f0055', headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImEyQGEuY29tIiwiX2lkIjoiNWVjOGEwMGFmYTZkOWIzNWQwOGYwMDU1Iiwicm9sZSI6MiwiaWF0IjoxNTkwMjA2OTE2fQ.70AORnaarGm_o90xD4frGOXWRP_PMHJCWxhmNRL48Qw',
        });
        for(int i=0; i<appointmentData['appoint'].length; i++){
          print(appointmentData['appoint'][i]['patientID']);
          allAppointment.add(DoctorAppointment.fromJson(appointmentData['appoint'][i],userData['patient']));
        }
        appointmentForDoctor =allAppointment;
        notifyListeners();
      }
    }else{
      appointmentData = await _netWork
          .getData(url: 'appoint/', headers: {
        'Authorization': 'Bearer $_token',
      });
    }
    print(appointmentData);




//    print(appoitmentData['patient']);
//    if (appoitmentData['patient'] != null && _userType =='patient') {
//      rgisterData=RegisterData.fromJson(appoitmentData['patient'],'patient');
//      print(rgisterData.gender);
//      print(rgisterData.birthDate);
//      print(rgisterData.patientImage);
//      return;
//    }
//
//    if(appoitmentData['doctor'] != null && _userType =='doctor'){
//      rgisterData=RegisterData.fromJson(appoitmentData['doctor'],'doctor');
//      print(rgisterData.gender);
//      print(rgisterData.birthDate);
//      print('rgisterData.doctorImage${rgisterData.doctorImage}');
//      var dataForClinic =await _netWork
//          .getData(url: 'clinic/5ed6899e7966c600175a388b', headers: {
//        'Authorization': 'Bearer $_token',
//      });
//      print(dataForClinic);
//      if(dataForClinic['clinic'] !=null){
//        clinicData = ClinicData.fromJson(dataForClinic['clinic']);
//        print(clinicData);
//      }
      return ;
   // }

  }
  Future<String> registerUserDataAndEditing({Map<String, dynamic> listOfData}) async {
    String birthDate =
        '${listOfData['day']}/${listOfData['month']}/${listOfData['year']}';
    String government = '';
    for (int i = 0; i < governorateList.length; i++) {
      if (listOfData['Location'].contains(governorateList[i])) {
        government = governorateList[i];
      }
    }
    //'aboutYou': listOfData['aboutYouOrBio'],
//       'lat': listOfData['lat'],
//       'long': listOfData['long'],
    String fileName;
    if (listOfData['UrlImg'] != null &&
        listOfData['UrlImg'].path != null &&
        listOfData['UrlImg'].path.isNotEmpty) {
      fileName = listOfData['UrlImg'].path.split('/').last;
      print("File Name : $fileName");
      print("File Size : ${listOfData['UrlImg'].lengthSync()}");
    }
    FormData formData;
    if(listOfData['National ID'] == ''){
      if(_userType =='patient'){
        formData = FormData.fromMap({
          'number': listOfData['Phone number'],
          'address': listOfData['Location'],
          'status': listOfData['materialStatus'],
          'lastName': listOfData['Last name'],
          'firstName': listOfData['First name'],
          'middleName': listOfData['Middle name'],
          'birthDate': birthDate,
          'patientImage': listOfData['UrlImg']!=null?await MultipartFile.fromFile(listOfData['UrlImg'].path, filename:fileName):listOfData['UrlImg'],
          'job': listOfData['Job'],
          'gender': listOfData['gender'],
          'government': government,
        });
      }else{
        formData = FormData.fromMap({
          'number': listOfData['Phone number'],
          'address': listOfData['Location'],
          'status': listOfData['materialStatus'],
          'lastName': listOfData['Last name'],
          'firstName': listOfData['First name'],
          'middleName': listOfData['Middle name'],
          'birthDate': birthDate,
          'bio':listOfData['aboutYouOrBio'],
          'doctorImage': listOfData['UrlImg']!=null?await MultipartFile.fromFile(listOfData['UrlImg'].path, filename:fileName):null,
          'job': listOfData['Job'],
          'gender': listOfData['gender'],
          'government': government,
        'speciality':listOfData['speciatly'],
        });
      }
    }else{
      formData = FormData.fromMap({
        'number': listOfData['Phone number'],
        'address': listOfData['Location'],
        'status': listOfData['materialStatus'],
        'lastName': listOfData['Last name'],
        'firstName': listOfData['First name'],
        'middleName': listOfData['Middle name'],
        'birthDate': birthDate,
        'patientImage': listOfData['UrlImg']!=null?await MultipartFile.fromFile(listOfData['UrlImg'].path, filename:fileName):listOfData['UrlImg'],
        'job': listOfData['Job'],
        'gender': listOfData['gender'],
        'government': government,
        'nationalID': listOfData['National ID'],
      });
    }
      var data = await _netWork.updateData(
          url: 'patient/5ec8a00afa6d9b35d08f0055',
          formData: formData,
          headers: {
            'Authorization': 'Bearer $_token',
          });
      print('data $data');
      return data['message'];
  }
  Future<String> registerClinicDataAndEditing({Map<String, dynamic> listOfClinicData,bool isEditing=false}) async {
    print('clinicDataclinicDataclinicData$clinicData');

    String government = '';
    for (int i = 0; i < governorateList.length; i++) {
      if (listOfClinicData['cliniclocation'].contains(governorateList[i])) {
        government = governorateList[i];
      }
    }
    var data;
    Map<String,dynamic> _clinicData={
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
    if(isEditing){
      data = await _netWork.updateData(
          url: 'clinic/5ec8a43dfa6d9b35d08f005a',
          data: _clinicData,
          headers: {
            'Authorization': 'Bearer $_token',
          });
      print('data $data');
    }else{
      data = await _netWork.postData(
          url: 'clinic/',
          data: _clinicData,
          headers: {
            'Authorization': 'Bearer $_token',
          });
      print('data $data');

    }
    //'aboutYou': listOfData['aboutYouOrBio'],
//       'lat': listOfData['lat'],
//       'long': listOfData['long'],
      return data['message'];
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
    print(dataToSignIn['userId']);
    _userId = dataToSignIn['userId'];
    _userType =dataToSignIn['userType'];
    await signIn(
        password: dataToSignIn['password'],
        email: dataToSignIn['email'],);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId =null;
    _signInAndUpModel =null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
}
