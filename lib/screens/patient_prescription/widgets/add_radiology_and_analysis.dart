import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import 'ShowImage.dart';
class AddRadiologyAndAnalysis extends StatefulWidget {
  String type;
  Function function;

  AddRadiologyAndAnalysis({this.type, this.function});

  @override
  _AddRadiologyAndAnalysisState createState() => _AddRadiologyAndAnalysisState();
}

class _AddRadiologyAndAnalysisState extends State<AddRadiologyAndAnalysis> {
  File _imageFile;
  String name;
  String description;
  String imgUrl;
  Future<void> _getImage(BuildContext context, ImageSource source) async {
    await ImagePicker.pickImage(source: source, maxWidth: 400.0)
        .then((File image) async {
     try{
//       StorageReference storageReference = FirebaseStorage.instance
//           .ref()
//           .child('profiles/${basename(image.path)}}');
//       StorageUploadTask uploadTask = storageReference.putFile(image);
//       await uploadTask.onComplete;
//       storageReference.getDownloadURL().then((fileURL) {
//         setState(() {
//           _imageFile = image;
//           imgUrl = fileURL;
//           widget.function(name,description,imgUrl);
//         });
//       });
       Navigator.pop(context);
     }catch(e){
       Toast.show("Please Try Again", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
     }
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
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red),
              ),
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
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    textColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Use Camera',
                      style: TextStyle(color: Colors.white),
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
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    textColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Use Gallery',
                      style: TextStyle(color: Colors.white),
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
          height: MediaQuery.of(context).size.height*0.51,
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
                      widget.function(name,description,imgUrl);
                    });
                  },
                ),
                SizedBox(height: 8.0,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue[500]),
                  ),
                  child: _imageFile == null? Center(child: Text('Image',style: TextStyle(color: Colors.blue,fontSize: 18),),):
                  Hero(
                    tag: 'image',
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
                            ShowImage(ImageURL: imgUrl,)));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(_imageFile,fit: BoxFit.fill,)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _openImagePicker(context,);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Select Image",
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(color: Colors.white, fontSize: 17),
                          ),
                          Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
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
