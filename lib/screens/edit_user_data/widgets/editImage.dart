


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditImage extends StatefulWidget {
   String imgUrl;
final Function getImageFile;
  EditImage({this.imgUrl,this.getImageFile});

  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  final ImagePicker _picker = ImagePicker();
  File _imageFile;
  Future<void> _getImage(ImageSource source) async {
    await _picker
        .getImage(source: source, maxWidth: 400.0)
        .then((PickedFile image) {
      if (image != null) {
        File x = File(image.path);
        widget.getImageFile(x);
        setState(() {
          widget.imgUrl =null;
          _imageFile = x;
        });
        Navigator.pop(context);
      }
    });
  }

  void _openImagePicker() {
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
                      _getImage(ImageSource.camera);
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
                      _getImage(ImageSource.gallery);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween
      ,children: <Widget>[InkWell(
      onTap: () {
        _openImagePicker();
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
                  .subtitle1
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
      Container(
        width: 100,
        height: 100,
        child: ClipRRect(
          //backgroundColor: Colors.white,
          //backgroundImage:
          borderRadius: BorderRadius.circular(50),
          child: widget.imgUrl !=null? FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              placeholder: 'assets/user.png',
              image: widget.imgUrl):_imageFile == null
              ? Image.asset('assets/user.png',fit: BoxFit.fill,)
              : Image.file(_imageFile,fit: BoxFit.fill,),
        ),
      ),],
    );
  }
}
