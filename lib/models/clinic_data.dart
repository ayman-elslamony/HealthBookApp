class ClinicData {
  String clinicName;
  String waitingTime;
  List workingDays;
  String openingTime;
  String clossingTime;
  String number;
  String government;
  String address;
  String fees;
  String doctorID;

  ClinicData(
      {this.clinicName,
        this.waitingTime,
        this.workingDays,
        this.openingTime,
        this.clossingTime,
        this.number,
        this.government,
        this.address,
        this.fees,
        this.doctorID});

  ClinicData.fromJson(Map<String, dynamic> json) {
    print('json[workingDays].runtimeType${json['workingDays'].runtimeType}');

    json.values.forEach((x){
      print('$x + ${x.runtimeType}');
    });
    clinicName = json['clinicName']??'';
    waitingTime = json['waitingTime']??'';
    openingTime = json['openingTime']??'';
    clossingTime = json['clossingTime']??'';
    number = json['number'].length==0?'':json['number'][0];
    government = json['government']??'';
    address = json['address']??'';
    fees = json['fees']??'';
    doctorID = json['doctorID']??'';
    var x =  json['workingDays'];
    print(x.runtimeType);
    workingDays = json['workingDays'].toList()??[];
    print('ffffffffffffffffffffff');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicName'] = this.clinicName;
    data['waitingTime'] = this.waitingTime;
    data['workingDays'] = this.workingDays;
    data['openingTime'] = this.openingTime;
    data['clossingTime'] = this.clossingTime;
    data['number'] = [this.number];
    data['government'] = this.government;
    data['address'] = this.address;
    data['fees'] = this.fees;
    data['doctorID'] = this.doctorID;
    return data;
  }
}