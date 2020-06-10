import 'package:flutter/material.dart';

class ClinicInfoCard extends StatefulWidget {
  final String address;
  final String governorate;
  final String watingTime;
  final String fees;
  final List<String> workingDays;
  final String startTime;
  final String endTime;


  ClinicInfoCard(
      {this.address,
        this.startTime,
        this.endTime,
      this.governorate,
      this.watingTime,
      this.fees,
      this.workingDays});

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
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              content,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black),
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
        elevation: 8.0,
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
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Icon(
                          _showClinicInfo
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 25,
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
                        _data(
                            title: 'Clinic Name:',
                            content: 'Name'),
                        _data(
                            title: 'Working Time:',
                            content: 'From ${widget.startTime} To ${widget.endTime}'),
                        _data(
                            title: 'Working Days:', content: _getWorkingDays()),
                        _data(
                            title: 'Wating Time:',
                            content: '${widget.watingTime} min'),
                        _data(title: 'Address:', content: widget.address),

                        // _data(title: 'Governorate:', content: widget.governorate),

                        _data(title: 'Fees:', content: '${widget.fees} EGP'),
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
