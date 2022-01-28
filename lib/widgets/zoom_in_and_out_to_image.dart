import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ShowImage extends StatelessWidget {
  final String imgUrl;
  final bool isImgUrlAsset;

  ShowImage({this.imgUrl,this.isImgUrlAsset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size:
              MediaQuery
                  .of(context)
                  .orientation == Orientation.portrait
                  ? MediaQuery
                  .of(context)
                  .size
                  .width * 0.05
                  : MediaQuery
                  .of(context)
                  .size
                  .width * 0.035,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
       ),
      body: Container(
          child: PhotoView(
            imageProvider: isImgUrlAsset?AssetImage(imgUrl):NetworkImage(imgUrl),
          )
      ),
    );
  }
}
