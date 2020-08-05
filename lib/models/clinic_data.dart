class ClinicData {
  List<String> workingDays;
  List<String> number;
  String sId;
  String clinicName;
  String waitingTime;
  String openingTime;
  String clossingTime;
  String address;
  String government;
  String fees;

  ClinicData(
      {this.workingDays,
        this.number,
        this.sId,
        this.clinicName,
        this.waitingTime,
        this.openingTime,
        this.clossingTime,
        this.address,
        this.government,
        this.fees});

  ClinicData.fromJson(Map<String, dynamic> json) {
    workingDays = json['workingDays']==null?['']:json['workingDays'].cast<String>();
    number = json['number']==null?['']:json['number'].cast<String>();
    sId = json['_id'];
    clinicName = json['clinicName'];
    waitingTime = json['waitingTime'];
    openingTime = json['openingTime'];
    clossingTime = json['clossingTime'];
    address = json['address'];
    government = json['government'];
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workingDays'] = this.workingDays;
    data['number'] = this.number;
    data['_id'] = this.sId;
    data['clinicName'] = this.clinicName;
    data['waitingTime'] = this.waitingTime;
    data['openingTime'] = this.openingTime;
    data['clossingTime'] = this.clossingTime;
    data['address'] = this.address;
    data['government'] = this.government;
    data['fees'] = this.fees;
    return data;
  }
}