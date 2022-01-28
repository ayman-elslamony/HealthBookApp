import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/call.dart';
import 'package:healthbook/providers/call_methods.dart';
import 'package:healthbook/screens/callscreens/call_screen.dart';
import 'package:healthbook/utils/permissions.dart';



class PickupScreen extends StatelessWidget {
  final Call call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({
    @required this.call,
  });

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context,infoWidget){
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Incoming...",
                  style:TextStyle(
                      fontSize: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth* 0.048:infoWidget.screenWidth * 0.032,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Expanded(
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(infoWidget.orientation == Orientation.portrait
                          ? 35.0:55.0)),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/user.png',
                        image:call.callerPic??'',
                        fit: BoxFit.fill,
                      ),
                    ),
                    width:  infoWidget.screenWidth * 0.60//
                    ,
                    height: infoWidget.screenWidth * 0.30,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  call.callerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.call_end),
                      color: Colors.redAccent,
                      onPressed: () async {
                        await callMethods.endCall(call: call);
                      },
                    ),
                    SizedBox(width: 25),
                    IconButton(
                      icon: Icon(Icons.call),
                      color: Colors.green,
                      onPressed: () async =>
                      await Permissions.cameraAndMicrophonePermissionsGranted()
                          ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallScreen(call: call),
                        ),
                      )
                          : {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
