import 'package:flutter/material.dart';
import 'package:healthbook/core/functions/get_device_type.dart';
import 'package:healthbook/core/models/device_info.dart';


class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;

  const InfoWidget({Key key, this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        var mediaQueryData = MediaQuery.of(context);
        var deviceInfo = DeviceInfo(
          orientation: mediaQueryData.orientation,
          deviceType: getDeviceType(mediaQueryData),
          screenWidth: mediaQueryData.size.width,
          screenHeight: mediaQueryData.size.height,
          localHeight: constrains.maxHeight,
          localWidth: constrains.maxWidth,
          title: TextStyle(fontSize: mediaQueryData.size.width*0.06,color: Colors.black),
          subTitle: TextStyle(fontSize: mediaQueryData.size.width*0.03,color: Colors.black45),
          defaultVerticalPadding:  mediaQueryData.size.width*0.009,
          defaultHorizontalPadding: mediaQueryData.size.height*0.01
        );
        return builder(context, deviceInfo);
      },
    );
  }
}
