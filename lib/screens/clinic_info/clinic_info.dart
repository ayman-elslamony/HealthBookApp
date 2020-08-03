import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/screens/booking_for_doctor/booking_time_card.dart';
import 'package:healthbook/screens/clinic_info/edit_clinic.dart';

class ClinicInfo extends StatefulWidget {
  @override
  _ClinicInfoState createState() => _ClinicInfoState();
}

class _ClinicInfoState extends State<ClinicInfo> {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, infoWidget) {
        return Padding(
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
                    BookingInfoCard(showBookingTime: true),
                  ],
                ),
                Positioned(
                  child: FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditClinic()));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: infoWidget.orientation == Orientation.portrait
                          ? infoWidget.screenWidth * 0.06
                          : infoWidget.screenWidth * 0.049,
                    ),
                    label: Text(
                      'Edit Clinic Info',
                      style: infoWidget.titleButton,
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  right: 0.0,
                  left: 0.0,
                  bottom: 0.0,
                )
              ],
            ));
      },
    );
  }
}
