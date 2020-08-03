import 'package:flutter/material.dart';
import 'package:healthbook/core/models/device_info.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/screens/drugs_radiology_analysis/drugs_radiology_analysis.dart';
import 'package:healthbook/widgets/zoom_in_and_out_to_image.dart';

class PreviousPrescription extends StatefulWidget {

  @override
  _PreviousPrescriptionState createState() => _PreviousPrescriptionState();
}

class _PreviousPrescriptionState extends State<PreviousPrescription> {

  List<Prescription> allPrescription = [
    Prescription(
        prescriptionDate: '12-1-2020',
        prescriptionName: 'Prescription One',
        allMedicine: [
          Medicine(
              medicineName: 'panadol extra',
              medicineDosage: 'each 4 hour'),
          Medicine(
              medicineName: 'extramol',
              medicineDosage: 'each 12 hour'),
        ],
        allAnalysis: [
          RadiologyAndAnalysisStructure(
              name: 'dfn',
              description: 'fedg etet tt',
              image:
              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
          RadiologyAndAnalysisStructure(
              name: 'ggg',
              description: 'fgdtet dgtt',
              image:
              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
        ],
        allRadiology: [
          RadiologyAndAnalysisStructure(
              name: 'drttrn',
              description: 'feazg ett',
              image:
              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
          RadiologyAndAnalysisStructure(
              name: 'giuoig',
              description: 'fgqqet dgtt',
              image:
              'https://www.mediclinicinfohub.co.za/wp-content/uploads/2018/10/GettyImages-769782917_Facebook.jpg'),
        ]),
    Prescription(
        prescriptionDate: '8-11-2020',
        prescriptionName: 'Prescription two',
        allMedicine: [
          Medicine(
              medicineName: 'novadol',
              medicineDosage: 'each 24 hour'),
          Medicine(
              medicineName: 'omega3',
              medicineDosage: 'each 12 hour'),
        ]),
    Prescription(
        prescriptionDate: '2-1-2020',
        prescriptionName: 'Prescription three',
        allMedicine: [
          Medicine(
              medicineName: 'zeta', medicineDosage: 'each 2 hour'),
          Medicine(
              medicineName: 'beta', medicineDosage: 'each 1 hour'),
        ]),
  ];
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
        SizedBox(
          //  height: 200,
          child: ListView.builder(
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
                Expanded(
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
                                       allPrescription[
                                        indexForPrescription]
                                            .allMedicine[indexForMedicine]
                                            .medicineName,
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
                                        allPrescription[
                                        indexForPrescription]
                                            .allMedicine[indexForMedicine]
                                            .medicineDosage,
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
            itemCount: allPrescription[indexForPrescription]
                .allMedicine
                .length,
          ),
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
    List x = isAnalysis
        ?allPrescription[indexForPrescription]
        .allAnalysis
        : allPrescription[indexForPrescription]
        .allRadiology;
    return x == null ?
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('There is no ${isAnalysis ==true ? 'Analysis': 'Radiology'}',style: infoWidget.titleButton.copyWith(color: Colors.blue),),
    ):Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: isAnalysis ==true?Colors.blue:Colors.grey)
        ),
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
                      isAnalysis?'Analysis: ':'Radiology: ',
                      style: infoWidget.titleButton.copyWith(
                          color:isAnalysis ==true?Colors.blue:Colors.grey[600],
                          fontWeight: FontWeight.w600
                        //fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Divider(
                  color: isAnalysis ==true?Colors.blue:Colors.grey,
                  height: 3,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: x.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: isAnalysis ==true?Colors.blue:Colors.grey),
                          ),
                          child: Column(
                            children: <Widget>[
                              x[index].image==null?SizedBox():InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ShowImage(
                                        imgUrl: x[index].image,
                                        isImgUrlAsset: false,
                                      )));
                                },
                                child:ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular( 15.0),
                                      topRight: Radius.circular(15.0)
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/patient.png',
                                    image:x[index].image,
                                    fit: BoxFit.fill,
                                    width: infoWidget.screenWidth,
                                    height: infoWidget
                                        .orientation ==
                                        Orientation.portrait
                                        ? infoWidget.screenHeight*0.2:infoWidget.screenHeight*0.3,
                                  ),
                                ),
                              ),
                              x[index].name==null?SizedBox():Padding(
                                padding: EdgeInsets.only(top: infoWidget.defaultVerticalPadding,left: infoWidget.defaultHorizontalPadding),
                                child: Row(
                                  children: <Widget>[
                                    Text('Name:',
                                        style:
                                        infoWidget.subTitle.copyWith(color: isAnalysis ==true?Colors.blue:Colors.grey[600])),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              x[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 6,
                                              style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              x[index].description==null?SizedBox():Padding(
                                padding: EdgeInsets.only(top: infoWidget.defaultVerticalPadding,left: infoWidget.defaultHorizontalPadding),
                                child: Row(
                                  children: <Widget>[
                                    Text('Description:',
                                        style:
                                        infoWidget.subTitle.copyWith(color: isAnalysis ==true?Colors.blue:Colors.grey[600])),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              x[index].description,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 6,
                                              style: infoWidget.subTitle.copyWith(fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: infoWidget.defaultVerticalPadding,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context,infoWidget){
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
                    color: allPrescription[
                    indexForPrescription]
                        .showPrescriptionGet
                        ? Colors.white
                        : Colors.blue,
                    elevation: allPrescription[
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
                                  allPrescription[
                                  indexForPrescription]
                                      .showPrescriptionSet =
                                  !allPrescription[
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
                                          allPrescription[
                                          indexForPrescription]
                                              .prescriptionName,
                                          maxLines: 1,
                                          style: infoWidget
                                              .titleButton
                                              .copyWith(
                                            color: allPrescription[
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
                                      allPrescription[
                                      indexForPrescription]
                                          .prescriptionDate,
                                      style: infoWidget
                                          .titleButton
                                          .copyWith(
                                        color: allPrescription[
                                        indexForPrescription]
                                            .showPrescriptionGet
                                            ? Colors.grey
                                            : Colors.white,
                                      )),
                                  Icon(
                                    allPrescription[
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
                        allPrescription[
                        indexForPrescription]
                            .showPrescriptionGet
                            ? Divider(
                          color: Colors.grey,
                          height: 1,
                        )
                            : SizedBox(),
                        allPrescription[
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
                                        'Description of Diagnose Description of Diagnose Description of Diagnose ',
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
            itemCount: allPrescription
                .length,
          ),
        );
      },
    );
  }
}
