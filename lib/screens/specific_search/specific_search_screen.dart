import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/specific_search/map.dart';
import 'package:healthbook/screens/specific_search/search_result.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import './search_card.dart';
import '../../list_of_infomation/list_of_information.dart';

class SpecificSearch extends StatefulWidget {
  final bool useFilter;

  SpecificSearch({this.useFilter=false});

  @override
  _SpecificSearchState createState() => _SpecificSearchState();
}

class _SpecificSearchState extends State<SpecificSearch> {
  String _drName = '';
  bool isLoading = false;
  String _location = '';
  TextEditingController _locationTextEditingController =
      TextEditingController();
  bool _isEditLocationEnable = false;
  bool _selectUserLocationFromMap = false;
  FocusNode _governorateFocusNode = FocusNode();

  String _specialty;

  String _governorate;
  Auth _auth;

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<Auth>(context, listen: false);
  }
 Future<bool> getSearchResult() async {

    bool x=await _auth.getAllSearchResult(
        name: _drName,
        speciality: _specialty,
        governorate: _governorate,
      );
      setState(() {
        isLoading = false;
      });
      return x;

  }
  Future<void> _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
//      _accountData['lat'] = position.latitude.toString();
//      _accountData['long'] = position.longitude.toString();
    if (addresses.isNotEmpty) {
      setState(() {
        _locationTextEditingController.text = addresses.first.addressLine;
        _isEditLocationEnable = true;
        _selectUserLocationFromMap = !_selectUserLocationFromMap;
      });
      Navigator.of(context).pop();
    }
  }

  void selectLocationFromTheMap(String address, double lat, double long) {
    setState(() {
      _locationTextEditingController.text = address;
    });
    _location = address;
//      _accountData['lat'] = lat.toString();
//      _accountData['long'] = long.toString();
  }

  void selectUserLocationType() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Text(
          'Location',
          textAlign: TextAlign.center,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: _getUserLocation,
                  child: Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Get current Location',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => GetUserLocation(
                              getAddress: selectLocationFromTheMap,
                            )));
                    setState(() {
                      _isEditLocationEnable = true;
                      _selectUserLocationFromMap = !_selectUserLocationFromMap;
                    });
                  },
                  child: Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      type: MaterialType.card,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select Location from Map',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  _getSpecialtySelected(String x) {
    _specialty = x;
    print(x);
    print(_specialty);
  }

  _getGovernorateSelected(String x) {
    _governorate = x;
    print(x);
    print(_governorate);
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, infoWidget) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: infoWidget.defaultVerticalPadding*5,
                ),
                Container(
                  height: infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight*0.075:infoWidget.screenHeight*0.14,
                  child: TextFormField(
                    style: infoWidget.subTitle,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Dr /name',
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
                    ),
                    keyboardType: TextInputType.text,
// ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty || value.length < 2) {
                        return "Invalid Dr Name!";
                      }
                    },
                    onChanged: (value) {
                      _drName = value.trim();
                    },
                    onFieldSubmitted: (_) {
                      print(_specialty);
                      print(_governorate);
                      FocusScope.of(context)
                          .requestFocus(_governorateFocusNode);
                    },
                  ),
                ),
//                SizedBox(
//                  height: infoWidget.screenHeight*0.03,
//                ),
//                InkWell(
//                    onTap: selectUserLocationType,
//                    child: Container(
//                      padding: EdgeInsets.symmetric(vertical: 7.0),
//                      height: infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight*0.099:infoWidget.screenHeight*0.2,
//                      child: TextFormField(
//                        style: infoWidget.subTitle,
//                        controller: _locationTextEditingController,
//                        textInputAction: TextInputAction.done,
//                        enabled: _isEditLocationEnable,
//                        decoration: InputDecoration(
//                          suffixIcon: InkWell(
//                            onTap: selectUserLocationType,
//                            child: Icon(
//                              Icons.my_location,
//                              size: 20,
//                              color: Colors.blue,
//                            ),
//                          ),
//                          labelText: 'Location',
//                          focusedBorder: OutlineInputBorder(
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(10.0)),
//                            borderSide: BorderSide(
//                              color: Colors.blue,
//                            ),
//                          ),
//                          disabledBorder: OutlineInputBorder(
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(10.0)),
//                            borderSide: BorderSide(
//                              color: Colors.blue,
//                            ),
//                          ),
//                          errorBorder: OutlineInputBorder(
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(10.0)),
//                            borderSide: BorderSide(
//                              color: Colors.blue,
//                            ),
//                          ),
//                          enabledBorder: OutlineInputBorder(
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(10.0)),
//                            borderSide: BorderSide(color: Colors.blue),
//                          ),
//                        ),
//                        keyboardType: TextInputType.text,
//                      ),
//                    )),
                SpecialtyAndGovernrateCard(
                  name: 'Specialty',
                  listData: listSpecialty,
                  selected: _getSpecialtySelected,
                ),
                SpecialtyAndGovernrateCard(
                  name: 'Governorate',
                  listData: governorateList,
                  selected: _getGovernorateSelected,
                ),
                isLoading?Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircularProgressIndicator(backgroundColor: Colors.blue,),
                ):InkWell(
                  onTap: () async{
                    print(_drName);
                    print(_specialty);
                    print(_governorate);
                    if(_drName != ''){
                      setState(() {
                        isLoading =true;
                      });
                      bool x = await getSearchResult();
                      if(x){
                        if(widget.useFilter){
                          Navigator.of(context).pop();
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchResult(function: getSearchResult,)));
                        }
                      }else{
                        Toast.show('Not found any doctor', context);
                      }

                    }else if(_specialty !=null){
                      setState(() {
                        isLoading =true;
                      });
                      bool x = await getSearchResult();
                      if(x){
                        if(widget.useFilter){
                          Navigator.of(context).pop();
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchResult(function: getSearchResult,)));
                        }
                      }else{
                        Toast.show('Not found any doctor', context);
                      }
                    }else if(_governorate !=null){
                      setState(() {
                        isLoading =true;
                      });
                      bool x = await getSearchResult();
                      if(x){
                        if(widget.useFilter){
                          Navigator.of(context).pop();
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchResult(function: getSearchResult,)));
                        }
                      }else{
                        Toast.show('Not found any doctor', context);
                      }
                    }else{
                      Toast.show('Invalid search', context);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Search',
                              textAlign: TextAlign.center,
                              style: infoWidget.titleButton.copyWith(fontWeight: FontWeight.w500)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
