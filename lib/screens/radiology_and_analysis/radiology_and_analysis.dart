import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/zoom_in_and_out_to_image.dart';

class RadiologyAndAnalysis extends StatefulWidget {
  @override
  _RadiologyAndAnalysisState createState() => _RadiologyAndAnalysisState();
}

class _RadiologyAndAnalysisState extends State<RadiologyAndAnalysis> {
  bool _showRadiologyAndAnalysis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Drugs',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
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
                          _showRadiologyAndAnalysis = !_showRadiologyAndAnalysis;
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
                              _showRadiologyAndAnalysis
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 25,
                            ),
                          ],
                        ),
                      )),
                  _showRadiologyAndAnalysis
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 4,
                    ),
                  )
                      : SizedBox(),
                  _showRadiologyAndAnalysis
                      ? Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 15, right: 15, top: 6.0),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.blue)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowImage(imgUrl: 'assets/user.png',isImgUrlAsset: true,)));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage:
                                            AssetImage('assets/user.png'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Dr: Mohamed',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold)),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0),
                                          child: Text('texas,united states',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 17,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text('prescription one',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text('04-07-2020',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
//                            Row(
//                              children: <Widget>[
//                                AutoSizeText(
//                                  'Diagnose: ',
//                                  style: TextStyle(color: Colors.blue),
//                                  presetFontSizes: [18, 16, 14],
//                                  textAlign: TextAlign.center,
//                                ),
//                                Expanded(
//                                  child: AutoSizeText(
//                                    ' Diagnose Diagnose Diagnose',
//                                    maxLines: 6,
//                                    presetFontSizes: [16, 14, 12],
//                                    textAlign: TextAlign.start,
//                                  ),
//                                ),
//                              ],
//                            ),
//                            Padding(
//                              padding:
//                                  const EdgeInsets.symmetric(vertical: 5.0),
//                              child: Row(
//                                children: <Widget>[
//                                  AutoSizeText(
//                                    'Description: ',
//                                    style: TextStyle(color: Colors.blue),
//                                    presetFontSizes: [18, 16, 14],
//                                    textAlign: TextAlign.center,
//                                  ),
//                                  Expanded(
//                                    child: AutoSizeText(
//                                      ' Description Description',
//                                      presetFontSizes: [16, 14, 12],
//                                      maxLines: 6,
//                                      textAlign: TextAlign.start,
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
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
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('prescription one',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))
                                , Text('04-07-2020',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],),
                            SizedBox(height: 8.0,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    'Radiology: ',
                                    presetFontSizes: [18, 16, 14],
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(
                                  height: 230,
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
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowImage(imgUrl: 'assets/patient.png',isImgUrlAsset: true,)));
                                                  },
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    'Analysis: ',
                                    presetFontSizes: [18, 16, 14],
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(
                                  height: 230,
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
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowImage(imgUrl: 'assets/patient.png',isImgUrlAsset: true,)));
                                                  },
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
                          height: 5,
                        ),
                      ]))
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
