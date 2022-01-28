import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/booking_for_doctor/booking_screen.dart';
import 'package:healthbook/screens/user_profile/show_profile.dart';
import 'package:healthbook/screens/user_profile/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'specific_search_screen.dart';

class SearchResult extends StatefulWidget {
  Function function;

  SearchResult({this.function});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Auth _auth;
  bool isLoading = false;
  @override
  void initState() {
    _auth = Provider.of(context, listen: false);
    super.initState();
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
                            size: infoWidget.orientation == Orientation.portrait
                                ? infoWidget.screenHeight * 0.04
                                : infoWidget.screenHeight * 0.07,
                          ),
                          Positioned(
                              right: 2.9,
                              top: 2.8,
                              child: Container(
                                width: infoWidget.orientation ==
                                        Orientation.portrait
                                    ? infoWidget.screenWidth * 0.023
                                    : infoWidget.screenWidth * 0.014,
                                height: infoWidget.orientation ==
                                        Orientation.portrait
                                    ? infoWidget.screenWidth * 0.023
                                    : infoWidget.screenWidth * 0.014,
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
          body: RefreshIndicator(
            onRefresh: () async {
              await  widget.function();
              print(_auth.searchResult.length);
            },
            color: Colors.blue,
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 4.0,
                  right: 4.0,
                  bottom: 8.0,
                  top: infoWidget.orientation == Orientation.portrait
                      ? 0.0
                      : 5.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: FlatButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0))),
                                contentPadding: EdgeInsets.only(top: 10.0),
                                content: SizedBox(
                                    height: infoWidget.screenHeight * 0.40,
                                    width: infoWidget.screenWidth * 0.8,
                                    child: SpecificSearch(useFilter: true,)),
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
                          },
                          icon: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: infoWidget.orientation == Orientation.portrait
                                ? infoWidget.screenWidth * 0.085
                                : infoWidget.screenWidth * 0.05,
                          ),
                          label: Text(
                            'Search by',
                            style: infoWidget.titleButton,
                          ),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )),
                      ],
                    ),
                    Consumer<Auth>(builder: (context, data, _) {
                            print('data.searchResult.length${data.searchResult.length}');
                            if (data.searchResult.length == 0) {
                              return SizedBox(
                                height: infoWidget.screenHeight*0.85,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Center(
                                  child: Text('There no any Result'),
                                ),
                                  ],
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: infoWidget.defaultVerticalPadding,
                                      horizontal:
                                          infoWidget.defaultHorizontalPadding),
                                  child: Material(
                                    shadowColor: Colors.blueAccent,
                                    elevation: 2.0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    type: MaterialType.card,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              infoWidget.defaultVerticalPadding,
                                          horizontal: infoWidget
                                                  .defaultHorizontalPadding *
                                              2),
                                      child: Column(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ShowUserProfile(
                                                userData: data.searchResult[index]
                                                .doctorData,
                                                clinicData: data.searchResult[index]
                                                    .clinicData,
                                                type: 'doctor',
                                              )));
                                            }
                                            ,child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
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
                                                          image: data
                                                              .searchResult[index]
                                                              .doctorData
                                                              .doctorImage
                                                          //patientAppointment.registerData.doctorImage,
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
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                                'Dr. ${data.searchResult[index].doctorData.firstName} ${data.searchResult[index].doctorData.lastName}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: infoWidget
                                                                    .title),
                                                          ),
                                                          RatingBar(
                                                            rating: 3,
                                                            icon: Icon(
                                                              Icons.star,
                                                              size: infoWidget
                                                                      .screenWidth *
                                                                  0.04,
                                                              color: Colors.grey,
                                                            ),
                                                            starCount: 5,
                                                            spacing: 2.0,
                                                            size: infoWidget
                                                                    .screenWidth *
                                                                0.03,
                                                            isIndicator: true,
                                                            allowHalfRating: true,
                                                            onRatingCallback: (double
                                                                    value,
                                                                ValueNotifier<bool>
                                                                    isIndicator) {
                                                              //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                                                              isIndicator.value =
                                                                  true;
                                                            },
                                                            color: Colors.amber,
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: infoWidget
                                                                .defaultVerticalPadding),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Text(
                                                                  'Speciality: ${data.searchResult[index].doctorData.speciality}'
                                                                  //${patientAppointment.registerData.speciality}',
                                                                  ,
                                                                  style: infoWidget
                                                                      .subTitle
                                                                      .copyWith(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500)),
                                                            ),
                                                            Text('Avilable',
                                                                style: infoWidget
                                                                    .subTitle
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500)),
                                                          ],
                                                        ),
                                                      ),
                                                      data.searchResult[index].clinicData==null?SizedBox():Padding(
                                                        padding: EdgeInsets.only(
                                                            left: infoWidget
                                                                .defaultVerticalPadding),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Text(
                                                                'Location: ${data.searchResult[index].clinicData.address}'
                                                                //${patientAppointment.registerData.address}',
                                                                ,
                                                                style: infoWidget
                                                                    .subTitle
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                infoWidget.defaultVerticalPadding,
                                          ),
                                          RaisedButton(
                                            onPressed:  data.searchResult[index].clinicData==null?(){
                                              Toast.show('Not avilable now please try again later', context);
                                            }:() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Booking(index: index,)));
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            color:  data.searchResult[index].clinicData==null?Colors.grey:Colors.blue,
                                            child: Text(
                                              'Booking now',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.searchResult.length,
                              );
                            }
                          }),
//                  ,InkWell(
//                    onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserProfile()));
//                    },
//                    child: Padding(
//                      padding: const EdgeInsets.symmetric(vertical: 5.0),
//                      child: Card(
//                        color: Colors.white70,
//                        child: Container(
//                          margin: EdgeInsets.symmetric(vertical: 10),
//                          child: Column(
//                            children: <Widget>[
//                              Row(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                children: <Widget>[
//                                  Container(
//                                    child: CircleAvatar(
//                                      backgroundImage: AssetImage(
//                                          'assets/user.png'), //child: Image.asset('assets/user.png',fit: BoxFit.cover,width: 100,height: 100,),
//                                    ),
//                                    width: 45,
//                                    height: 50,
//                                  ),
//                                  Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Text(
//                                        'Dr wasila',
//                                        style: Theme.of(context)
//                                            .textTheme
//                                            .display3
//                                            .copyWith(fontSize: 17),
//                                      ),
//                                      Text(
//                                        'Specility: Dentist',
//                                        style: Theme.of(context)
//                                            .textTheme
//                                            .body2
//                                            .copyWith(fontSize: 15,color: Colors.grey[700]),
//                                        textAlign: TextAlign.start,
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(top:4.0),
//                                        child: Row(
//                                          children: <Widget>[
//                                            Icon(Icons.location_on,color: Colors.grey,)
//                                            ,Text(
//                                              'b dfbf nfd nvn ddszb c',
//                                              maxLines: 1,
//                                              textAlign: TextAlign.justify,
//                                              overflow: TextOverflow.ellipsis,
//                                              style: Theme.of(context)
//                                                  .textTheme
//                                                  .display1
//                                                  .copyWith(fontSize: 14,color: Colors.grey[700]),
//                                            ),
//                                          ],
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                  Column(
//                                    crossAxisAlignment: CrossAxisAlignment.end,
//                                    children: <Widget>[
//                                      RatingBar(
//                                        rating: 3,
//                                        icon: Icon(
//                                          Icons.star,
//                                          size: 18,
//                                          color: Colors.grey,
//                                        ),
//                                        starCount: 5,
//                                        spacing: 2.0,
//                                        size: 15,
//                                        isIndicator: true,
//                                        allowHalfRating: true,
//                                        onRatingCallback: (double value,
//                                            ValueNotifier<bool> isIndicator) {
//                                          //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
//                                          isIndicator.value = true;
//                                        },
//                                        color: Colors.amber,
//                                      ),
////                            Padding(
////                              padding: const EdgeInsets.only(top: 4.0),
////                              child: Text(
////                                'Avilable',
////                                style: Theme.of(context)
////                                    .textTheme
////                                    .display3
////                                    .copyWith(
////                                      fontSize: 14,
////                                    ),
////                              ),
////                            ),
//                                    ],
//                                  ),
//                                ],
//                              ),
//                              SizedBox(height: 5,),
//                              RaisedButton(onPressed: (){
//                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Booking()));
//                              },
//                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                                color: Colors.blue,
//                                child: Text('Booking now',style: TextStyle(color: Colors.white,fontSize: 18),),
//
//
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
