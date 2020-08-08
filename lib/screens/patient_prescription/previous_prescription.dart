import 'package:flutter/material.dart';
import 'package:healthbook/core/models/device_info.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:healthbook/screens/drugs_radiology_analysis/drugs_radiology_analysis.dart';
import 'package:healthbook/widgets/zoom_in_and_out_to_image.dart';
import 'package:provider/provider.dart';

class PreviousPrescription extends StatefulWidget {
final String patientId;

PreviousPrescription({this.patientId});

@override
  _PreviousPrescriptionState createState() => _PreviousPrescriptionState();
}

class _PreviousPrescriptionState extends State<PreviousPrescription> {

  bool isLoading = true;
  Auth _auth;

  @override
  void initState() {

    _auth = Provider.of<Auth>(context, listen: false);
    getPrescriptionForSpecificDoctor();
    super.initState();
  }

  getPrescriptionForSpecificDoctor() async {
    await _auth.getPrescriptionForSpecificDoctor(
        patientId: widget.patientId);
    setState(() {
      isLoading = false;
    });
  }

  Widget _showMedicine(
      {DeviceInfo infoWidget, int indexForPrescription}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: infoWidget.defaultVerticalPadding,
              left: infoWidget.defaultHorizontalPadding),
          child: Row(
            children: <Widget>[
              Text(
                'Medicine: ',
                style: infoWidget.subTitle.copyWith(
                  color: Colors.black,
                  //fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
        _auth.allPrescriptionsForSpecificDoctor[indexForPrescription].allMedicine.length==0?Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'There is no  Medicine',
            style: infoWidget.titleButton.copyWith(color: Colors.blue),
          ),
        ):
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, indexForMedicine) => Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 9.0),
                        child: Text(
                          '${indexForMedicine + 1}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _auth.allPrescriptionsForSpecificDoctor[
              indexForPrescription]
                  .allMedicine[indexForMedicine]=='' ||
    _auth.allPrescriptionsForSpecificDoctor[
              indexForPrescription]
                  .allMedicine[indexForMedicine]==null ?SizedBox():Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Name:',
                                style: infoWidget.subTitle
                                    .copyWith(color: Colors.blue)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      _auth.allPrescriptionsForSpecificDoctor[
                                      indexForPrescription]
                                          .allMedicine[indexForMedicine],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                      style: infoWidget.subTitle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Dosage:',
                                  style: infoWidget.subTitle
                                      .copyWith(color: Colors.blue)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      _auth.allPrescriptionsForSpecificDoctor[
                                      indexForPrescription]
                                          .allDosage[indexForMedicine],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                      style: infoWidget.subTitle
                                          .copyWith(color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          itemCount: _auth.allPrescriptionsForSpecificDoctor[indexForPrescription].allMedicine.length,
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  Widget contentOfRadiologyAndAnalysis(
      {bool isAnalysis = true,
        DeviceInfo infoWidget,
        int indexForPrescription}) {
//    List x = isAnalysis
//        ?  _auth.allDoctorsInEachDosage[indexForDoctors]
//        .allPrescription[indexForPrescription]
//        .allMedicine[indexForMedicine][indexForPrescription]
//            .allAnalysis
//        : widget
//            .allDrugList[widget.indexForDrugList]
//            .allDoctorsInEachDosage[indexForDoctors]
//            .allPrescription[indexForPrescription]
//            .allRadiology;
    if(isAnalysis == false){
      if(_auth.allPrescriptionsForSpecificDoctor[indexForPrescription].radioName ==
          '' ||
          _auth.allPrescriptionsForSpecificDoctor[indexForPrescription].radioImage ==
              ''){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'There is no  Radiology',
            style: infoWidget.titleButton.copyWith(color: Colors.blue),
          ),
        );
      }else
        return  Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color:
                    Colors.blue)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: infoWidget.defaultVerticalPadding,
                        left: infoWidget.defaultHorizontalPadding),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Radiology: ',
                          style: infoWidget.titleButton.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Divider(
                      color:
                      Colors.blue,
                      height: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color:  Colors.blue),
                          ),
                          child: Column(
                            children: <Widget>[
                              _auth.allPrescriptionsForSpecificDoctor[
                              indexForPrescription]
                                  .radioImage ==
                                  ''
                                  ? SizedBox()
                                  : InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowImage(
                                                imgUrl:_auth.allPrescriptionsForSpecificDoctor[
                                                indexForPrescription]
                                                    .radioImage,
                                                isImgUrlAsset:
                                                false,
                                              )));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                      Radius.circular(15.0),
                                      topRight:
                                      Radius.circular(15.0)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                    'assets/patient.png',
                                    image: _auth.allPrescriptionsForSpecificDoctor[
                                    indexForPrescription]
                                        .radioImage,
                                    fit: BoxFit.fill,
                                    width: infoWidget.screenWidth,
                                    height: infoWidget
                                        .orientation ==
                                        Orientation.portrait
                                        ? infoWidget.screenHeight *
                                        0.2
                                        : infoWidget.screenHeight *
                                        0.3,
                                  ),
                                ),
                              ),
                              _auth.allPrescriptionsForSpecificDoctor[
                              indexForPrescription]
                                  .radioName ==
                                  ''
                                  ? SizedBox()
                                  : Padding(
                                padding: EdgeInsets.only(
                                    top: infoWidget
                                        .defaultVerticalPadding,
                                    left: infoWidget
                                        .defaultHorizontalPadding),
                                child: Row(
                                  children: <Widget>[
                                    Text('Name:',
                                        style: infoWidget
                                            .subTitle
                                            .copyWith(
                                            color:  Colors
                                                .blue)),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              _auth.allPrescriptionsForSpecificDoctor[
                                              indexForPrescription]
                                                  .radioName,
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              maxLines: 6,
                                              style: infoWidget
                                                  .subTitle
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _auth.allPrescriptionsForSpecificDoctor[
                              indexForPrescription]
                                  .radioDesc ==
                                  ''
                                  ? SizedBox()
                                  : Padding(
                                padding: EdgeInsets.only(
                                    top: infoWidget
                                        .defaultVerticalPadding,
                                    left: infoWidget
                                        .defaultHorizontalPadding),
                                child: Row(
                                  children: <Widget>[
                                    Text('Description:',
                                        style: infoWidget
                                            .subTitle
                                            .copyWith(
                                            color: Colors
                                                .blue)),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              _auth.allPrescriptionsForSpecificDoctor[
                                              indexForPrescription]
                                                  .radioDesc,
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              maxLines: 6,
                                              style: infoWidget
                                                  .subTitle
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: infoWidget.defaultVerticalPadding,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
    }
    else{
      if(_auth.allPrescriptionsForSpecificDoctor[indexForPrescription].radioName ==
          '' ||
          _auth.allPrescriptionsForSpecificDoctor[indexForPrescription].radioImage ==
              ''){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'There is no Analysis',
            style: infoWidget.titleButton.copyWith(color: Colors.blue),
          ),
        );
      }else {
        return  Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color:
                    Colors.grey )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: infoWidget.defaultVerticalPadding,
                        left: infoWidget.defaultHorizontalPadding),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Analysis: ',
                          style: infoWidget.titleButton.copyWith(
                              color: isAnalysis == true
                                  ? Colors.grey[600]
                                  : Colors.blue,
                              fontWeight: FontWeight.w600
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Divider(
                      color:
                      isAnalysis == true ? Colors.grey : Colors.blue,
                      height: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.grey
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              _auth.allPrescriptionsForSpecificDoctor[
                              indexForPrescription]
                                  .analysisName ==
                                  ''
                                  ? SizedBox()
                                  : Padding(
                                padding: EdgeInsets.only(
                                    top: infoWidget
                                        .defaultVerticalPadding,
                                    left: infoWidget
                                        .defaultHorizontalPadding),
                                child: Row(
                                  children: <Widget>[
                                    Text('Name:',
                                        style: infoWidget
                                            .subTitle
                                            .copyWith(
                                            color:  Colors.grey[
                                            600]
                                        )),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              _auth.allPrescriptionsForSpecificDoctor[
                                              indexForPrescription]
                                                  .analysisName
                                              ,
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              maxLines: 6,
                                              style: infoWidget
                                                  .subTitle
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _auth.allPrescriptionsForSpecificDoctor[
                              indexForPrescription]
                                  .analysisDesc ==
                                  ''
                                  ? SizedBox()
                                  : Padding(
                                padding: EdgeInsets.only(
                                    top: infoWidget
                                        .defaultVerticalPadding,
                                    left: infoWidget
                                        .defaultHorizontalPadding),
                                child: Row(
                                  children: <Widget>[
                                    Text('Description:',
                                        style: infoWidget
                                            .subTitle
                                            .copyWith(
                                            color: Colors.grey[
                                            600]
                                        )),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              _auth.allPrescriptionsForSpecificDoctor[
                                              indexForPrescription]
                                                  .analysisDesc
                                              ,
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              maxLines: 6,
                                              style: infoWidget
                                                  .subTitle
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: infoWidget.defaultVerticalPadding,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context,infoWidget){
        return isLoading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.blue)),
          ],
        )
            : Consumer<Auth>(
          builder: (context,data,_){
            if(data.allPrescriptionsForSpecificDoctor.length == 0){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('There in no any prescription yet',style: infoWidget.titleButton.copyWith(color: Colors.blue),maxLines: 3,),
                      ],
                    ),
                  )
                ],
              );
            }
            else{
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, indexForPrescription) =>
                      Padding(
                        padding: EdgeInsets.only(
                            left: infoWidget.defaultHorizontalPadding,
                            right:
                            infoWidget.defaultHorizontalPadding,
                            bottom:
                            infoWidget.defaultVerticalPadding,top: infoWidget.defaultVerticalPadding),
                        child: Material(
                          shadowColor: Colors.blueAccent,
                          color: data.allPrescriptionsForSpecificDoctor[
                          indexForPrescription]
                              .showPrescriptionGet
                              ? Colors.white
                              : Colors.blue,
                          elevation: data.allPrescriptionsForSpecificDoctor[
                          indexForPrescription]
                              .showPrescriptionGet
                              ? 2
                              : 1.0,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          type: MaterialType.card,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        data.allPrescriptionsForSpecificDoctor[
                                        indexForPrescription]
                                            .showPrescriptionSet =
                                        !data.allPrescriptionsForSpecificDoctor[
                                        indexForPrescription]
                                            .showPrescriptionGet;
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child:
                                          SingleChildScrollView(
                                            scrollDirection:
                                            Axis.horizontal,
                                            child: Text(
                                                data.allPrescriptionsForSpecificDoctor[
                                                indexForPrescription]
                                                    .prescriptionNumber,
                                                maxLines: 1,
                                                style: infoWidget
                                                    .titleButton
                                                    .copyWith(
                                                  color: data.allPrescriptionsForSpecificDoctor[
                                                  indexForPrescription]
                                                      .showPrescriptionGet
                                                      ? Colors.blue
                                                      : Colors.white,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                            data.allPrescriptionsForSpecificDoctor[
                                            indexForPrescription]
                                                .prescriptionDate,
                                            style: infoWidget
                                                .titleButton
                                                .copyWith(
                                              color: data.allPrescriptionsForSpecificDoctor[
                                              indexForPrescription]
                                                  .showPrescriptionGet
                                                  ? Colors.grey
                                                  : Colors.white,
                                            )),
                                        Icon(
                                          data.allPrescriptionsForSpecificDoctor[
                                          indexForPrescription]
                                              .showPrescriptionGet
                                              ? Icons
                                              .keyboard_arrow_up
                                              : Icons
                                              .keyboard_arrow_down,
                                          size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.058:infoWidget.screenWidth*0.042,
                                        ),
                                      ],
                                    )),
                              ),
                              data.allPrescriptionsForSpecificDoctor[
                              indexForPrescription]
                                  .showPrescriptionGet
                                  ? Divider(
                                color: Colors.grey,
                                height: 1,
                              )
                                  : SizedBox(),
                              data.allPrescriptionsForSpecificDoctor[
                              indexForPrescription]
                                  .showPrescriptionGet
                                  ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: infoWidget
                                          .defaultVerticalPadding,
                                      left: infoWidget
                                          .defaultHorizontalPadding,
                                      right: infoWidget
                                          .defaultHorizontalPadding,
                                      top: infoWidget
                                          .defaultVerticalPadding),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: infoWidget.defaultVerticalPadding,
                                            left: infoWidget.defaultHorizontalPadding),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Description of Diagnose: ',
                                              style: infoWidget.subTitle.copyWith(
                                                color: Colors.black,
                                                //fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              data.allPrescriptionsForSpecificDoctor[indexForPrescription].diagnoseDescription,
                                              style: infoWidget.subTitle.copyWith(
                                                //fontWeight: FontWeight.w500
                                              ),
                                            ),)

                                          ],
                                        ),
                                      ),
                                      _showMedicine(
                                          infoWidget: infoWidget,
                                          indexForPrescription:
                                          indexForPrescription),
                                      Column(
                                        children: <Widget>[
                                          contentOfRadiologyAndAnalysis(
                                              infoWidget: infoWidget,
                                              isAnalysis: false,
                                              indexForPrescription:
                                              indexForPrescription),
                                          contentOfRadiologyAndAnalysis(
                                              infoWidget: infoWidget,
                                              indexForPrescription:
                                              indexForPrescription),
                                        ],
                                      )
                                    ],
                                  )
                              )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                  itemCount: data.allPrescriptionsForSpecificDoctor
                      .length,
                ),
              );
            }
          },
        );
      },
    );
  }
}
