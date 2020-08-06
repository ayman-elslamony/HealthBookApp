import 'clinic_data.dart';
import 'user_data.dart';

class SearchResult{
  RegisterData doctorData;
  ClinicData clinicData;

  SearchResult({this.doctorData, this.clinicData});

  SearchResult.fromJson(Map<String,dynamic> doctor,Map<String,dynamic> clinic)
  {
    this.clinicData =ClinicData.fromJson(clinic);
    this.doctorData =RegisterData.fromJson(doctor, 'doctor');
  }

}