import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthbook/screens/specific_search/map.dart';

class EditAddress extends StatefulWidget {
  final String address;
  final Function getAddress;

  EditAddress({this.getAddress,this.address});

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  bool _isEditLocationEnable = false;
  bool _selectUserLocationFromMap = false;
  TextEditingController _locationTextEditingController = TextEditingController();
  Future<String> _getLocation() async {
    Position position = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var addresses =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    return addresses.first.street;
  }

  void _getUserLocation() async {
    var address = await _getLocation();
    widget.getAddress(address);
    setState(() {
      _locationTextEditingController.text = address;
      _isEditLocationEnable = true;
      _selectUserLocationFromMap = !_selectUserLocationFromMap;
    });
    Navigator.of(context).pop();
  }

  void selectLocationFromTheMap(String addresss, double lat, double long) {
    setState(() {
      _locationTextEditingController.text = addresss;
    });
    widget.getAddress(addresss);
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
  @override
  void initState() {
    if(widget.address !=null){
      _locationTextEditingController.text= widget.address;
      _isEditLocationEnable = true;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: selectUserLocationType,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.0),
          height: 80,
          child: TextFormField(
            autofocus: false,
            style: TextStyle(fontSize: 15),
            controller: _locationTextEditingController,
            textInputAction: TextInputAction.done,
            enabled: _isEditLocationEnable,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: selectUserLocationType,
                child: Icon(
                  Icons.my_location,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
              labelText: 'Location',
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
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
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
            ),
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
// ignore: missing_return
            validator: (String val) {
              if (val.trim().isEmpty) {
                return 'Invalid Location';
              }
            },
          ),
        ));
  }
}
