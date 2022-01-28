class Appointment {
  String appointStart;
  String appointEnd;
  String appointDate;
  String appointStatus;
  String doctorID;
  String patientID;
  String clinicID;

  Appointment(
      {this.appointStart,
        this.appointEnd,
        this.appointDate,
        this.appointStatus,
        this.doctorID,
        this.patientID,
        this.clinicID});

  Appointment.fromJson(Map<String, dynamic> json) {
    appointStart = json['appointStart'];
    appointEnd = json['appointEnd'];
    appointDate = json['appointDate'];
    appointStatus = json['appointStatus'];
    doctorID = json['doctorID'];
    patientID = json['patientID'];
    clinicID = json['clinicID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointStart'] = this.appointStart;
    data['appointEnd'] = this.appointEnd;
    data['appointDate'] = this.appointDate;
    data['appointStatus'] = this.appointStatus;
    data['doctorID'] = this.doctorID;
    data['patientID'] = this.patientID;
    data['clinicID'] = this.clinicID;
    return data;
  }
}