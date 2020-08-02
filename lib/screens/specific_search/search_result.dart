import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
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

    return InfoWidget(
      builder: (context,infoWidget){
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(infoWidget.screenWidth, infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight*0.075:infoWidget.screenHeight*0.09),
            child: AppBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.05:infoWidget.screenWidth*0.035,),
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
                            size: infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight * 0.045:infoWidget.screenHeight * 0.08,
                          ),
                          Positioned(
                              right: 2.9,
                              top: 2.8,
                              child: Container(
                                width: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.025:infoWidget.screenWidth * 0.017,
                                height: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.025:infoWidget.screenWidth* 0.017,
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
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(left: 4.0,right: 4.0,bottom: 8.0,top: infoWidget.orientation==Orientation.portrait?0.0:5.0),
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
                                height: infoWidget.screenHeight*0.65,
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
                      }, icon: Icon(Icons.filter_list,color: Colors.white,size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.085:infoWidget.screenWidth * 0.059,), label: Text('Search by',style: infoWidget.titleButton,),color: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: infoWidget.defaultVerticalPadding,
                        horizontal: infoWidget.defaultHorizontalPadding),
                    child: Material(
                      shadowColor: Colors.blueAccent,
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: infoWidget.defaultVerticalPadding,
                            horizontal: infoWidget.defaultHorizontalPadding *2),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(infoWidget.orientation == Orientation.portrait
                                            ? 35.0:55.0)),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/user.png',
                                          image: 'https://res.cloudinary.com/dmmnnncjd/image/upload/v1595866185/ceqcpxokjyyiofznctpv.jpg'//patientAppointment.registerData.doctorImage,
                                          ,fit: BoxFit.fill,
                                        ),
                                      ),
                                      width: infoWidget.screenWidth * 0.18,
                                      height:  infoWidget.screenWidth * 0.18,
                                    ),
                                  ],
                                ),
                                SizedBox(width: infoWidget.defaultVerticalPadding,),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                                'Dr. Wasila ahmed',//${patientAppointment.registerData.firstName} ${patientAppointment.registerData.lastName}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: infoWidget.title),
                                          ),
                                          RatingBar(
                                            rating: 3,
                                            icon: Icon(
                                              Icons.star,
                                              size: infoWidget.screenWidth* 0.04,
                                              color: Colors.grey,
                                            ),
                                            starCount: 5,
                                            spacing: 2.0,
                                            size: infoWidget.screenWidth*0.03,
                                            isIndicator: true,
                                            allowHalfRating: true,
                                            onRatingCallback: (double value,
                                                ValueNotifier<bool> isIndicator) {
                                              //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                                              isIndicator.value = true;
                                            },
                                            color: Colors.amber,
                                          ),
                                        ],)
                                      ,
                                      Padding(
                                        padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text('Speciality: '//${patientAppointment.registerData.speciality}',
                                                  ,style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)),
                                            ),
                                            Text(
                                                'Avilable',
                                                style:
                                                infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)
                                            ),
                                          ],),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'Location: '//${patientAppointment.registerData.address}',
                                                ,style:
                                                infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: infoWidget.defaultVerticalPadding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child:  Text(
                                                'Appointement at '//${patientAppointment.appointStart} PM',
                                               , style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text('19 min left',
                                                style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500)),
                                          ],),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: infoWidget.defaultVerticalPadding,
                            ),
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
        );
      },
    );
  }
}

