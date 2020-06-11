import 'package:healthbook/models/register_user_data.dart';

class DoctorAppointment{
  String appointmentId;
  String appointStart;
  String appointEnd;
  String appointDate;
  String appointStatus;
  RegisterData registerData;
  DoctorAppointment(
      {this.appointStart,
        this.appointEnd,
        this.appointmentId,
        this.appointDate,
        this.appointStatus,
        this.registerData});
  DoctorAppointment.fromJson(Map<String, dynamic> json,Map<String,dynamic> patientData){
    appointmentId=json['_id'];
    appointStart = json['appointStart'];
    appointEnd = json['appointEnd'];
    appointDate = json['appointDate'];
    appointStatus = json['appointStatus'];
    registerData =RegisterData.fromJson(patientData, 'patient');
  }
}