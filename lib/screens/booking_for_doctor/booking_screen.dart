import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/appointment_reservation.dart';
import 'package:healthbook/models/booking_time.dart';
import 'package:healthbook/models/search_result.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/user_profile/show_profile.dart';
import 'package:provider/provider.dart';

import 'booking_time_card.dart';

class Booking extends StatefulWidget {
  final int index;
  Booking({this.index});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Auth _auth;
  SearchResult _searchResult;
  DateTime _dateTime;
  bool isBookingTimeLoading=true;
  List<BookingTime> bookingTime=[];
  Widget _data({String title, String content,TextStyle textStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                  title + " ",
                  style: textStyle.copyWith(color: Colors.black,fontWeight: FontWeight.w600)
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    content,
                    style:textStyle.copyWith(color: Color(0xff484848),fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
@override
  void initState() {
    _dateTime =DateTime.now();
    _auth = Provider.of<Auth>(context,listen: false);
    _searchResult =_auth.searchResult[widget.index];
    getBookingTimeAvailable();
    super.initState();
  }
  getBookingTimeAvailable()async{
    print('_searchResult.clinicData.sId${_searchResult.clinicData.sId}');
     List<Appointment> appointment= await _auth.availableTime(clinicId: _searchResult.clinicData.sId);

     print(_searchResult.clinicData.openingTime);
     print(_searchResult.clinicData.clossingTime);
//    double time = double.parse(_auth.getClinicData.waitingTime);
//    if (time > 59) {
//      final int hour = time ~/ 60;
//      final double minutes = time % 60;
//      _hourTextEditingController.text = hour.toString();
//      _minuteTextEditingController.text = minutes.toString();
//    } else {
//      _minuteTextEditingController.text = _auth.getClinicData.waitingTime;
//    }
    bookingTime.clear();
     for(int i = 8; i<  13; i++){
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
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
                infoWidget.screenWidth,
                infoWidget.orientation == Orientation.portrait
                    ? infoWidget.screenHeight * 0.075
                    : infoWidget.screenHeight * 0.09),
            child: AppBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: infoWidget.orientation == Orientation.portrait
                        ? infoWidget.screenWidth * 0.05
                        : infoWidget.screenWidth * 0.035,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //TODO: make pop
                  }),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            size: infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight * 0.04:infoWidget.screenHeight * 0.07,
                          ),
                          Positioned(
                              right: 2.9,
                              top: 2.8,
                              child: Container(
                                width: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.023:infoWidget.screenWidth * 0.014,
                                height: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.023:infoWidget.screenWidth* 0.014,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: infoWidget.defaultHorizontalPadding,
                    vertical: infoWidget.defaultVerticalPadding),
                padding: EdgeInsets.symmetric(
                    vertical: infoWidget.defaultVerticalPadding,
                    horizontal: infoWidget.defaultHorizontalPadding),
                width: infoWidget.screenWidth,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    // border: Border.all(color: Colors.blueAccent,width: 10,style: BorderStyle.solid),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(10),
                        topEnd: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ShowUserProfile(
                          userData:_searchResult
                              .doctorData,
                          clinicData: _searchResult
                              .clinicData,
                          type: 'doctor',
                        )));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: infoWidget.defaultVerticalPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius
                                        .all(Radius.circular(
                                        infoWidget.orientation ==
                                            Orientation
                                                .portrait
                                            ? 35.0
                                            : 55.0)),
                                    child: FadeInImage
                                        .assetNetwork(
                                      placeholder:
                                      'assets/user.png',
                                      image: _searchResult.doctorData.doctorImage
                                      ,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  width:
                                  infoWidget.screenWidth *
                                      0.18,
                                  height:
                                  infoWidget.screenWidth *
                                      0.18,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: infoWidget
                                  .defaultVerticalPadding,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: infoWidget.defaultHorizontalPadding *
                                        2.2),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text('Dr. ${_searchResult.doctorData.firstName} ${_searchResult.doctorData.lastName}',
                                              //${patientAppointment.registerData.firstName} ${patientAppointment.registerData.lastName}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: infoWidget.title),
                                        ),
                                        RatingBar(
                                          rating: 3,
                                          icon: Icon(
                                            Icons.star,
                                            size: infoWidget.screenWidth * 0.04,
                                            color: Colors.grey,
                                          ),
                                          starCount: 5,
                                          spacing: 2.0,
                                          size: infoWidget.screenWidth * 0.03,
                                          isIndicator: true,
                                          allowHalfRating: true,
                                          onRatingCallback: (double value,
                                              ValueNotifier<bool> isIndicator) {
                                            //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                                            isIndicator.value = true;
                                          },
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              infoWidget.defaultVerticalPadding),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                                'Speciality: ${_searchResult.doctorData.speciality}'
                                                //${patientAppointment.registerData.speciality}',
                                                ,
                                                style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              infoWidget.defaultVerticalPadding),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              'Location: ${_searchResult.doctorData.address}'
                                              ,
                                              style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              infoWidget.defaultVerticalPadding),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              'Phone Number: ${_searchResult.doctorData.number}'
                                              ,
                                              style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text('Bio', style: infoWidget.title.copyWith(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 19, bottom: 5.0, right: 10),
                      child: Text(
                          _searchResult.doctorData.aboutYou,
                        maxLines: 4,
                        textAlign: TextAlign.justify,
                        style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)

                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text('Clinic info', style: infoWidget.title.copyWith(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: <Widget>[
                          _data(title: 'Clinic Name:', content: _searchResult.clinicData.clinicName,textStyle: infoWidget.titleButton),
                          _data(
                              title: 'Working Time:',
                              content: 'From ${_searchResult.clinicData.openingTime} AM To ${_searchResult.clinicData.clossingTime} PM ',textStyle: infoWidget.titleButton),
                          _data(title: 'Working Days:', content: _searchResult.clinicData.waitingTime,textStyle: infoWidget.titleButton),
                          _data(title: 'Wating Time:', content: _searchResult.clinicData.waitingTime,textStyle: infoWidget.titleButton),
                          _data(title: 'Address:', content: _searchResult.clinicData.address,textStyle: infoWidget.titleButton),

                          // _data(title: 'Governorate:', content: widget.governorate),

                          _data(title: 'Fees:', content: _searchResult.clinicData.fees,textStyle: infoWidget.titleButton),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: infoWidget.defaultVerticalPadding),
                      child: Text('Booking Time',
                          style: infoWidget.title),
                    ),
                    isBookingTimeLoading?SizedBox(
                      height: infoWidget.screenHeight*0.15,
                      width: infoWidget.screenWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Center(child: Text('Loading Booking Time ...',maxLines: 2,style: infoWidget.titleButton.copyWith(color: Colors.black,fontWeight: FontWeight.w600)))),
                        ],
                      ),
                    ):bookingTime.length==0?SizedBox(
        height: infoWidget.screenHeight*0.15,
        width: infoWidget.screenWidth,
        child: Row(
        children: <Widget>[
          Expanded(child: Center(child: Text('There in no booking time avialable today',style: infoWidget.titleButton.copyWith(color: Colors.black,fontWeight: FontWeight.w600),maxLines: 3,))),
        ],
        )):BookingInfoCard(bookingTime: bookingTime,indexForSearchResult: widget.index,),
//                    BookingInfoCard(),
//                    BookingInfoCard(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
