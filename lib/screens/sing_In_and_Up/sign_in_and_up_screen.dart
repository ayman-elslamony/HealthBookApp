import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/screens/register_user_data/register_user_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../forget_password/send_sms_screen.dart';
import '../../providers/auth_controller.dart';
import '../../models/http_exception.dart';
import '../main_screen.dart';

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
  int _selectedRadio = 1;
  Map<String, String> _loginData = {
    'email': '',
    'National ID': '',
    'password': '',
  };

  Future<void> _showErrorDialog(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(25.0))),
        contentPadding:
        EdgeInsets.only(top: 10.0),
        title: Text('An Error Occurred!',style: TextStyle(
            fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.048:MediaQuery.of(context).size.width * 0.032,
            color: Colors.blue,
            fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(child: Text(message,maxLines: 2,textAlign: TextAlign.center,style:  TextStyle(
                fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.04:MediaQuery.of(context).size.width * 0.03,
                color:Color(0xff484848),
                fontWeight: FontWeight.bold),),constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height*0.20,
              minWidth: MediaQuery.of(context).size.width*0.75,
              maxWidth: MediaQuery.of(context).size.width*0.75,
            ),),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay',style: TextStyle(
                fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.035:MediaQuery.of(context).size.width * 0.024,
                color: Colors.blue,
                fontWeight: FontWeight.bold),),
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

        print(_goToSignUp);
        if (_goToSignUp) {
          //her sign up
          String message =
              await Provider.of<Auth>(context, listen: false).signUp(
            email: _loginData['email'],
            password: _loginData['password'],
                nationalID: _loginData['National ID'],
          );
          print(message);
          if (message == 'Patient account created') {
            //when success
            message = await Provider.of<Auth>(context, listen: false).signIn(
              email: _loginData['email'],
              password: _loginData['password'],
              isCommingFromSignUp: true,
            );
            if (message == 'Auth success') {
             Toast.show('Successfully Sign Up', context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              setState(() {
                _loadingUser = false;
              });
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterUserData()));
             return;
            } else {
              Toast.show('Please Try To SignIn', context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              setState(() {
                _goToSignUp =false;
                _loadingUser = false;
              });
              return;
            }
          } else if (message == 'Mail exists') {
            _showErrorDialog('Email Already Exists Try Another Email');
            setState(() {
              _loadingUser = false;
            });
            return;
          } else {
            _showErrorDialog('Please Try Again Later');
            setState(() {
              _loadingUser = false;
            });
            return;
          }
        } else {
          //her sign in
          String message;
          if ( Provider.of<Auth>(context, listen: false).getUserType =='doctor') {
            message= await Provider.of<Auth>(context, listen: false).signIn(
                  email: _loginData['email'],
                  password: _loginData['password'],
                 );
            if (message == 'Auth success') {
              Toast.show('Successfully Sign In', context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
              setState(() {
                _loadingUser = false;
              });
              return;
            }else if(message == 'Auth failed'){
                  _showErrorDialog('Could not find a user with that email.');
                  setState(() {
                    _loadingUser = false;
                  });
            }else {
              Toast.show('Please Try Again', context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              setState(() {
                _loadingUser = false;
              });
              return;
            }
          }else {
            //is patient
            print('dxbb');
            message= await Provider.of<Auth>(context, listen: false).signIn(
              email: _loginData['email'],
              password: _loginData['password'],
            );
            print(message);
            if (message == 'Auth success') {
                Toast.show('Successfully Sign In', context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
              setState(() {
                _loadingUser = false;
              });
            } else if(message == 'Auth failed'){
              _showErrorDialog('Could not find a user with that email.');
              setState(() {
                _loadingUser = false;
              });
            }else {
              Toast.show('Please Try Again', context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              setState(() {
                _loadingUser = false;
              });
            }
          }
        }


//      on HttpException catch (error) {
//        var errorMessage = 'Authentication failed';
//        if (error.toString().contains('EMAIL_EXISTS')) {
//          errorMessage = 'This email address is already in use.';
//        } else if (error.toString().contains('INVALID_EMAIL')) {
//          errorMessage = 'This is not a valid email address';
//        } else if (error.toString().contains('WEAK_PASSWORD')) {
//          errorMessage = 'This password is too weak.';
//        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
//          errorMessage = 'Could not find a user with that email.';
//        } else if (error.toString().contains('INVALID_PASSWORD')) {
//          errorMessage = 'Invalid password.';
//        }
//        _showErrorDialog(errorMessage);
//      } catch (error) {
//        const errorMessage =
//            'Could not authenticate you. Please try again later.';
//        _showErrorDialog(errorMessage);
//      }
    } else {
      setState(() {
        _loadingUser = false;
      });
      return;
    }
  }

  onChangedRadio(val) {
    setState(() {
      _selectedRadio = val;
    });
    if (val == 1) {
      Provider.of<Auth>(context, listen: false).setUserType ='patient';

    } else {
      Provider.of<Auth>(context, listen: false).setUserType ='doctor';
    }
    print(Provider.of<Auth>(context, listen: false).getUserType);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InfoWidget(
        builder: (context , infoWidget){
          print(infoWidget.orientation);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(left:infoWidget.screenWidth*0.02 ,right: infoWidget.screenWidth*0.02, top: infoWidget.screenHeight*0.04),
              child: ListView(
                children: <Widget>[
              SizedBox(
                  width: infoWidget.screenWidth,
                  height: infoWidget.screenHeight*0.2
                  ,child: Center(child: Hero(tag: 'splash',child: Image.asset('assets/Log_in.png',fit: BoxFit.fill,width: infoWidget.orientation ==Orientation.landscape?infoWidget.localWidth*0.35:infoWidget.localWidth*0.45)))),
//                  Container(
//                    height: infoWidget.screenHeight*0.4,
//                    child: Center(
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Text(
//                                'Welcome to',
//                                style: Theme.of(context).textTheme.body1.copyWith(
//                                  fontSize: infoWidget.screenWidth*0.045
//                                ),
//                              ),
//                              ColorizeAnimatedTextKit(
//                                  totalRepeatCount: 9,
//                                  pause: Duration(milliseconds: 1000),
//                                  isRepeatingAnimation: true,
//                                  speed: Duration(seconds: 1),
//                                  text: [' Health Book '],
//                                  textStyle: TextStyle(
//                                      fontSize: 28.0, fontFamily: "Horizon"),
//                                  colors: [
//                                    Colors.grey,
//                                    Colors.blue,
//                                    Colors.black,
//                                    Colors.blue,
//                                    Colors.grey,
//                                    Colors.blue,
//                                  ],
//                                  textAlign: TextAlign.start,
//                                  alignment: AlignmentDirectional
//                                      .topStart // or Alignment.topLeft
//                              ),
//                              Text('system',style: Theme.of(context).textTheme.body1.copyWith(
//                                  fontSize: infoWidget.screenWidth*0.045
//                              ),),
//                            ],
//                          ),
//                          SizedBox(
//                            height: infoWidget.screenHeight*0.011,
//                          ),
//                          TypewriterAnimatedTextKit(
//                              totalRepeatCount: 9,
//                              pause: Duration(milliseconds: 1000),
//                              speed: Duration(seconds: 1),
//                              isRepeatingAnimation: true,
//                              textAlign: TextAlign.center,
//                              alignment: AlignmentDirectional.topCenter,
//                              text: ['Health Book'],
//                              textStyle: Theme.of(context).textTheme.body2),
//                        ],
//                      ),
//                    ),
//                  ),

                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(infoWidget.screenWidth*0.02),
                      child: Column(
                        children: <Widget>[
                          _goToSignUp
                              ?SizedBox(
                            height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.08:infoWidget.screenHeight*0.14,
                                child: TextFormField(
                            autofocus: false,
                            style: TextStyle(
                                fontSize: infoWidget.orientation ==Orientation.portrait?infoWidget.screenWidth*0.04:infoWidget.screenWidth*0.035
                            ),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.new_releases),
//                                  labelStyle: TextStyle(
//
//                                  ),
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
                                labelText: 'National ID',
                            ),
                            keyboardType: TextInputType.emailAddress,
// ignore: missing_return
                            validator: (String val) {
                                if (val.trim().isEmpty || val.trim().length != 14) {
                                  return 'Please enter National ID';
                                }
                                if (val.trim().length != 14) {
                                  return 'Invalid National ID';
                                }
                            },
                            onSaved: (value) {
                                _loginData['National ID'] = value.trim();
                            },
                            onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(_emailNode);
                            },
                          ),
                              ):SizedBox(),
                          _goToSignUp
                              ?SizedBox(
                            height: infoWidget.screenHeight*0.02,
                          ):SizedBox(),
                          SizedBox(
                            height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.08:infoWidget.screenHeight*0.14,
                            child: TextFormField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              focusNode: _emailNode,
                              style: TextStyle(
                                  fontSize: infoWidget.orientation ==Orientation.portrait?infoWidget.screenWidth*0.04:infoWidget.screenWidth*0.035
                              ),
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
                              ),
                              keyboardType: TextInputType.emailAddress,
// ignore: missing_return
                              validator: (value) {
                                print(value);
                                if (value.trim().isEmpty) {
                                  return "Please enter your email";
                                }
                                if (!(value.contains("@"))) {
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
                          ),
                          SizedBox(
                            height: infoWidget.screenHeight*0.02,
                          ),
                          SizedBox(
                            height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.08:infoWidget.screenHeight*0.14,
                            child: TextFormField(
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: infoWidget.orientation ==Orientation.portrait?infoWidget.screenWidth*0.04:infoWidget.screenWidth*0.035
                              ),
                              textInputAction: _goToSignUp
                                  ? TextInputAction.next
                                  : TextInputAction.done,
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
                                if (value.trim().isEmpty ||
                                    value.trim().length < 1) {
                                  return 'Password is too short!';
                                }
                              },
                              onSaved: (_) {
                                _passwordNode.unfocus();
                              },
                              onChanged: (value) {
                                _loginData['password'] = value.trim();
                              },
                              onFieldSubmitted:(val){
                                if(_goToSignUp){
                                  _passwordNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_confirmPassNode);
                                }else{
                                  _passwordNode.unfocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: infoWidget.screenHeight*0.02,
                          ),
                          _goToSignUp
                              ? SizedBox(
                            height: infoWidget.orientation ==Orientation.portrait?infoWidget.screenHeight*0.08:infoWidget.screenHeight*0.14,
                                child: TextFormField(
                            autofocus: false,
                                  style: TextStyle(
                                      fontSize: infoWidget.orientation ==Orientation.portrait?infoWidget.screenWidth*0.04:infoWidget.screenWidth*0.035
                                  ),
                            textInputAction: TextInputAction.done,
                            focusNode: _confirmPassNode,
                            obscureText: true,
                            decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_open),
                                  filled: true,
                                  fillColor: Colors.white,
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.blue),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.blue),
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
                            onSaved: (_) {
                                _confirmPassNode.unfocus();
                            },
                            onFieldSubmitted: (_) {
                                _confirmPassNode.unfocus();
                            },
                          ),
                              )
                              : SizedBox(),
//                            _goToSignUp
//                                ? SizedBox()
//                                : Padding(
//                              padding:
//                               EdgeInsets.symmetric(vertical: infoWidget.screenHeight*0.01),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.end,
//                                children: <Widget>[
//                                  InkWell(
//                                    child: Text(
//                                      'ForgetPassword?',
//                                      style: Theme.of(context)
//                                          .textTheme
//                                          .display1
//                                          .copyWith(
//                                        color: Colors.grey.shade500,
//                                        fontSize: 15,
//                                      ),
//                                    ),
//                                    onTap: () {
//                                      Navigator.of(context)
//                                          .pushNamed(SendSms.routeName);
//                                    },
//                                  ),
//                                ],
//                              ),
//                            ),
                          _goToSignUp
                              ? SizedBox():SizedBox(
                            height: infoWidget.screenHeight*0.065,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('Patient',style: TextStyle(color: _selectedRadio==1?Colors.blue:Colors.black,fontWeight: _selectedRadio==1?FontWeight.bold:FontWeight.normal,fontSize: infoWidget.orientation==Orientation.portrait? infoWidget.screenWidth*0.04:infoWidget.screenWidth*0.032,),),
                                    value: 1,
                                    groupValue: _selectedRadio,
                                    onChanged: onChangedRadio,
                                    activeColor: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                      title: Text('Doctor',style: TextStyle(color: _selectedRadio==2?Colors.blue:Colors.black,fontWeight: _selectedRadio==2?FontWeight.bold:FontWeight.normal,fontSize: infoWidget.orientation==Orientation.portrait? infoWidget.screenWidth*0.04:infoWidget.screenWidth*0.032,),),
                                      value: 2,
                                      activeColor: Colors.blue,
                                      groupValue: _selectedRadio,
                                      onChanged: onChangedRadio),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight*0.099:infoWidget.screenHeight*0.2,
                          ),
                          _loadingUser == true
                              ? CircularProgressIndicator(
                            color: Colors.blue,
                          )
                              : RaisedButton(
                            child:
                            Text(_goToSignUp ? 'SIGN UP' : 'SIGN IN',style: TextStyle(fontSize: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.044:infoWidget.screenWidth*0.035),),
                            onPressed: _submit
//                                    (){
//                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterUserData()));
//                                }
                            ,
                            //_submit,
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
                                _goToSignUp
                                    ? 'Already have acount '
                                    : 'Not Regiter? ',
                                style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                  color: Colors.grey.shade500,
                                  fontSize: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.044:infoWidget.screenWidth*0.030,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _goToSignUp = !_goToSignUp;
                                  });
                                  _formKey.currentState.reset();
                                },
                                child: Text(
                                  _goToSignUp ? 'Sign In' : 'create new account',
                                  style:
                                  Theme.of(context).textTheme.bodyText2.copyWith(
                                    decoration: TextDecoration.underline,
                                      fontSize: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.044:infoWidget.screenWidth*0.030
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
