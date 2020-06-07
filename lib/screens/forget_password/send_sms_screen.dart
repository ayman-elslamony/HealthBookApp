import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './forget_password.dart';

class SendSms extends StatefulWidget {
  static const routeName = 'sendSMS';

  @override
  _SendSmsState createState() => _SendSmsState();
}

class _SendSmsState extends State<SendSms> {
  int _timerValue = 59;
  final Stream<int> _periodicStream =
  Stream.periodic(Duration(milliseconds: 1000), (i) => i);
  int _previousStreamValue = 0;
  String _a;
  String _b;
  String _c;
  String _d;
  String _e;
  final FocusNode _aNode = FocusNode();
  final FocusNode _bNode = FocusNode();
  final FocusNode _cNode = FocusNode();
  final FocusNode _dNode = FocusNode();
  final FocusNode _eNode = FocusNode();

  Widget _createTextForm(
      {String val, FocusNode currentNode, FocusNode nextNode}) {
    return Container(
      height: 60,
      width: 40,
      child: TextFormField(
        focusNode: currentNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction:
        currentNode != _eNode ? TextInputAction.next : TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorStyle: TextStyle(color: Colors.blue),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: (value) {
          val = value.trim();
          if (value.length == 1) {
            currentNode.unfocus();
            if (currentNode != _eNode) {
              FocusScope.of(context).requestFocus(nextNode);
            }
          }
        },
        onFieldSubmitted: (_) {
          currentNode.unfocus();
          if (currentNode != _eNode) {
            FocusScope.of(context).requestFocus(nextNode);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const FittedBox(
                child: Text(
                  'You will recieve 5-digits code on your number',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                '01145523795',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.20,
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {

                        },
                        child: const Text(
                          'Resend SMS',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      StreamBuilder(
                        stream: this._periodicStream,
                        builder: (context, AsyncSnapshot<int> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != _previousStreamValue) {
                              if (this._timerValue > 0) {
                                this._timerValue--;
                              }
                            }
                          }
                          return Text(
                            '0:$_timerValue',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _createTextForm(
                          val: _a, currentNode: _aNode, nextNode: _bNode),
                      _createTextForm(
                          val: _b, currentNode: _bNode, nextNode: _cNode),
                      _createTextForm(
                          val: _c, currentNode: _cNode, nextNode: _dNode),
                      _createTextForm(
                          val: _d, currentNode: _dNode, nextNode: _eNode),
                      _createTextForm(
                          val: _e, currentNode: _eNode, nextNode: _eNode),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ForgetPassword.routeName);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue,
                              blurRadius: 10.0,
                              // has the effect of softening the shadow
                              spreadRadius:
                              1.0, // has the effect of extending the shadow
                            )
                          ],
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Center(
                        child: Text(
                          'Next',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
