import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/appointment_reservation.dart';
import 'package:healthbook/models/booking_time.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/booking_for_doctor/booking_time_card.dart';
import 'package:healthbook/screens/clinic_info/edit_clinic.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ClinicInfo extends StatefulWidget {
  @override
  _ClinicInfoState createState() => _ClinicInfoState();
}

class _ClinicInfoState extends State<ClinicInfo> {
  Auth _auth;
  List<BookingTime> bookingTime=[];
  DateTime _dateTime;
  bool isBookingTimeLoading =true;
  @override
  void initState() {
    _dateTime =DateTime.now();
    _auth = Provider.of<Auth>(context, listen: false);
    getBookingTimeAvailable();
    super.initState();
  }
  getBookingTimeAvailable()async{
    List<Appointment> appointment= await _auth.availableTime(clinicId: _auth.getClinicData.sId);
    bookingTime.clear();
    for(int i = int.parse(_auth.getClinicData.openingTime); i<  int.parse(_auth.getClinicData.clossingTime); i++){
      var time = i*60 + 15;
      var hour = time ~/ 60;
      var minutes = time % 60;
      bookingTime.add(BookingTime('${minutes==0?'$hour':'$hour:$minutes'}', true));
      for(int x =0; x < 60/15; x++){
        time = time + 15;
        var hour = time ~/ 60;
        var minutes = time % 60;
        bookingTime.add(BookingTime('${minutes==0?'$hour':'$hour:$minutes'}', true));
      }
    }
    for(int i=0; i<appointment.length; i++) {
      if (appointment[i].appointDate == '${_dateTime.day}-${_dateTime.month}-${_dateTime.year}'){
        print('appointment[i].appointStart${appointment[i].appointStart}');
        for(int x=0; x<bookingTime.length;x++){
          if(bookingTime[x].time == appointment[i].appointStart){
            bookingTime[x].isAvailable=false;
          }
        }
      }
    }
    setState(() {
      isBookingTimeLoading=false;
    });
    print(bookingTime);
  }
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, infoWidget) {
        return RefreshIndicator(
          onRefresh: ()async{
            _auth.allAppointmentTime=[];
            setState(() {
              isBookingTimeLoading=true;
            });
            getBookingTimeAvailable();
        },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Clinic Booking time: ',
                              style: infoWidget.titleButton.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isBookingTimeLoading?Row(
                        children: <Widget>[
                          Expanded(child: Center(child: Text('Loading booking time ...',style: infoWidget.subTitle,))),
                        ],
                      ):BookingInfoCard(showBookingTime: true,bookingTime: bookingTime,),
                    ],
                  ),
//                Positioned(
//                  child: FlatButton.icon(
//                    onPressed: () {
//                      if(_auth.getClinicData ==null){
//                      Toast.show('You don\'t have clinic',context);
//                      }else{
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => EditClinic()));
//                    }
//                      },
//                    icon: Icon(
//                      Icons.edit,
//                      color: Colors.white,
//                      size: infoWidget.orientation == Orientation.portrait
//                          ? infoWidget.screenWidth * 0.06
//                          : infoWidget.screenWidth * 0.049,
//                    ),
//                    label: Text(
//                      'Edit Clinic Info',
//                      style: infoWidget.titleButton,
//                    ),
//                    color: Colors.blue,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(10))),
//                  ),
//                  right: 0.0,
//                  left: 0.0,
//                  bottom: 0.0,
//                )
                ],
              )),
        );
      },
    );
  }
}
