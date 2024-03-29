import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import 'ShowImage.dart';
class AddRadiologyAndAnalysis extends StatefulWidget {
  final String type;
  final Function function;

  AddRadiologyAndAnalysis({this.type, this.function});

  @override
  _AddRadiologyAndAnalysisState createState() => _AddRadiologyAndAnalysisState();
}

class _AddRadiologyAndAnalysisState extends State<AddRadiologyAndAnalysis> {
  File _imageFile;
  String name;
  String description;
  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage(BuildContext context, ImageSource source) async {

    await _picker
        .getImage(source: source, maxWidth: 400.0)
        .then((PickedFile image) {
      if (image != null) {
        File x = File(image.path);
        setState(() {
           _imageFile = x;
           widget.function(name,description,_imageFile);
         });
      }
      Navigator.pop(context);
    });
  }
  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Pick an Image',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.04:MediaQuery.of(context).size.width * 0.03,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width*0.065:MediaQuery.of(context).size.width*0.049,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    textColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Use Camera',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.035:MediaQuery.of(context).size.width * 0.024,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _getImage(context, ImageSource.camera);
                      // Navigator.of(context).pop();
                    },
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width*0.065:MediaQuery.of(context).size.width*0.049,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    textColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Use Gallery',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.035:MediaQuery.of(context).size.width * 0.024,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _getImage(context, ImageSource.gallery);
                      // Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ]),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: widget.type == 'Radiology'?MediaQuery.of(context).size.height*0.51:MediaQuery.of(context).size.height*0.20,
          child:
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
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
                    hintText: '${widget.type == 'Radiology'?'Radiology' :'Analysis'} Name',
                  ),
                  // ignore: missing_return
                  validator: (val){
                    if(val.isEmpty){
                      return 'Invalid ${widget.type == 'Radiology'?'Radiology' :'Analysis'}';
                    }
                  },
                  onChanged: (val){
                    name = val;
                    widget.function(name,description,_imageFile);
                  },
                ),
                SizedBox(height: 8.0,),
                TextFormField(
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
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
                    hintText: 'Description of ${widget.type == 'Radiology'?'Radiology' :'Analysis'}',
                  ),
                  onChanged: (val){
                    setState(() {
                      description = val;
                      widget.function(name,description,_imageFile);
                    });
                  },
                ),
                SizedBox(height: 8.0,),
                widget.type == 'Radiology'? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue[500]),
                  ),
                  child: _imageFile == null? Center(child: Text('Image',style: TextStyle(
                      fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.035:MediaQuery.of(context).size.width * 0.024,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),),):
                  Hero(
                    tag: 'image',
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
                            ShowImage(imageURL: _imageFile,)));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(_imageFile,fit: BoxFit.fill,)
                      ),
                    ),
                  ),
                ):SizedBox(),
                widget.type == 'Radiology'?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _openImagePicker(context,);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 9.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Select Image",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width * 0.035:MediaQuery.of(context).size.width * 0.024,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.camera_alt,
                                  size: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width*0.065:MediaQuery.of(context).size.width*0.049,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),
              ],
            ),
          ),
        ),
      );
  }
}
