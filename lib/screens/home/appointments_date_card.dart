import 'package:flutter/material.dart';
import 'package:healthbook/core/models/device_info.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:provider/provider.dart';

class AppointmentsDateCard extends StatefulWidget {

  AppointmentsDateCard();

  @override
  _AppointmentsDateCardState createState() => _AppointmentsDateCardState();
}

class _AppointmentsDateCardState extends State<AppointmentsDateCard> {
  bool _isAppointmentsDateSelected = false;
  String _appointmentsDate;
  Auth _auth;
 List<String> _listDate =['Yesterday','Today','Tomorrow'];
 @override
  void initState() {
   _auth =Provider.of<Auth>(context, listen: false);
    super.initState();
  }
  Widget body(Auth appointements,DeviceInfo infoWidget){
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: <Widget>[
       Material(
         shadowColor: Colors.blueAccent,
         elevation: 2.0,
         borderRadius: BorderRadius.all(Radius.circular(10)),
         type: MaterialType.card,
         child: Padding(
           padding: infoWidget.orientation==Orientation.portrait?EdgeInsets.only(left: 10):EdgeInsets.all(10),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text(
                 "Date:",
                 style: infoWidget.titleButton.copyWith(color: Colors.black87)
               ),
               Padding(
                 padding: EdgeInsets.only(left: infoWidget.defaultHorizontalPadding),
                 child: Text(
                   _isAppointmentsDateSelected == false?"Today":_appointmentsDate,
                   maxLines: 1,
                   textAlign: TextAlign.justify,
                   overflow: TextOverflow.ellipsis,
                   style: infoWidget.titleButton.copyWith(color: Colors.black87)
                 ),
               ),
               PopupMenuButton(
                 tooltip: 'Select Date',
                 padding: EdgeInsets.all(0.0),
                 elevation: 5.0,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                 itemBuilder: (ctx)=>_listDate
                     .map((String val) => PopupMenuItem<String>(
                   value: val,
                   child: Center(child: Text(val,style: infoWidget.subTitle,)),
                 ))
                     .toList(),
                 onSelected: (String val) {
                   setState(() {
                     _appointmentsDate = val;
                     _isAppointmentsDateSelected = true;
                   });
                 },
                 icon: Icon(
                   Icons.keyboard_arrow_down,
                   size: infoWidget.screenWidth*0.077,
                 ),
               ),
             ],
           ),
         ),
       ),
       Padding(
         padding:  EdgeInsets.only(right: infoWidget.defaultHorizontalPadding),
         child: Text(
             _auth.getUserType=='doctor'?'${appointements.allAppointment.length ==0?'No':appointements.allAppointment.length} Patient':"${appointements.allAppointmentOfPatient.length ==0?'No':appointements.allAppointmentOfPatient.length} Appointement",
             maxLines: 1,
             textAlign: TextAlign.justify,
             overflow: TextOverflow.ellipsis,
             style: infoWidget.subTitle.copyWith(color: Colors.blue)
         ),
       )
     ],
   );
  }
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context,infoWidget){
       return Padding(
         padding: EdgeInsets.all(
             infoWidget.defaultHorizontalPadding),
         child: Consumer<Auth>(
             builder: (context,appointements,_){
               if(_auth.getUserType == 'doctor'){
                 if(appointements.allAppointment.length ==0){
                   return SizedBox();
                 }else{
                   return body(appointements,infoWidget);
                 }
               }else{
                 if(appointements.allAppointmentOfPatient.length==0){
                   return SizedBox();
                 }else{
                   return body(appointements,infoWidget);
                 }
               }
             }
         ),
       );
      },
    );
  }
}
