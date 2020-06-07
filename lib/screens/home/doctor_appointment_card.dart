import 'package:flutter/material.dart';
import 'package:healthbook/screens/user_profile/patient_health_record.dart';
import '../user_profile/user_profile.dart';

class DoctorAppointmentCard extends StatelessWidget {
  Function cancelButton;
  DoctorAppointmentCard({this.cancelButton});

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
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 8.0),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed( UserProfile.routeName);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                        child: CircleAvatar(
                        backgroundImage: AssetImage('assets/user.png'),
        ),
        width: 45,
        height: 50,
        ),
                      ],
                    )
                    ,Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text('omar',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.display1.copyWith(fontSize: 18)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Age: 33 years',
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 4),
                          child: Text(
                            'Appointement number: 1',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(fontSize: 14,color: Colors.black87,),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Appointement time : 3:30 PM',
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on,color: Colors.blue,),
                            Text(
                              'Mansoura , shepen',
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 14,color: Colors.black87,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                        '14-Mar-2020',
                        textAlign: TextAlign.end,
                        style:
                        Theme.of(context).textTheme.display3.copyWith(
                          fontSize: 14,
                        ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                          PatientHealthRecord.routeName);
                    },
                    child: Container(
                        height:  35,
                        width: 118,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Text(
                                'View H.Record',
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: cancelButton,
                    child: Container(
                        height:  38,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize:16),
                          ),
                        )),
                  ),
                ],
              )

            ],
          )
        ),
      ),
    );
  }
}
