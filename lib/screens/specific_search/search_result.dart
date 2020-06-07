import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/screens/booking_for_doctor/booking_screen.dart';
import 'package:healthbook/screens/user_profile/user_profile.dart';

import 'specific_search_screen.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  @override
  Widget build(BuildContext context) {
    final _widthSize = MediaQuery.of(context).size.width;
    final _heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
             //TODO: make pop
            }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          size: 28,
                        ),
                        Positioned(
                            right: 2.9,
                            top: 2.8,
                            child: Container(
                              width: 11,
                              height: 11,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0,right: 4.0,bottom: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: FlatButton.icon(onPressed: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0))),
                        contentPadding: EdgeInsets.only(top: 10.0),
                        content: SizedBox(
                            height: _heightSize*0.65,
                        child: SpecificSearch()),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          )
                        ],
                      ),
                    );
                  }, icon: Icon(Icons.filter_list,color: Colors.white,), label: Text('Search by',style: TextStyle(color: Colors.white,fontSize: 16),),color: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),)),
                ],
              )
              ,InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserProfile()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    color: Colors.white70,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/user.png'), //child: Image.asset('assets/user.png',fit: BoxFit.cover,width: 100,height: 100,),
                                ),
                                width: 45,
                                height: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Dr wasila',
                                    style: Theme.of(context)
                                        .textTheme
                                        .display3
                                        .copyWith(fontSize: 17),
                                  ),
                                  Text(
                                    'Specility: Dentist',
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .copyWith(fontSize: 15,color: Colors.grey[700]),
                                    textAlign: TextAlign.start,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.location_on,color: Colors.grey,)
                                        ,Text(
                                          'b dfbf nfd nvn ddszb c',
                                          maxLines: 1,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .copyWith(fontSize: 14,color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  RatingBar(
                                    rating: 3,
                                    icon: Icon(
                                      Icons.star,
                                      size: 18,
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
//                            Padding(
//                              padding: const EdgeInsets.only(top: 4.0),
//                              child: Text(
//                                'Avilable',
//                                style: Theme.of(context)
//                                    .textTheme
//                                    .display3
//                                    .copyWith(
//                                      fontSize: 14,
//                                    ),
//                              ),
//                            ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          RaisedButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Booking()));
                          },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            color: Colors.blue,
                            child: Text('Booking now',style: TextStyle(color: Colors.white,fontSize: 18),),
                          
                          
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

