import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';

import 'booking_time_card.dart';

class Booking extends StatelessWidget {
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
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: infoWidget.defaultVerticalPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: infoWidget.defaultVerticalPadding),
                                height: infoWidget.screenWidth * 0.28,
                                width: infoWidget.screenWidth * 0.28,
                                decoration: BoxDecoration(
                                  color: Color(0xff66AFFF),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Image.asset('assets/icons/user1.jpeg'),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: infoWidget.defaultVerticalPadding,
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
                                        child: Text('Dr. Wasila ahmed',
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
                                              'Speciality: '
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
                                            'Location: '
                                            //${patientAppointment.registerData.address}',
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
                        'dvdvd  rhth y juykj uku tr ewfew grhg 6u6 dwed r4grg 66h fe',
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
                          _data(title: 'Clinic Name:', content: 'Name',textStyle: infoWidget.titleButton),
                          _data(
                              title: 'Working Time:',
                              content: 'From 4 AM To 8 PM ',textStyle: infoWidget.titleButton),
                          _data(title: 'Working Days:', content: 'dvd',textStyle: infoWidget.titleButton),
                          _data(title: 'Wating Time:', content: '30 min',textStyle: infoWidget.titleButton),
                          _data(title: 'Address:', content: 'addresss',textStyle: infoWidget.titleButton),

                          // _data(title: 'Governorate:', content: widget.governorate),

                          _data(title: 'Fees:', content: '200 EGP',textStyle: infoWidget.titleButton),
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
                    BookingInfoCard(),
                    BookingInfoCard(),
                    BookingInfoCard(),
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
