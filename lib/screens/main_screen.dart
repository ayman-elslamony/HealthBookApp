import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:healthbook/screens/drug/drugs.dart';
import 'package:healthbook/screens/specific_search/specific_search_screen.dart';
import '../list_of_infomation/list_of_information.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:toast/toast.dart';

import './chat_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_controller.dart';

import './booking_for_doctor/booking_screen.dart';
import 'clinic_info/clinic_info.dart';
import 'forget_password/forget_password.dart';
import 'forget_password/send_sms_screen.dart';
import 'home/home_for_doctor_and_patient.dart';
import 'radiology_and_analysis/radiology_and_analysis.dart';
import 'register_user_data/register_user_data.dart';
import 'user_profile/user_profile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> mainKey = GlobalKey<ScaffoldState>();
  PageController _pageController;
  bool _isDoctor=true;
  List<String> _searchList = [
    'Search in appointement',
    'Search for doctor',
    'search in history'
  ];
  String _searchContent;
  List<String> _suggestionList = List<String>();
  Auth _auth ;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _auth =Provider.of<Auth>(context, listen: false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _iconNavBar(String iconPath) {
    return Image.asset(
      iconPath,
      width: 30,
      height: 30,
      color: Colors.white,
    );
  }

  _autoSuggestion(String val) {
    if (_textEditingController.text.isEmpty) {
      _suggestionList.clear();
    } else {
      for (int i = 0; i < governorateList.length; i++) {
        print('hi');
        if (governorateList[i].toLowerCase().startsWith(val.toLowerCase())) {
          if (!_suggestionList.contains(governorateList[i])) {
            setState(() {
              _suggestionList.add(governorateList[i]);
            });
          }
        }
      }
    }
    print(_suggestionList);
  }

  Widget _drawerListTile(
      {String name,
      IconData icon = Icons.settings,
      String imgPath = 'assets/icons/home.png',
      bool isIcon = false,
      Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        dense: true,
        title: Text(
          name,
          style: Theme.of(context).textTheme.title.copyWith(fontSize: 18),
        ),
        leading: isIcon
            ? Icon(
                icon,
                color: Colors.blue,
              )
            : Image.asset(
                imgPath,
                color: Colors.blue,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _widthsize = MediaQuery.of(context).size.width;
    double _heightsize = MediaQuery.of(context).size.height;
    Stack _pageContent({Widget pageBody}) {
      return Stack(
        children: <Widget>[
          pageBody,
          Positioned(
              top: 10,
              left: _widthsize * 0.28,
              child: _suggestionList.length == 0
                  ? SizedBox(
                      height: 0.1,
                    )
                  : Material(
                      shadowColor: Colors.blueAccent,
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Container(
                          height: 55.0 * _suggestionList.length,
                          width: 200.0,
                          child: ListView.builder(
                            itemBuilder: (ctx, index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    _textEditingController.text =
                                        _suggestionList[index];
                                    _suggestionList.clear();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: ListTile(
                                    title: Text('${_suggestionList[index]}'),
                                  ),
                                )),
                            itemCount: _suggestionList.length,
                          ))))
        ],
      );
    }

    return Scaffold(
      key: mainKey,
      backgroundColor: Color(0xFFfafbff),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
            height: 45,
            child: TextFormField(
              autofocus: false,
              controller: _textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                prefixIcon: Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintStyle: TextStyle(fontSize: 14),
                hintText: _searchList[_page],
              ),
              onChanged: (String val) {
                setState(() {
                  _autoSuggestion(val);
                });
              },
            )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      size: 28,
                    ),
                    Positioned(
                        right: 2.9,
                        top: 2.8,
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      drawer: Container(
        width: _widthsize * 0.61,
        height: _heightsize,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                onDetailsPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    _page = 2;
                  });
                  _pageController.jumpToPage(_page);
                },
                accountName: Text("${_auth.userData.firstName.toUpperCase()} ${_auth.userData.lastName.toUpperCase()}"),
                accountEmail: Text("${_auth.email}"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "${_auth.userData.firstName.substring(0,1).toUpperCase()}",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              _drawerListTile(
                  name: "Home", imgPath: 'assets/icons/home.png', onTap: () {}),
              _drawerListTile(
                  name: "Clinic",
                  imgPath: 'assets/icons/clinic.png',
                  onTap: () {}),
              _drawerListTile(
                  name: "Edit Profile",
                  imgPath: 'assets/icons/profile.png',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterUserData(isEditingEnable: true,)));
                  }),
              _drawerListTile(
                  name: "Drug List",
                  isIcon: true,
                  icon: Icons.assignment,
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Drug()));
                  }),
              _drawerListTile(
                  name: "Radiology And Analysis",
                  isIcon: true,
                  icon: Icons.insert_drive_file,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RadiologyAndAnalysis()));
                  }),

              _drawerListTile(
                  name: "Switch Acount",
                  isIcon: true,
                  icon: Icons.compare_arrows,
                  onTap: () {}),
//              _drawerListTile(
//                  name: "Setting",
//                  isIcon: true,
//                  icon: Icons.settings,
//                  onTap: () {}),
              _drawerListTile(
                  name: "Log Out",
                  isIcon: true,
                  icon: Icons.exit_to_app,
                  onTap: () async{
                    await Provider.of<Auth>(context, listen: false).logout();
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 53,
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        color: Colors.blue,
        items: <Widget>[
          _page == 0
              ? _iconNavBar('assets/icons/home.png')
              : _iconNavBar('assets/icons/homename.png'),
          _page == 1
              ? _iconNavBar('assets/icons/clinic.png')
              : _iconNavBar('assets/icons/clinicname.png'),
          _page == 2
              ? _iconNavBar('assets/icons/profile.png')
              : _iconNavBar('assets/icons/profilename.png'),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
          _pageController.jumpToPage(_page);
          _textEditingController.clear();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _page = index;
            });
            _textEditingController.clear();
            final CurvedNavigationBarState navBarState =
                _bottomNavigationKey.currentState;
            navBarState.setPage(_page);
          },
          children: <Widget>[
            // Login(),
            // SendSms(),
            // ForgetPassword(),
            // PatientPrescription(),
            _pageContent(pageBody: Home()),
            Stack(
              children: <Widget>[
                _pageContent(pageBody: !_isDoctor?ClinicInfo():SpecificSearch()),
                Positioned(child:  RaisedButton(color: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),onPressed: (){
                  setState(() {
                    _isDoctor = !_isDoctor;
                  });
                },
                  child: Text(_isDoctor?'Show As Patient':'Show As Doctor',style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
                  top: 0.0,right: 0.0,)
              ],
            ),
            _pageContent(pageBody: UserProfile()),

            //UserSignUp(),

//            Booking(),
            // Home(),
          ],
        ),
      ),
    );
  }
}
