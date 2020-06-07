import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ShowImage extends StatelessWidget {
  String imgUrl;
  bool isImgUrlAsset;

  ShowImage({this.imgUrl,this.isImgUrlAsset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(
        color: Colors.white,
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),),
      body: Container(
          child: PhotoView(
            imageProvider: isImgUrlAsset?AssetImage(imgUrl):NetworkImage(imgUrl),
          )
      ),
    );
  }
}
