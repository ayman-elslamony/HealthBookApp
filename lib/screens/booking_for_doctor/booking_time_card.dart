import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';

class BookingInfoCard extends StatefulWidget {
  final bool showBookingTime;

  BookingInfoCard({this.showBookingTime=false});

  @override
  _BookingInfoCardState createState() => _BookingInfoCardState();
}

class _BookingInfoCardState extends State<BookingInfoCard> {
  bool _showBookingInfo = false;
  List<bool> _avilableBookingTime = List.generate(9, (i)=>true);
Widget _createBookingTime({int index,TextStyle textStyle}){
  return InkWell(
    onTap: widget.showBookingTime?null :_avilableBookingTime[index]?(){
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
                       'Thursday , ${index+1}:30 Am o\'clock ',
                       style: TextStyle(
                           color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text(
                       'In your Clinic Doctor',
                       style: TextStyle(
                           color: Colors.blue, fontSize: 16,fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
               ],
             ),
           ),
           actions: <Widget>[
             FlatButton(
               child: Text('Ok',style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
               onPressed: () {
                 setState(() {
                   _avilableBookingTime[index] = false;
                 });
                 Navigator.of(ctx).pop();
               },
             ),
             FlatButton(
               child: Text('Cancel',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
               onPressed: () {
                 setState(() {
                   _avilableBookingTime[index] = true;
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
          color:  _avilableBookingTime[index]?Colors.blue:Colors.grey,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          '${index+1}:30',
          style: textStyle.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
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
                          Text("Tomorrow",
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
                          itemCount: 9,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: infoWidget.orientation==Orientation.portrait?3:4.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          itemBuilder: (ctx, index) => _createBookingTime(index: index,textStyle: infoWidget.subTitle)),
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
