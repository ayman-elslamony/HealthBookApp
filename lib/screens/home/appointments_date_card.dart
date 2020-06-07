import 'package:flutter/material.dart';

class AppointmentsDateCard extends StatefulWidget {
  bool isdoctor;

  AppointmentsDateCard({this.isdoctor});

  @override
  _AppointmentsDateCardState createState() => _AppointmentsDateCardState();
}

class _AppointmentsDateCardState extends State<AppointmentsDateCard> {
  bool _isAppointmentsDateSelected = false;
  String _appointmentsDate;
//  bool _isDoctor = true;
 List<String> _listDate =['Today','b','c','d'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 8.0, right: 15, bottom: 7.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Material(
            shadowColor: Colors.blueAccent,
            elevation: 8.0,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            type: MaterialType.card,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Date:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      _isAppointmentsDateSelected == false?"Today":_appointmentsDate,
                      maxLines: 1,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    tooltip: 'Select Date',
                    padding: EdgeInsets.all(10.0),
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (ctx)=>_listDate
                        .map((String val) => PopupMenuItem<String>(
                      value: val,
                      child: Center(child: Text(val)),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
              widget.isdoctor?'6 Patient':"6 Appointement",
            maxLines: 1,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          )
        ],
      ),
    );
  }
}
