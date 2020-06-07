import 'package:flutter/material.dart';

class PersonalInfoCard extends StatefulWidget {
  final String address;
  final String governorate;
  final String gender;
  final String phoneNumber;
  final String maritalStatus;
  final String language;
  final String email;
  PersonalInfoCard(
      {this.address,
      this.governorate,
      this.gender,
      this.phoneNumber,
      this.maritalStatus,
      this.language,
      this.email});

  @override
  _PersonalInfoCardState createState() => _PersonalInfoCardState();
}

class _PersonalInfoCardState extends State<PersonalInfoCard> {
  bool _showPersonalInfo = false;

  Widget _data({String title, String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title + " ",
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
                      _showPersonalInfo = !_showPersonalInfo;
                    });
                  },
                  child:
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Personal Information",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Icon(
                          _showPersonalInfo
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 25,
                        ),
                      ],
                    ),
                  )),
            ),
            _showPersonalInfo?Divider(
              color: Colors.grey,
              height: 4,
            ):SizedBox(),
            _showPersonalInfo
                ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,left: 15,right: 15,top: 6.0),
                  child: Column(
                      children: <Widget>[
                        _data(title: 'Email:', content: widget.email),
                        _data(
                            title: 'Phone Number:', content: widget.phoneNumber),
                        _data(title: 'Address:', content: widget.address),
                        _data(title: 'Gender:', content: widget.gender),
                        _data(title: 'Governorate:', content: widget.governorate),
                        _data(
                            title: 'Marital Status:',
                            content: widget.maritalStatus),
                        _data(title: 'Language:', content: widget.language),
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
