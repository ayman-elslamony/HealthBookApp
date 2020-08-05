import 'package:healthbook/providers/auth_controller.dart';

class RegisterData{
  String id;
  String firstName;
  String middleName;
  String lastName;
  String birthDate;
  String gender;

  String job;
  String status;
  String number;
  String address;
  String government;
  String patientImage;
  String aboutYou;
  String speciality;
  String doctorImage;

  RegisterData({this.id,this.speciality,this.doctorImage,
    this.firstName, this.middleName, this.lastName, this.birthDate,
    this.gender, this.job, this.status,
    this.number, this.address, this.government, this.patientImage,
    this.aboutYou
});
  RegisterData.fromJson(Map<String, dynamic> json,String userType){
    print(json['firstName']);
    // nationalID= json['nationalID'];
    id = json['_id']??'';
     firstName= json['firstName']??'';
     middleName= json['middleName']??'';
     lastName= json['lastName']??'';
     birthDate= json['birthDate']??'';
     gender= json['gender']??'';
     job= json['job']??'';
     status= json['status']??'';
     address= json['address']??'';
     government= json['government']??'';
     print('bvdbcfnnbfnbf nf nfn');
     if(userType == 'doctor'){
       speciality =json['speciality']??'';
       doctorImage = json['doctorImage']??'';
       aboutYou =json['bio']??'';
       number= json['number'] ==null ?'':json['number'][0];
     }else{
       number= json['phone'] ==null ?'':json['phone'][0];
       patientImage= json['patientImage']??'';
       aboutYou= json['aboutYou']??'';
     }
  }

  Map<String, dynamic> toJson(String userType) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id']=this.id;
    data['number'] = [this.number];
    data['address'] = this.address;
    data['status'] = this.status;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['birthDate'] = this.birthDate;
    data['job'] = this.job;
    data['gender'] = this.gender;
    data['government'] = this.government;
    if( userType == 'doctor'){
      data['speciality']=this.speciality??'';
      data['doctorImage']=this.doctorImage;
      data['bio']=this.aboutYou;
    }else{
      data['patientImage']=this.patientImage;
      data['aboutYou'] = this.aboutYou;
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