


import 'package:flutter/material.dart';
import 'package:healthbook/list_of_infomation/list_of_information.dart';

class EditSocialStatus extends StatefulWidget {
  final String socialStatus;
  final Function getSocialStatus;

  EditSocialStatus({this.socialStatus, this.getSocialStatus});

  @override
  _EditSocialStatusState createState() => _EditSocialStatusState();
}

class _EditSocialStatusState extends State<EditSocialStatus> {
  bool _isMaterialStatus = false;
  String intialValue= 'Single';
  @override
  void initState() {
    if(widget.socialStatus !=null){
      intialValue = widget.socialStatus;
      widget.getSocialStatus(intialValue);
      _isMaterialStatus = true;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 14.0,top: 8,),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Text(
                  'Social status:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                shadowColor: Colors.blueAccent,
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                type: MaterialType.card,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FittedBox(
                        child: Text(
                            _isMaterialStatus == false
                                ? 'Social status'
                                : intialValue,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 35,
                      child: PopupMenuButton(
                        initialValue: intialValue,
                        tooltip: 'Select social status',
                        itemBuilder: (ctx) => materialStatus
                            .map(
                                (String val) => PopupMenuItem<String>(
                              value: val,
                              child: Text(val.toString()),
                            ))
                            .toList(),
                        onSelected: (val) {
                          setState(() {
                            intialValue = val;
                            widget.getSocialStatus(intialValue);
                            _isMaterialStatus = true;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
