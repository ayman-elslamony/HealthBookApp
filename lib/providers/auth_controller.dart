import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:healthbook/list_of_infomation/list_of_information.dart';
import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/register_user_data.dart';
import 'package:healthbook/models/sign_in_and_up.dart';
import 'package:healthbook/services/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  NetWork _netWork = NetWork();
  SignInAndUp _signInAndUpModel;
  static String _token;
  static String _userId;
  String _email;
  String _userType = 'patient';
  static RegisterPatientData rgisterPatientData;
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
  RegisterPatientData get userData{
    return rgisterPatientData;
  }
  ClinicData get getClinicData{
    return clinicData;
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
Future<void>  getUserData()async{
    var userData = await _userType=='doctor'? _netWork
        .getData(url: 'doctor/5ec8a319fa6d9b35d08f0058', headers: {
      'Authorization': 'Bearer $_token',
    }):await _netWork
        .getData(url: 'patient/5ec8a00afa6d9b35d08f0055', headers: {
      'Authorization': 'Bearer $_token',
    });
    print(userData['patient']);
    if (userData['patient'] != null) {
      rgisterPatientData=RegisterPatientData.fromJson(userData['patient']);
      print(rgisterPatientData.gender);
      print(rgisterPatientData.birthDate);
      print(rgisterPatientData.address);
    }
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

  Future<bool> registerUserData({Map<String, dynamic> listOfData}) async {
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
    FormData formData;
    if(listOfData['National ID'] == ''){
      formData = FormData.fromMap({
        'number': listOfData['Phone number'],
        'address': listOfData['Location'],
        'status': listOfData['materialStatus'],
        'lastName': listOfData['Last name'],
        'firstName': listOfData['First name'],
        'middleName': listOfData['Middle name'],
        'birthDate': birthDate,
        'patientImage': listOfData['UrlImg'],
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
        'patientImage': listOfData['UrlImg'],
        'job': listOfData['Job'],
        'gender': listOfData['gender'],
        'government': government,
        'nationalID': listOfData['National ID'],
      });
    }

    try {
      var data = await _netWork.updateData(
          url: 'patient/5ec8a00afa6d9b35d08f0055',
          formData: formData,
          headers: {
            'Authorization': 'Bearer $_token',
          });
      print('data $data');
      return true;
    } catch (e) {
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
    print(dataToSignIn['userId']);
    _userId = dataToSignIn['userId'];
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
