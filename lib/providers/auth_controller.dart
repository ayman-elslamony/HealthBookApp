import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:healthbook/models/appointment.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/models/patient_appointment.dart';
import 'package:path/path.dart';
import 'package:healthbook/list_of_infomation/list_of_information.dart';
import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/register_user_data.dart';
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
      {String email, String password,bool isCommingFromSignUp =false}) async {
    print(email);
    print(password);
    var data = await _netWork.postData(
      url: '$_userType/login',
      headers: {'Content-Type': 'application/json'
      },
      data: {'email':email.trim(),'password':password.trim()},
    );
    if (data['message'] == 'Auth success') {
      _token = data['token'];
      _userId=data['_id'];
      _email = email.trim();
//      print(_token);
//      print(_userId);
      final prefs = await SharedPreferences.getInstance();
      if(!prefs.containsKey('dataToSignIn')){
        final dataToSignIn = json.encode({
          'email': email.trim(),
          'password': password.trim(),
          'userType': _userType,
        });
        prefs.setString('dataToSignIn', dataToSignIn);
      }
      if(isCommingFromSignUp == false){
        await getUserData();
      }
    }
    return data['message'];
  }
  Future<String> signUp({String email, String password,String nationalID}) async {
    _userType = 'patient';
    var data = await _netWork.postData(
      url: 'patient/signup',
      headers: {'Content-Type': 'application/json'},
      data: {
        'email': email,
        'password':password,
        'nationalID':nationalID,
      },
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
          .getData(url: 'doctor/$_userId', headers: {
        'Authorization': 'Bearer $_token',
      });
    }else{
      userData = await _netWork
          .getData(url: 'patient/$_userId', headers: {
        'Authorization': 'Bearer $_token',
      });
    }
//    print(userData);
    print(userData['patient']);
    if (userData['patient'] != null && _userType =='patient') {
      print('A');
      rgisterData=RegisterData.fromJson(userData['patient'],'patient');
      print('B');
      print(rgisterData);
//      print(rgisterData.firstName);
//      print(rgisterData.birthDate);
      print('rgisterData.numberrgisterData.number${rgisterData.number}');
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
      print('dataForClinicdataForClinicdataForClinic$dataForClinic');
      if(dataForClinic['clinic'] !=null){
        clinicData = ClinicData.fromJson(dataForClinic['clinic']);
        print(clinicData);
      }
      return ;
    }

  }
  Future<void>  getUserAppointment()async{
//    var appointmentData;
//    print('_userType_userType$_userType');
    if(_userType=='doctor'){
//      appointmentData = await _netWork
//          .getData(url: 'appoint/appoint-doctor/$_userId', headers: {
//        'Authorization': 'Bearer $_token',
//      });
//      print(appointmentData);
//      if(appointmentData.length !=0){
//        List<DoctorAppointment> allAppointment=[];
//        var userData = await _netWork
//            .getData(url: 'patient/5ec8a00afa6d9b35d08f0055', headers: {
//          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImEyQGEuY29tIiwiX2lkIjoiNWVjOGEwMGFmYTZkOWIzNWQwOGYwMDU1Iiwicm9sZSI6MiwiaWF0IjoxNTkwMjA2OTE2fQ.70AORnaarGm_o90xD4frGOXWRP_PMHJCWxhmNRL48Qw',
//        });
//        for(int i=0; i<appointmentData['appoint'].length; i++){
//          print(appointmentData['appoint'][i]['patientID']);
//          allAppointment.add(DoctorAppointment.fromJson(appointmentData['appoint'][i],userData['patient']));
//        }
//        appointmentForDoctor =allAppointment;
      appointmentForDoctor.add(DoctorAppointment(
        registerData: RegisterData(
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
            patientImage: 'https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png'
        ),
        appointDate: '2/3/2020',
        appointStart: '12:30',
        appointEnd: '1',
        appointmentId: '798956',
        appointStatus: 'not',
      ));
        notifyListeners();
//      }
    }else{
//      appointmentData = await _netWork
//          .getData(url: 'appoint/appoint-patient/$_userId', headers: {
//        'Authorization': 'Bearer $_token',
//      });
      appointmentForPatient.add(PatientAppointment(
        appointDate: '2/3/2020',
        appointStart: '12:30',
        appointEnd: '1',
        appointmentId: '798956',
        appointStatus: 'not',
        registerData: RegisterData(
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
         doctorImage: 'https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png'
        ),
        clinicData: ClinicData(
          address: 'clinic address',
          government: 'clinic Mansorra',
          number: '20252103584',
          clinicName: 'clinic',
          doctorID: '2316513',
          fees: '20',
          openingTime: '12:10',
          clossingTime: '15:1',
          waitingTime: '15',
workingDays: ['sat','mon','thur'],
        )
      ));
    }
   // print('appointmentDataappointmentData$appointmentData');




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
    print(listOfData);
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
    print(listOfData['UrlImg']);
    print(listOfData['Phone number']);
    if(listOfData['UrlImg'].runtimeType != File){
      if (listOfData['UrlImg'] != null &&
          listOfData['UrlImg'].path != null &&
          listOfData['UrlImg'].path.isNotEmpty) {
        fileName = listOfData['UrlImg'].path.split('/').last;
        print("File Name : $fileName");
        print("File Size : ${listOfData['UrlImg'].lengthSync()}");
      }
    }

    print(listOfData['Phone number'].runtimeType);
    FormData formData;
      if(_userType =='patient'){
        formData = FormData.fromMap({
          'phone': listOfData['Phone number'],
          'address': listOfData['Location'],
          'status': listOfData['materialStatus'],
          'lastName': listOfData['Last name'],
          'firstName': listOfData['First name'],
          'middleName': listOfData['Middle name'],
          'birthDate': birthDate,
          'patientImage': listOfData['UrlImg']!=null &&listOfData['UrlImg'].runtimeType != File?await MultipartFile.fromFile(listOfData['UrlImg'].path, filename:fileName):listOfData['UrlImg'],
          'job': listOfData['Job'],
          'gender': listOfData['gender'],
          'government': government,
        });
      }else {
        formData = FormData.fromMap({
          'number': listOfData['Phone number'],
          'address': listOfData['Location'],
          'status': listOfData['materialStatus'],
          'lastName': listOfData['Last name'],
          'firstName': listOfData['First name'],
          'middleName': listOfData['Middle name'],
          'birthDate': birthDate,
          'bio': listOfData['aboutYouOrBio'],
          'doctorImage': listOfData['UrlImg'] != null &&!listOfData['UrlImg'].contains('https:')? await MultipartFile
              .fromFile(listOfData['UrlImg'].path, filename: fileName) : null,
          'job': listOfData['Job'],
          'gender': listOfData['gender'],
          'government': government,
          'speciality': listOfData['speciatly'],
        });
      }

    var data;
    if(_userType =='patient') {
      data = await _netWork.updateData(
          url: 'patient/$_userId',
          formData: formData,
          headers: {
            'Authorization': 'Bearer $_token',
          });
    }else{
      data = await _netWork.updateData(
          url: 'doctor/$_userId',
          formData: formData,
          headers: {
            'Authorization': 'Bearer $_token',
          });
      }
      print('data $data');
    if(data !=null){
      rgisterData=RegisterData.fromJson(data,'patient');
      return 'success';
    }else{
      return 'failed';
    }
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
    _email =null;
    _userType = 'patient';
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print('fbnfnfnf');
  }
}
