import 'package:flutter/material.dart';

class ClinicInfoCard extends StatefulWidget {

  final String name;
  final String address;
  final String governorate;
  final String watingTime;
  final String fees;
  final List workingDays;
  final String startTime;
  final String endTime;
  final String number;
  final TextStyle title;
  final TextStyle subTitle;
  final double width;
  final Orientation orientation;

  ClinicInfoCard(
      {this.address,
        this.number,
        this.name,
        this.startTime,
        this.endTime,
      this.governorate,
      this.watingTime,
      this.fees,
      this.workingDays,this.title,this.subTitle,this.width,this.orientation});

  @override
  _ClinicInfoCardState createState() => _ClinicInfoCardState();
}

class _ClinicInfoCardState extends State<ClinicInfoCard> {
  bool _showClinicInfo = true;

  Widget _data({String title, String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              title + " ",
              style: widget.subTitle.copyWith(color: Colors.black,fontWeight: FontWeight.w600)
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
                    style: widget.subTitle.copyWith(color: Color(0xff484848),fontWeight: FontWeight.w500),
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
    String _getWorkingDays() {
      String _workingDays = '';
      String x = ',';
      for (int i = 0; i < widget.workingDays.length; i++) {
        if (i < (widget.workingDays.length - 1)) {
          _workingDays = _workingDays + '${widget.workingDays[i]}' + x;
        } else {
          _workingDays = _workingDays + '${widget.workingDays[i]}';
        }
      }
      return _workingDays.trim();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Material(
        shadowColor: Colors.blueAccent,
        elevation: 0.5,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        type: MaterialType.card,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _showClinicInfo = !_showClinicInfo;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Clinic Information",
                            style: widget.title.copyWith( color: Colors.blue,fontWeight: FontWeight.w500)),
                        Icon(
                          _showClinicInfo
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: widget.orientation==Orientation.portrait?widget.width*0.065:widget.width*0.049,
                        ),
                      ],
                    ),
                  )),
            ),
            _showClinicInfo
                ? Divider(
                    color: Colors.grey,
                    height: 4,
                  )
                : SizedBox(),
            _showClinicInfo
                ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 15, right: 15, top: 6.0),
                    child: Column(
                      children: <Widget>[
                        widget.name==''?SizedBox():_data(
                            title: 'Clinic Name:',
                            content: widget.name),
                        widget.number==''?SizedBox():_data(
                            title: 'Clinic Number:',
                            content: widget.number),
                        widget.startTime=='' &&widget.endTime==''?SizedBox():_data(
                            title: 'Working Time:',
                            content: 'From ${widget.startTime} To ${widget.endTime}'),
                        widget.workingDays.length==0?SizedBox():_data(
                            title: 'Working Days:', content: _getWorkingDays()),
                        widget.watingTime==''?SizedBox():_data(
                            title: 'Wating Time:',
                            content: '${widget.watingTime} min'),
                        widget.address==''?SizedBox():_data(title: 'Address:', content: widget.address),
                        widget.governorate==''?SizedBox():_data(title: 'Governorate:', content: widget.governorate),
                        widget.fees==''?SizedBox():_data(title: 'Fees:', content: '${widget.fees} EGP'),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
