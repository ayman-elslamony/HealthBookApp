import 'package:flutter/material.dart';

class EditPersonalInfoCard extends StatefulWidget {
  final String address;
  final String governorate;
  final String gender;
  final String phoneNumber;
  final String maritalStatus;
  final String language;
  final String email;
  final TextStyle title;
  final TextStyle subTitle;
  final double width;
  final Orientation orientation;
  final Function editProfile;

  EditPersonalInfoCard(
      {this.editProfile,
      this.address,
      this.width,
      this.orientation,
      this.governorate,
      this.gender,
      this.phoneNumber,
      this.maritalStatus,
      this.language,
      this.subTitle,
      this.title,
      this.email});

  @override
  _EditPersonalInfoCardState createState() => _EditPersonalInfoCardState();
}

class _EditPersonalInfoCardState extends State<EditPersonalInfoCard> {
  bool _showPersonalInfo = true;

  Widget _data({String title, String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title + " ",
              style: widget.subTitle
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    content,
                    style: widget.subTitle.copyWith(
                        color: Color(0xff484848), fontWeight: FontWeight.w500),
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
                      _showPersonalInfo = !_showPersonalInfo;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Personal Information",
                            style: widget.title.copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500)),
                        Icon(
                          _showPersonalInfo
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: widget.orientation == Orientation.portrait
                              ? widget.width * 0.065
                              : widget.width * 0.049,
                        ),
                      ],
                    ),
                  )),
            ),
            _showPersonalInfo
                ? Divider(
                    color: Colors.grey,
                    height: 4,
                  )
                : SizedBox(),
            _showPersonalInfo
                ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 15, right: 15, top: 6.0),
                    child: Column(
                      children: <Widget>[
                        widget.email == ''
                            ? SizedBox()
                            : _data(title: 'Email:', content: widget.email),
                        widget.phoneNumber == ''
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  widget.editProfile('phone',context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: _data(
                                          title: 'Phone Number:',
                                          content: widget.phoneNumber),
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )
                                  ],
                                )),
                        widget.address == ''
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  widget.editProfile('address',context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        child: _data(
                                            title: 'Address:',
                                            content: widget.address)),
                                    Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )
                                  ],
                                )),
                        widget.gender == ''
                            ? SizedBox()
                            : _data(title: 'Gender:', content: widget.gender),
                        widget.governorate == ''
                            ? SizedBox()
                            : _data(
                                title: 'Governorate:',
                                content: widget.governorate),
                        widget.maritalStatus == ''
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  widget.editProfile('social',context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: _data(
                                          title: 'Social status:',
                                          content: widget.maritalStatus),
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )
                                  ],
                                )),
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
