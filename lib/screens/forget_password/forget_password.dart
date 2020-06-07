import 'package:flutter/material.dart';

import '../main_screen.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = 'ForgetPassword';

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _confirmPassNode = FocusNode();
  bool _securePassword = true;
  String _newPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Container(
                  height: 50,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
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
                        labelText: 'Password'),
// ignore: missing_return
                    validator: (value) {
                      if (value.length < 8) {
                        return 'Password is too short!';
                      } else if (value.isEmpty) {
                        return 'Invalid password!';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _newPassword = value;
                      });
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        _newPassword = value;
                      });
                      FocusScope.of(context).requestFocus(_confirmPassNode);
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    focusNode: _confirmPassNode,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open),
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
                        labelText: 'Confirm Password'),
// ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty || value != _newPassword) {
                        return 'Password not identical!';
                      } else if (value.isEmpty) {
                        return 'Invalid password!';
                      }
                    },
                    onFieldSubmitted: (_) {
                      _confirmPassNode.unfocus();
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    height: 40,
                    width: 170,
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
                      child: const Text(
                        'Change Password',
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
            ),
          ),
        ),
      ),
    );
  }
}
