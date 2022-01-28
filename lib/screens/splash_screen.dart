import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context ,infoWidget)=>Scaffold(
        body:
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Center(child: Hero(tag: 'splash',child: Image.asset('assets/Log_in.png',fit: BoxFit.fill,width: infoWidget.orientation ==Orientation.landscape?infoWidget.localWidth*0.35:infoWidget.localWidth*0.45)))),
            ),
          ],
        ),
      ),
    );
  }
}
