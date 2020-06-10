import 'package:healthbook/providers/auth_controller.dart';

class RegisterPatientData{
  String firstName;
  String middleName;
  String lastName;
  String birthDate;
  String gender;
  String nationalID;
  String email;
  String job;
  String status;
  String number;
  String address;
  String government;
  String patientImage;
  String aboutYou;
  String speciality;

  RegisterPatientData({this.speciality,
    this.firstName, this.middleName, this.lastName, this.birthDate,
    this.gender, this.nationalID, this.email, this.job, this.status,
    this.number, this.address, this.government, this.patientImage,
    this.aboutYou
});
  RegisterPatientData.fromJson(Map<String, dynamic> json){
     nationalID= json['nationalID'];
     firstName= json['firstName'];
     middleName= json['middleName'];
     lastName= json['lastName'];
     birthDate= json['birthDate'];
     gender= json['gender'];
     email= json['email'];
     job= json['job'];
     status= json['status'];
     number= json['number'][0];
     address= json['address'];
     government= json['government'];
     patientImage= json['patientImage'];
     aboutYou= json['aboutYou'];
     if( Auth().getUserType == 'doctor'){
       speciality =json['speciality']??'';
     }
     print(firstName);print(gender);print(address);print(birthDate);print(middleName);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['number'] = this.number;
    data['address'] = this.address;
    data['status'] = this.status;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['birthDate'] = this.birthDate;
    data['patientImage']=this.patientImage;
    data['job'] = this.job;
    data['aboutYou'] = this.aboutYou;
    data['gender'] = this.gender;
    data['government'] = this.government;
    data['nationalID'] = this.nationalID;
    if( Auth().getUserType == 'doctor'){
      data['speciality']=this.speciality??'';
    }
    return data;
  }
}

class RegisterDoctorData{
  String firstName;
  String middleName;
  String lastName;
  String birthDate;
  String gender;
  String nationalID;
  String email;
  String job;
  String status;
  String number;
  String address;
  String government;
  String doctorImage;
  String bio;
  String speciality;
  RegisterDoctorData({
    this.firstName, this.middleName, this.lastName, this.birthDate,
    this.gender, this.nationalID, this.email, this.job, this.status,
    this.number, this.address, this.government, this.doctorImage,
    this.bio,this.speciality
  });
  RegisterDoctorData.fromJson(Map<String, dynamic> json){
    nationalID= json['nationalID'];
    firstName= json['firstName'];
    middleName= json['middleName'];
    lastName= json['lastName'];
    birthDate= json['birthDate'];
    gender= json['gender'];
    email= json['email'];
    job= json['job'];
    status= json['status'];
    number= json['number'][0];
    address= json['address'];
    government= json['government'];
    doctorImage= json['doctorImage'];
    bio= json['bio'];
    speciality =json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['number'] = this.number;
    data['address'] = this.address;
    data['status'] = this.status;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['birthDate'] = this.birthDate;
    data['job'] = this.job;
    data['bio'] = this.bio;
    data['doctorImage']=this.doctorImage;
    data['gender'] = this.gender;
    data['government'] = this.government;
    data['nationalID'] = this.nationalID;
    data['speciality']=this.speciality ;
    return data;
  }
}