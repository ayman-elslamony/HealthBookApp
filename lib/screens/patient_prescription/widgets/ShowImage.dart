import 'dart:io';

import 'package:flutter/material.dart';


class ShowImage extends StatelessWidget {
  final File imageURL;

  ShowImage({this.imageURL});

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
            ,child: Image.file(imageURL,fit: BoxFit.fill,)),
      ),
    );
  }
}
