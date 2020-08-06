
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/models/call.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/providers/call_methods.dart';
import 'package:healthbook/screens/callscreens/pickup/pickup_screen.dart';
import 'package:provider/provider.dart';


class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    @required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    final Auth userProvider = Provider.of<Auth>(context);
    print('PickupLayout${userProvider.userId}');
    return (userProvider != null && userProvider.userId != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.userId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data != null) {
                Call call = Call.fromMap(snapshot.data.data);

                if (!call.hasDialled) {
                  return PickupScreen(call: call);
                }
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
