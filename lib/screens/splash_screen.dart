import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: <Widget>[
          Expanded(
            child: Container(
                child: Center(child: Image.asset('assets/Log_in.png',fit: BoxFit.fill,width: MediaQuery.of(context).size.width*0.50))),
          ),
        ],
      ),
    );
  }
}
