import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/register_user_data.dart';

class PatientAppointment{
  String appointmentId;
  String appointStart;
  String appointEnd;
  String appointDate;
  String appointStatus;
  RegisterData registerData;
  ClinicData clinicData;
  PatientAppointment(
      {this.appointStart,
        this.appointmentId,
        this.appointEnd,
        this.appointDate,
        this.appointStatus,
        this.clinicData,
        this.registerData});
  PatientAppointment.fromJson(Map<String, dynamic> json,Map<String,dynamic> doctorData,Map<String,dynamic> clinic){
    appointmentId=json['_id'];
    appointStart = json['appointStart'];
    appointEnd = json['appointEnd'];
    appointDate = json['appointDate'];
    appointStatus = json['appointStatus'];
    clinicData =ClinicData.fromJson(clinic);
    registerData =RegisterData.fromJson(doctorData, 'doctor');
  }
}