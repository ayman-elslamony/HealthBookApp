import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Drug extends StatefulWidget {
  @override
  _DrugState createState() => _DrugState();
}

class _DrugState extends State<Drug> {
  bool _showDrugs = false;

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
                          _showDrugs = !_showDrugs;
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
                              _showDrugs
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 25,
                            ),
                          ],
                        ),
                      )),
                  _showDrugs
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 4,
                          ),
                        )
                      : SizedBox(),
                  _showDrugs
                      ? Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 15, right: 15, top: 1.0),
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
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage:
                                                  AssetImage('assets/user.png'),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.blue)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(height: 8.0,)
                                    ,Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        AutoSizeText(
                                          'Medicine: ',
                                          presetFontSizes: [ 16, 14],
                                          textAlign: TextAlign.center,
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                          itemBuilder: (context, index) => Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12.0,
                                                                    vertical:
                                                                        9.0),
                                                            child: Text(
                                                              '${index + 1}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.70,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                'Name:',
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
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        ' Name  Name  Name  Name  Name  Name  Name  Name ',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            6,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  'Dosage:',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        ' Dosage  Dosage  Dosage  Dosage  Dosage ',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            6,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey[700],
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ],
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
