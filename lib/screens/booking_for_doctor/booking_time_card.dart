import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/booking_time.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class BookingInfoCard extends StatefulWidget {
   final bool showBookingTime;List<BookingTime> bookingTime=[];
  final int indexForSearchResult;
  BookingInfoCard({this.indexForSearchResult,this.showBookingTime=false,this.bookingTime});

  @override
  _BookingInfoCardState createState() => _BookingInfoCardState();
}

class _BookingInfoCardState extends State<BookingInfoCard> {
  bool _showBookingInfo = false;
  Auth _auth;
Widget _createBookingTime({int index,TextStyle textStyle}){
  return InkWell(
    onTap: widget.showBookingTime?null :widget.bookingTime[index].isAvailable?(){
       showDialog(
         context: context,
         builder: (ctx) => AlertDialog(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(25.0))),
           contentPadding: EdgeInsets.only(top: 10.0),
           title: Text(
             'Are you sure want to book on',
             textAlign: TextAlign.center,
           ),
           content: Container(
             height: 50,
             child: Column(
               children: <Widget>[
                  SizedBox(height: 10,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text(
                       '${ DateFormat('EEEE').format(DateTime.now())} , ${widget.bookingTime[index].time} o\'clock ',
                       style: TextStyle(
                           color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
               ],
             ),
           ),
           actions: <Widget>[
             FlatButton(
               child: Text('Ok',style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
               onPressed: () async{
                bool x =  await _auth.patientReservationInDoctor(
                 appointStart: widget.bookingTime[index].time,
                    index: widget.indexForSearchResult
                );
                if(x==true){
                  Toast.show('Scufully Booking', context);
                  setState(() {
                    widget.bookingTime[index].isAvailable = false;
                  });
                  Navigator.of(ctx).pop();
                }else{
                  Toast.show('Please Try again', context);
                }
               },
             ),
             FlatButton(
               child: Text('Cancel',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
               onPressed: () {
                 setState(() {
                   widget.bookingTime[index].isAvailable = true;
                 });
                 Navigator.of(ctx).pop();
               },
             )
           ],
         ),
       );

    }:null,
    child: Container(
      decoration: BoxDecoration(
          color: widget.bookingTime[index].isAvailable?Colors.blue:Colors.grey,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          '${widget.bookingTime[index].time}',
          style: textStyle.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}
  @override
  void initState() {
    _auth = Provider.of<Auth>(context,listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context,infoWidget){
        return Padding(
          padding: EdgeInsets.only(top: infoWidget.defaultVerticalPadding*1.5),
          child: Material(
            shadowColor: Colors.blueAccent,
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            type: MaterialType.card,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      setState(() {
                        _showBookingInfo = !_showBookingInfo;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(),
                          Text("Today",
                              style: infoWidget.titleButton.copyWith(color: Colors.black)),
                          Icon(
                            _showBookingInfo
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.065:infoWidget.screenWidth*0.049,
                          ),
                        ],
                      ),
                    )),
                _showBookingInfo
                    ? Divider(
                  color: Colors.grey,
                  height: 4,
                )
                    : SizedBox(),
                _showBookingInfo
                    ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 15, right: 15, top: 6.0),
                    child: Container(
                      //width: double.infinity,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.bookingTime == null ?0:widget.bookingTime.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: infoWidget.orientation==Orientation.portrait?3:4.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          itemBuilder: (ctx, index) => widget.bookingTime == null || widget.bookingTime.length == 0?Padding(padding: EdgeInsets.all(8.0),child: Text('there is no any booking time',style: infoWidget.subTitle,),):_createBookingTime(index: index,textStyle: infoWidget.subTitle)),
                    ))
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
