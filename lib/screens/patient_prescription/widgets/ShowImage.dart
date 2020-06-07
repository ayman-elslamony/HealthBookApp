import 'package:flutter/material.dart';


class ShowImage extends StatelessWidget {
  String ImageURL;

  ShowImage({this.ImageURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
     ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Hero(
            tag: 'image'
            ,child: Image.network(ImageURL,fit: BoxFit.fill,)),
      ),
    );
  }
}
