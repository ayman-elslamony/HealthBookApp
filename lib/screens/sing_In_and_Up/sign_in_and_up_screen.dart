import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/screens/register_user_data/register_user_data.dart';
import 'package:provider/provider.dart';

import '../forget_password/send_sms_screen.dart';
import '../../providers/auth_controller.dart';
import '../../models/http_exception.dart';

class Login extends StatefulWidget {
  static const routeName = '/login_screen';

  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  AnimationController controller;
  Animation animation;
  bool _securePassword = true;
  bool _loadingUser = false;
  bool _goToSignUp = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPassNode = FocusNode();

  Map<String, String> _loginData = {
    'email': '',
    'password': '',
  };

  Future<bool> _signAsDocOrPat() async {
    bool userType = true;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Text(
          'Sign in As',
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    userType = true;
                  });
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/doctor.png',
                      width: 120.0,
                      height: 100.0,
                    ),
                    Text('Doctor')
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    userType = false;
                  });
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/patient.png',
                      width: 120,
                      height: 100,
                    ),
                    Text('Patient')
                  ],
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pushNamed(Login.routeName);
            },
          )
        ],
      ),
    );
    return userType;
  }

  Future<void> _showErrorDialog(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loadingUser = true;
      });
      try {
        print(_goToSignUp);
        if(_goToSignUp){
          //her sign up
          await Provider.of<Auth>(context, listen: false).signUp(
            email: _loginData['email'],
            password: _loginData['password'],
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterUserData()));
        }else{
          //her sign in
          if (_loginData['email'].contains('@doc')) {
            bool _userType = await _signAsDocOrPat();
            if (_userType) {
              await Provider.of<Auth>(context, listen: false).signIn(
                  email: _loginData['email'],
                  password: _loginData['password'],
                  userType: 'doctor');
            }else{
              await Provider.of<Auth>(context, listen: false).signIn(
                email: _loginData['email'],
                password: _loginData['password'],
              );
            }
          }
//          else if(_loginData['email'].contains('@admin')){
//            await Provider.of<Auth>(context, listen: false).signIn(email: _loginData['email'],password: _loginData['password'],userType: 'admin');
//          }
          else {
            await Provider.of<Auth>(context, listen: false).signIn(
              email: _loginData['email'],
              password: _loginData['password'],
            );
          }
        }
      } on HttpException catch (error) {
        var errorMessage = 'Authentication failed';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use.';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email address';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'This password is too weak.';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Could not find a user with that email.';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password.';
        }
        _showErrorDialog(errorMessage);
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
    } else {
      setState(() {
        _loadingUser = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Welcome to',
                          ),
                          ColorizeAnimatedTextKit(
                              totalRepeatCount: 9,
                              pause: Duration(milliseconds: 1000),
                              isRepeatingAnimation: true,
                              speed: Duration(seconds: 1),
                              text: [' Health Book '],
                              textStyle: TextStyle(
                                  fontSize: 28.0, fontFamily: "Horizon"),
                              colors: [
                                Colors.grey,
                                Colors.blue,
                                Colors.black,
                                Colors.blue,
                                Colors.grey,
                                Colors.blue,
                              ],
                              textAlign: TextAlign.start,
                              alignment: AlignmentDirectional
                                  .topStart // or Alignment.topLeft
                              ),
                          Text('system'),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TypewriterAnimatedTextKit(
                          totalRepeatCount: 9,
                          pause: Duration(milliseconds: 1000),
                          speed: Duration(seconds: 1),
                          isRepeatingAnimation: true,
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional.topCenter,
                          text: ['Health Book'],
                          textStyle: Theme.of(context).textTheme.body2),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _goToSignUp ? MediaQuery.of(context).size.height/16:MediaQuery.of(context).size.height/8,
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          focusNode: _emailNode,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'E-Mail',
                              hintText: _goToSignUp?'___@pat.com':'___@pat.com or ___@doc.com'
                          ),
                          keyboardType: TextInputType.emailAddress,
// ignore: missing_return
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "Please enter your email";
                            }
                            if(!value.trim().contains("@doc") ||!value.trim().contains("@pat") ){
                              return "Invalid email";
                            }
                          },
                          onSaved: (value) {
                            _loginData['email'] = value.trim();
                            _emailNode.unfocus();
                          },
                          onFieldSubmitted: (_) {
                            _emailNode.unfocus();
                            FocusScope.of(context).requestFocus(_passwordNode);
                          },
                        ),
                        SizedBox(
                          height: 13.0,
                        ),
                        TextFormField(
                          autofocus: false,
                          textInputAction: _goToSignUp? TextInputAction.next:TextInputAction.done,
                          focusNode: _passwordNode,
                          obscureText: _securePassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_open),
                              suffixIcon: InkWell(
                                child: Icon(_securePassword == false
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onTap: () {
                                  setState(() {
                                    _securePassword = !_securePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'Password'),

// ignore: missing_return
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.trim().isEmpty || value.trim().length < 8) {
                              return 'Password is too short!';
                            }
                          },
                          onSaved: (_){
                            _passwordNode.unfocus();
                          },
                          onChanged: (value) {
                            _loginData['password'] = value.trim();
                          },
                          onFieldSubmitted: _goToSignUp ?(_){
                            _passwordNode.unfocus();
                            FocusScope.of(context).requestFocus(_confirmPassNode);
                          }:(_) {
                            _passwordNode.unfocus();
                          },
                        ),
                       SizedBox(height: 10.0,),
                        _goToSignUp ? TextFormField(
                          autofocus: false,
                        textInputAction: TextInputAction.done,
                        focusNode: _confirmPassNode,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_open),
                            filled: true,
                            fillColor: Colors.white,
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            labelText: 'Confirm Password'),

// ignore: missing_return
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.trim() != _loginData['password']) {
                            return 'Password not identical!';
                          }
                        },
                          onSaved: (_){
                            _confirmPassNode.unfocus();
                          },
                        onFieldSubmitted: (_) {
                          _confirmPassNode.unfocus();
                        },
                      ):SizedBox(),
                        _goToSignUp ?SizedBox():Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                child: Text(
                                  'ForgetPassword?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                        color: Colors.grey.shade500,
                                        fontSize: 15,
                                      ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(SendSms.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        _loadingUser == true
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              )
                            : RaisedButton(
                                child: Text(_goToSignUp ?'SIGN UP':'SIGN IN'),
                                onPressed:(){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterUserData()));
                                }
                                  ,//_submit,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 8.0),
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    .color,
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _goToSignUp ? 'Already have acount ':'Not Regiter? ',
                              style:
                                  Theme.of(context).textTheme.display1.copyWith(
                                        color: Colors.grey.shade500,
                                        fontSize: 15.5,
                                      ),
                            ),
                            InkWell(
                              onTap:() {
                                setState(() {
                                  _goToSignUp = !_goToSignUp;
                                });
                                _formKey.currentState.reset();
                              },
                              child: Text(
                                _goToSignUp? 'Sign In':'create new account',
                                style:
                                    Theme.of(context).textTheme.body2.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 18,
                                        ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
