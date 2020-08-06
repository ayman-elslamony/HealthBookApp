import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:healthbook/models/appointment_reservation.dart';
import 'package:healthbook/models/booking_time.dart';
import 'package:healthbook/models/doctor_appointment.dart';
import 'package:healthbook/models/patient_appointment.dart';
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
  static List<DoctorAppointment> appointmentForDoctor=[];
  static List<PatientAppointment> appointmentForPatient=[];
  List<SearchResult> _searchResult=[];
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
  List<SearchResult> get searchResult{

    return _searchResult;
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
    var appointmentData;
    print('Iam Here _userType$_userType');
    if(_userType=='doctor'){
      appointmentData = await _netWork
          .getData(url:'appoint/appoint-doctor/$_userId', headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      isAppoitment: true);
      print('appointmentData$appointmentData');
      if(appointmentData.length !=0){
        List<DoctorAppointment> allAppointment=[];
        var userData = await _netWork
            .getData(url: 'patient/5ee3df2ef8ae63001735e985', headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFobWVkMTJAZ21haWwuY29tIiwiX2lkIjoiNWVlM2RmMmVmOGFlNjMwMDE3MzVlOTg1Iiwicm9sZSI6MiwiaWF0IjoxNTk2NTgwNjExfQ.D6HjAxcZraIEQlPEtG0jVbKrqT5dRiaW5dbuf7yJaCU',
        });
        for(int i=0; i<appointmentData.length; i++){
          print(appointmentData[i]['patientID']);
          allAppointment.add(DoctorAppointment.fromJson(appointmentData[i],userData['patient']));
        }
        appointmentForDoctor =allAppointment;
        notifyListeners();
      }
    }else {
      appointmentData = await _netWork
          .getData(url: 'appoint/appoint-patient/$_userId', headers: {
        'Authorization': 'Bearer $_token',
      },
      isAppoitment: true);
//      appointmentForPatient.add(PatientAppointment(
//        appointDate: '2/3/2020',
//        appointStart: '12:30',
//        appointEnd: '1',
//        appointmentId: '798956',
//        appointStatus: 'not',
//        registerData: RegisterData(
//         firstName: 'Ayman',
//         middleName: 'Kamel',
//         lastName: 'Elslamony',
//         number: '01145523795',
//         status: 'not',
//         job: 'Doctor',
//         government: 'Mansoura',
//         gender: 'Male',
//         birthDate: '12/5/2020',
//         aboutYou: 'iam doctor',
//         address: 'man man man ',
//         speciality: 'doc',
//         doctorImage: 'https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png'
//        ),
//        clinicData: ClinicData(
//          address: 'clinic address',
//          government: 'clinic Mansorra',
//          number: '20252103584',
//          clinicName: 'clinic',
//          doctorID: '2316513',
//          fees: '20',
//          openingTime: '12:10',
//          clossingTime: '15:1',
//          waitingTime: '15',
//workingDays: ['sat','mon','thur'],
//        )
//      ));
      print('appointmentDataappointmentData$appointmentData');
      print(appointmentData);
      if(appointmentData.length !=0){
        List<PatientAppointment> allAppointment=[];
        var userData = await _netWork
            .getData(url: 'doctor/5ec8a319fa6d9b35d08f0058', headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IncyQHcuY29tIiwiX2lkIjoiNWVjOGEzMTlmYTZkOWIzNWQwOGYwMDU4Iiwicm9sZSI6MCwiaWF0IjoxNTk2NTkxNDc3fQ.LqPY6GQV3hsFtSI4EjTKjub1-7ADFKf45Vt3SG-ubxg',
        });
        print(userData);
        for(int i=0; i<appointmentData.length; i++){
          var clinicData = await _netWork
              .getData(url: 'clinic/${appointmentData[i]['clinicID']}', headers: {
            'Authorization': 'Bearer $_token',
          });
          print(clinicData);
          allAppointment.add(PatientAppointment.fromJson(appointmentData[i], userData['doctor'], clinicData['clinic']));
        }
        appointmentForPatient = allAppointment;
        notifyListeners();
      }
    }

  }

  Future<bool> deleteAppointmentForPatAndDoc({@required String appointmentId,String type='doctor'})async{
    try{
      var appointmentData;
      if(type == 'doctor'){
        appointmentData = await _netWork
            .deleteAppointment(url:'appoint/appoint-doctor/$appointmentId', headers: {
          'Authorization': 'Bearer $_token',
        },);
      }else{
        appointmentData = await _netWork
            .deleteAppointment(url:'appoint/appoint-patient/$appointmentId', headers: {
          'Authorization': 'Bearer $_token',
        },);
      }
      print(appointmentData);
        if(appointmentData['message']== 'Appoint deleted' && type == 'doctor'){
          appointmentForDoctor.removeWhere((appointment)=>appointment.appointmentId==appointmentId);
        }
      if(appointmentData['message']== 'Appoint deleted' && type == 'patient'){
        appointmentForPatient.removeWhere((appointment)=>appointment.appointmentId==appointmentId);
      }
      notifyListeners();
      return appointmentData['message']== 'Appoint deleted'?true:false;
    }catch(e){
      print(e);
      return false;
    }
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

  Future<void> getAllSearchResult()async{
    var userData = await _netWork
        .getData(url: 'doctor/5ec8a319fa6d9b35d08f0058', headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IncyQHcuY29tIiwiX2lkIjoiNWVjOGEzMTlmYTZkOWIzNWQwOGYwMDU4Iiwicm9sZSI6MCwiaWF0IjoxNTk2NTkxNDc3fQ.LqPY6GQV3hsFtSI4EjTKjub1-7ADFKf45Vt3SG-ubxg',
    });
    print(userData);
    var clinicData = await _netWork
        .getData(url: 'clinic/5ed6899e7966c600175a388b', headers: {
      'Authorization': 'Bearer $_token',
    });
    print(clinicData);
    List<SearchResult> result=[];
    result.add(SearchResult.fromJson(userData['doctor'], clinicData['clinic']));
    _searchResult=result;
    notifyListeners();
  }

Future<List<Appointment>> availableTime({String clinicId})async{
  List<Appointment> allAppointment=[];
    var appointmentData;
    appointmentData = await _netWork
        .getData(url:'appoint/appoint-clinic/$clinicId', headers: {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    },
        isAppoitment: true);
    print('appointmentData$appointmentData');
    if(appointmentData.length !=0){
      for(int i=0; i<appointmentData.length; i++){
        allAppointment.add(Appointment.fromJson(appointmentData[i]));
      }

    }
    print('allAppointment${allAppointment.length}');
    return allAppointment;
}
Future<bool> patientReservationInDoctor({String appointStart,int index})async{
  var appointmentData;
  DateTime dateTime= DateTime.now();
 try{
   int time;
   if(appointStart.contains(':')){
     List<String> splitTime = appointStart.split(':');
      time= int.parse(splitTime[0])*60+int.parse(splitTime[1]);
   }else{
      time = int.parse(appointStart);
   }
   time =time+int.parse(_searchResult[index].clinicData.waitingTime);
   int hour = time ~/ 60;
   int minutes = time % 60;
   appointmentData = await _netWork
       .postData(url:'appoint/', headers: {
     'Authorization': 'Bearer $_token',
   },
       data: {'appointStart' : appointStart,'appointEnd' : '${minutes==0?'$hour':'$hour:$minutes'}','appointDate' :'${dateTime.day}-${dateTime.month}-${dateTime.year}','appointStatus' : 'none','doctorID' : _searchResult[index].doctorData.id,"patientID" : _userId,'clinicID': _searchResult[index].clinicData.sId}
   );
   print(appointmentData);
   return appointmentData['message']=='Appointement created'?true:false;
 }catch (e){
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
