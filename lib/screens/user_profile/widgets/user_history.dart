import 'package:flutter/material.dart';
import 'package:healthbook/screens/patient_prescription/show_previous_patient_precription.dart';

import '../user_profile.dart';

class UserHistory extends StatefulWidget {
  @override
  _UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  bool _showUserProblems = true;
  bool _showUserHistory = true;
  List<String> _userProblemslist = ['Diabetes mellitus (ICD-250)','Diabetes mellitus (ICD-250)'];

  Widget _userProblems({String problemName}) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
      child: Material(
        shadowColor: Colors.blueAccent,
        elevation: 4.0,
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
                      _showUserProblems = !_showUserProblems;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text("$problemName",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text("20-2-2020",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          )),
                      Icon(
                        _showUserProblems
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 25,
                      ),
                    ],
                  )),
            ),
            _showUserProblems
                ? Divider(
                    color: Colors.grey,
                    height: 1,
                  )
                : SizedBox(),
            _showUserProblems
                ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 15, right: 15, top: 0.0),
                    child: SizedBox(
                      height: 2 * 90.0,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Founded by: ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserProfile()));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      backgroundImage: AssetImage(
                                                          'assets/user.png'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('Dr: Mahmoud Essam',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text('Date: 04-07-2020',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        ),
                                                        Text('texas,united states',
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),

                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          RaisedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          ShowPreviousPatientPrecription(diagnose: _userProblemslist[index],)));
                                            },
                                            color: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        10))),
                                            child: Text(
                                              'Show Prescriptions',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                              fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        itemCount: _userProblemslist.length,
                      ),
                    ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
      Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Health Record:",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    )
    ,Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, left: 15, right: 15, top: 6.0),
              child: SizedBox(
//                height: 4 * 60.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _userProblems(
                          problemName: _userProblemslist[index])),
                  itemCount: _userProblemslist.length,
                ),
              ))
        ],
      )
    );
  }
}
