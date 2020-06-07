import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final String docName;
  final String docImg;
  final String specialType;
  final String diagnisisType;
  final DateTime recordTime;

  RecordCard(
      {this.docName = 'docName',
      this.docImg = 'assets/user.png',
      this.specialType = 'specialty',
      this.diagnisisType = 'diagnisis',
      this.recordTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Material(
        shadowColor: Colors.blueAccent,
        elevation: 8.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        type: MaterialType.card,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 5.0,
                  right: 8.0,
                  child: Text('$recordTime',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display2.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey))),
              Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    dense: true,
                    title: Text('Dr. $docName',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 16)),
                    subtitle: Row(
                      children: <Widget>[
                        Text('Specialty: ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontSize: 16)),
                        Text(
                          '$specialType',
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    leading: Container(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('$docImg'),
                      ),
                      width: 45,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 5.0,
                      bottom: 4.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text('Diagnisis: ',
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontSize: 16)),
                        Text('$diagnisisType',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .display2
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
