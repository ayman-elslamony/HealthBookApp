import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class PreviousPrescription extends StatefulWidget {
  @override
  _PreviousPrescriptionState createState() => _PreviousPrescriptionState();
}

class _PreviousPrescriptionState extends State<PreviousPrescription> {
  bool _showPreviousPrescription= false;
  Widget _labAndVitalResult({String title,String result,String trailing}){
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
        child: Row(
          children: <Widget>[
            Text(
              '$title: ',
              style: TextStyle(
                  color: Colors
                      .blue,
                  fontWeight:
                  FontWeight
                      .bold,
                  fontSize:
                  16),
            ),
            Text(
              ' $result ',
              style: TextStyle(
                  color: Colors
                      .red,
                  fontWeight:
                  FontWeight
                      .bold,
                  fontSize:
                  14),
            ),
            Text(
              ' $trailing ',
              style: TextStyle(
                  color: Colors
                      .blue,
                  fontWeight:
                  FontWeight
                      .bold,
                  fontSize:
                  16),
            ),
            Spacer()
          ],
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/user.png'),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Mahmoud Essam',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('30 years old',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,color: Colors.grey,)
                          ,Text('texas,united states',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),

            ],
          ),
        ),
        SizedBox(height: 5.0,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Color(0xfffafbff),
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
                        _showPreviousPrescription = !_showPreviousPrescription;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Dr: mohamed",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text("20-2-2020",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Icon(
                            _showPreviousPrescription
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 25,
                          ),
                        ],
                      ),
                    )),
                _showPreviousPrescription
                    ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Divider(
                    color: Colors.grey,
                    height: 4,
                  ),
                )
                    : SizedBox(),
                _showPreviousPrescription
                    ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 15, right: 15, top: 6.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('prescription one',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Spacer(), Text('Date: ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),Text('04-07-2020',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8.0,),
                        Row(
                          children: <Widget>[

                            AutoSizeText(
                              'Diagnose: ',
                              style: TextStyle(color: Colors.blue),
                              presetFontSizes: [18, 16, 14],
                              textAlign: TextAlign.center,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                ' Diagnose Diagnose Diagnose',
                                maxLines: 6,
                                presetFontSizes: [16, 14, 12],
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText(
                                'Description: ',
                                style: TextStyle(color: Colors.blue),
                                presetFontSizes: [18, 16, 14],
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  ' Description Description',
                                  presetFontSizes: [16, 14, 12],
                                  maxLines: 6,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              border: Border.all(color: Colors.blue)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'Medicine: ',
                                  presetFontSizes: [18, 16, 14],
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.0,)
                                ,                                          SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                      itemBuilder:
                                          (context, index) => Row(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(8.0),
                                            child: Column(
                                              children: <
                                                  Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .blue,
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(15))),
                                                  child:
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        12.0,
                                                        vertical:
                                                        9.0),
                                                    child:
                                                    Text(
                                                      '${index + 1}',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.70,
                                              child: Column(
                                                children: <
                                                    Widget>[
                                                  Row(
                                                    children: <
                                                        Widget>[
                                                      Text(
                                                        'Name:',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blue,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize:
                                                            16),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                          child: Column(
                                                            children: <Widget>[Text(
                                                              ' Name  Name  Name  Name  Name  Name  Name  Name ',
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 6,style: TextStyle(
                                                                color: Colors
                                                                    .red,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                14),
                                                            ),],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <
                                                        Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left:
                                                            8.0),
                                                        child:
                                                        Text(
                                                          'Dosage:',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.blue,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                          child: Column(
                                                            children: <Widget>[Text(
                                                              ' Dosage  Dosage  Dosage  Dosage  Dosage ',
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 6,style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                14),
                                                            ),],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              border: Border.all(color: Colors.blue)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'Radiology: ',
                                  presetFontSizes: [18, 16, 14],
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.0,),
                                SizedBox(
                                  height: 220,
                                  child: ListView.builder(
                                      itemCount: 2,
                                      itemBuilder: (context, index) =>
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                decoration:
                                                BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      15),
                                                  border: Border.all(
                                                      color: Colors
                                                          .blue[500]),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        15),
                                                    child:
                                                    Image.asset(
                                                      'assets/patient.png',
                                                      fit:
                                                      BoxFit.fill,
                                                    )),
                                              ),
                                              SizedBox(height: 5.0,),
                                              ListTile(
                                                title: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Name:  ',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blue,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize:
                                                          16),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        ' Name  Name  Name  Name  Name  Name  Name  Name ',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize:
                                                            14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Description:',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blue,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize:
                                                            16),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                          child: Column(
                                                            children: <Widget>[
                                                              AutoSizeText(
                                                                ' Description  Description  Description',
                                                                maxLines: 6,
                                                                presetFontSizes: [14,12],
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ), SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              border: Border.all(color: Colors.blue)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'Analysis: ',
                                  presetFontSizes: [18, 16, 14],
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.0,),
                                SizedBox(
                                  height: 220,
                                  child: ListView.builder(
                                      itemCount: 2,
                                      itemBuilder: (context, index) =>
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                decoration:
                                                BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      15),
                                                  border: Border.all(
                                                      color: Colors
                                                          .blue[500]),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        15),
                                                    child:
                                                    Image.asset(
                                                      'assets/patient.png',
                                                      fit:
                                                      BoxFit.fill,
                                                    )),
                                              ),
                                              SizedBox(height: 5.0,),
                                              ListTile(
                                                title: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Name:  ',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blue,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize:
                                                          16),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        ' Name  Name  Name  NameName  Name  Name  Name ',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize:
                                                            14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Description:',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blue,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize:
                                                            16),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        child: SingleChildScrollView(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                            child: Column(
                                                              children: <Widget>[
                                                                AutoSizeText(
                                                                  ' Description  Description  Description',
                                                                  maxLines: 2,
                                                                  presetFontSizes: [14,12],
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              border: Border.all(color: Colors.blue)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'Vital Result: ',
                                  presetFontSizes: [18, 16, 14],
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.0,),
                                _labAndVitalResult(title:'BloodPressure',result: '120/56',trailing: 'mmHg'),
                                _labAndVitalResult(title: 'PlusRate',result: '55',trailing: 'bpm'),
                                _labAndVitalResult(title: 'OxygenSaturation',result: '80',trailing: '%'),
                                _labAndVitalResult(title: 'RespiratoryRate',result: '60',trailing: 'br/min'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              border: Border.all(color: Colors.blue)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'Lab Result: ',
                                  presetFontSizes: [18, 16, 14],
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.0,),
                                _labAndVitalResult(title: 'WBC',result: '10.1',trailing: 'K/mm3'),
                                _labAndVitalResult(title: 'HGB',result: '11',trailing: 'Gm/dl'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ))
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
