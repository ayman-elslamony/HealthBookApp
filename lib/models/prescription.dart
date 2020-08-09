import 'package:healthbook/models/clinic_data.dart';
import 'package:healthbook/models/user_data.dart';

class AddPrescriptions {
  List<String> medicine;
  List<String> dosage;
  String sId;
  String diagnose;
  String diagnoseDesc;
  String date;
  String radioImage;
  String radioDesc;
  String radioName;
  String analysisDesc;
  String analysisName;
  String patientID;
  String doctorID;
  String diagnoNum;
  int iV;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine'] = this.medicine;
    data['dosage'] = this.dosage;
    data['_id'] = this.sId;
    data['diagnose'] = this.diagnose;
    data['diagnoseDesc'] = this.diagnoseDesc;
    data['date'] = this.date;
    data['radioImage'] = this.radioImage;
    data['radioDesc'] = this.radioDesc;
    data['radioName'] = this.radioName;
    data['analysisDesc'] = this.analysisDesc;
    data['analysisName'] = this.analysisName;
    data['patientID'] = this.patientID;
    data['doctorID'] = this.doctorID;
    data['diagnoNum'] = this.diagnoNum;
    data['__v'] = this.iV;
    return data;
  }
}

class DoctorsInEachDosage {
  bool _showDoctor = false;
  set showDoctorSet(bool value) {
    _showDoctor = value;
  }
  bool get showDoctorGet => _showDoctor;

  DoctorsInEachDosage({this.doctorData, this.allPrescription});

  RegisterData doctorData;
  ClinicData clinicData;
  List<Prescription> allPrescription = [];

  DoctorsInEachDosage.fromJson(
      List json, Map<String, dynamic> doctorData,Map<String, dynamic> clinicData,String diagnoseName) {
    this.doctorData = RegisterData.fromJson(doctorData, 'doctor');
      this.clinicData = ClinicData.fromJson(clinicData);
    for(int i=0; i< json.length; i++){
      if(diagnoseName == json[i]['diagnose']){
    this.allPrescription.add(Prescription.fromJson(json[i]));
  }
    }
  }
}

class Prescription {
  String prescriptionNumber;

  Prescription({this.prescriptionNumber, this.prescriptionDate, this.allMedicine,
    this.allDosage, this.radioImage, this.radioDesc, this.radioName,
    this.analysisDesc, this.analysisName,this.diagnoseDescription});
  String diagnoseDescription;
  String prescriptionDate;
  List<String> allMedicine = [];
  List<String> allDosage = [];
  String radioImage;
  String radioDesc;
  String radioName;
  String analysisDesc;
  String analysisName;

  bool _showPrescription = false;
  set showPrescriptionSet(bool value) {
    _showPrescription = value;
  }

  bool get showPrescriptionGet => _showPrescription;
  Prescription.fromJson(Map<String, dynamic> json) {
    this.diagnoseDescription=json['diagnoseDesc']??'';
    this.allMedicine = json['medicine'].length != 0?json['medicine'].cast<String>():[];
    this.prescriptionDate = json['date']??'';
    this.allDosage = json['dosage'].length != 0?json['dosage'].cast<String>():[];
    this.radioImage = json['radioImage']??'';
    this.radioDesc = json['radioDesc']??'';
    this.radioName = json['radioName']??'';
    this.analysisDesc = json['analysisDesc']??'';
    this.analysisName = json['analysisName']??'';
    this.prescriptionNumber = json['diagnoNum']??'';
  }
}

//class ListOfDiagnoseContent {
//  bool _showDiagnose = false;
//
//  set showDiagnoseSet(bool value) {
//    _showDiagnose = value;
//  }
//
//  bool get showDiagnoseGet => _showDiagnose;
//
//  String _diagnoseName;
//  String _patientID;
//  String _id;
//  List<DoctorsInEachDosage> _allDoctorsInEachDosage = [];
//
//  String get diagnoseName => _diagnoseName;
//
//  set diagnoseName(String value) {
//    _diagnoseName = value;
//  }
//
//  String get patientID => _patientID;
//
//  set patientID(String value) {
//    _patientID = value;
//  }
//
//  String get id => _id;
//
//  set id(String value) {
//    _id = value;
//  }
//
//  List<DoctorsInEachDosage> get getAllDoctorsInEachDosage =>
//      _allDoctorsInEachDosage;
//
//  setAllDoctorsInEachDosage(Map<String, dynamic> json,Map<String, dynamic> doctorData) {
//    _allDoctorsInEachDosage.add(DoctorsInEachDosage.fromJson(json, doctorData));
//  }
//
//}
