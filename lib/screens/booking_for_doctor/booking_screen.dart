import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';

import 'booking_time_card.dart';

class Booking extends StatelessWidget {
  Widget _data({String title, String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                 fontSize: 18, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              content,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue[800]),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(color: Colors.white,onPressed: (){
        Navigator.of(context).pop();
      },),),
      body: ListView(
        children: <Widget>[
          Container(
            margin:  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            padding:const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                // border: Border.all(color: Colors.blueAccent,width: 10,style: BorderStyle.solid),
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10)
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 2.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 5.0),
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Color(0xff66AFFF),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset('assets/icons/user1.jpeg'),
                          ),
                          RatingBar(
                            rating: 3,
                            icon: Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.grey,
                            ),
                            starCount: 5,
                            spacing: 2.0,
                            size: 15,
                            isIndicator: true,
                            allowHalfRating: true,
                            onRatingCallback: (double value,
                                ValueNotifier<bool> isIndicator) {
                              //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                              isIndicator.value = true;
                            },
                            color: Colors.amber,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '(20,75)',
                            style: Theme.of(context).textTheme.body1.copyWith(
                              fontSize: 15,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Dr. Ayman',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.display1),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 5.0, top: 2.0),
                            child: Row(
                              children: <Widget>[
                                Text('Speciatly: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .display2
                                        .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Text('Dentist',
                                    style: Theme.of(context)
                                        .textTheme
                                        .display2
                                        .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                ),
                                Text(
                                  'Mansoura , shepen',
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .copyWith(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
//                          Padding(
//                            padding:
//                            const EdgeInsets.only(left: 5.0, top: 1.0),
//                            child: Text(
//                              'Avilable',
//                              style:
//                              Theme.of(context).textTheme.body1.copyWith(
//                                fontSize: 15,
//                                color: Colors.green,
//                              ),
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                            ),
//                          )
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  height: 3,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text('Bio',
                      style: Theme.of(context).textTheme.display1),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 19, bottom: 5.0, right: 10),
                  child: Text(
                      'dvdvd  rhth y juykj uku tr ewfew grhg 6u6 dwed r4grg 66h fe',
                      maxLines: 4,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue[800]),),
                ),
                Divider(
                  color: Colors.grey,
                  height: 3,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text('Clinic info',
                      style: Theme.of(context).textTheme.display1),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: <Widget>[
                      _data(
                          title: 'Clinic Name:',
                          content: 'Name'),
                      _data(
                          title: 'Working Time:',
                          content: 'From 4 AM To 8 PM '),
                      _data(
                          title: 'Working Days:', content: 'dvd'),
                      _data(
                          title: 'Wating Time:',
                          content: '30 min'),
                      _data(title: 'Address:', content: 'addresss'),

                      // _data(title: 'Governorate:', content: widget.governorate),

                      _data(title: 'Fees:', content: '200 EGP'),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 3,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text('Booking Time',
                      style: Theme.of(context).textTheme.display1),
                ),
                BookingInfoCard(),BookingInfoCard(),BookingInfoCard(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
