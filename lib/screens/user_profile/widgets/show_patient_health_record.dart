import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:healthbook/core/models/device_info.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/screens/drugs_radiology_analysis/drugs_radiology_analysis.dart';
import 'package:healthbook/widgets/zoom_in_and_out_to_image.dart';

class ShowHealthRecord extends StatefulWidget {
  final List<DrugList> allDrugList;
  final int indexForDrugList;
  final String diagnoseName;

  ShowHealthRecord(
      {
        this.diagnoseName,
        this.allDrugList,
        this.indexForDrugList});

  @override
  _ShowHealthRecordState createState() =>
      _ShowHealthRecordState();
}

class _ShowHealthRecordState extends State<ShowHealthRecord> {
  Widget _showMedicine(
      {DeviceInfo infoWidget, int indexForDoctors, int indexForPrescription}) {
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
                                        widget
                                            .allDrugList[
                                        widget.indexForDrugList]
                                            .allDoctorsInEachDosage[
                                        indexForDoctors]
                                            .allPrescription[
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
                                        widget
                                            .allDrugList[
                                        widget.indexForDrugList]
                                            .allDoctorsInEachDosage[
                                        indexForDoctors]
                                            .allPrescription[
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
            itemCount: widget
                .allDrugList[widget.indexForDrugList]
                .allDoctorsInEachDosage[indexForDoctors]
                .allPrescription[indexForPrescription]
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
        int indexForDoctors,
        int indexForPrescription}) {
    List x = isAnalysis
        ? widget
        .allDrugList[widget.indexForDrugList]
        .allDoctorsInEachDosage[indexForDoctors]
        .allPrescription[indexForPrescription]
        .allAnalysis
        : widget
        .allDrugList[widget.indexForDrugList]
        .allDoctorsInEachDosage[indexForDoctors]
        .allPrescription[indexForPrescription]
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
      builder: (context, infoWidget) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.diagnoseName,
              style: infoWidget.titleButton,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          size: infoWidget.orientation==Orientation.portrait?infoWidget.screenHeight * 0.04:infoWidget.screenHeight * 0.07,
                        ),
                        Positioned(
                            right: 2.9,
                            top: 2.8,
                            child: Container(
                              width: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.023:infoWidget.screenWidth * 0.014,
                              height: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth * 0.023:infoWidget.screenWidth* 0.014,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width * 0.05
                      : MediaQuery.of(context).size.width * 0.035,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  //TODO: make pop
                }),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          body: ListView.builder(
            itemBuilder: (context, indexForDoctors) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Color(0xfffafbff),
                shadowColor: Colors.blueAccent,
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                type: MaterialType.card,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          setState(() {
                            widget
                                .allDrugList[widget.indexForDrugList]
                                .allDoctorsInEachDosage[indexForDoctors]
                                .showDoctorSet =
                            !widget
                                .allDrugList[widget.indexForDrugList]
                                .allDoctorsInEachDosage[indexForDoctors]
                                .showDoctorGet;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                      "Dr: ${widget.allDrugList[widget.indexForDrugList].allDoctorsInEachDosage[indexForDoctors].doctorData.firstName} ${widget.allDrugList[widget.indexForDrugList].allDoctorsInEachDosage[indexForDoctors].doctorData.lastName}",
                                      maxLines: 1,
                                      style: infoWidget.title.copyWith(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                    widget
                                        .allDrugList[widget.indexForDrugList]
                                        .allDoctorsInEachDosage[indexForDoctors]
                                        .date,
                                    style: infoWidget.titleButton.copyWith(
                                      color: Colors.grey,
                                    )),
                              ),
                              Icon(
                                widget
                                    .allDrugList[widget.indexForDrugList]
                                    .allDoctorsInEachDosage[indexForDoctors]
                                    .showDoctorGet
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.065:infoWidget.screenWidth*0.049,
                              ),
                            ],
                          ),
                        )),
                    widget
                        .allDrugList[widget.indexForDrugList]
                        .allDoctorsInEachDosage[indexForDoctors]
                        .showDoctorGet
                        ? Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 4,
                      ),
                    )
                        : SizedBox(),
                    widget
                        .allDrugList[widget.indexForDrugList]
                        .allDoctorsInEachDosage[indexForDoctors]
                        .showDoctorGet
                        ? Padding(
                        padding: EdgeInsets.only(
                            bottom: infoWidget.defaultVerticalPadding,
                            left: infoWidget.defaultHorizontalPadding,
                            right: infoWidget.defaultHorizontalPadding),
                        child: Column(children: <Widget>[
                          Container(
//
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(infoWidget
                                                  .orientation ==
                                                  Orientation.portrait
                                                  ? 35.0
                                                  : 55.0)),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/user.png',
                                            image:
                                            'https://res.cloudinary.com/dmmnnncjd/image/upload/v1595866185/ceqcpxokjyyiofznctpv.jpg'
                                            //patientAppointment.registerData.doctorImage,
                                            ,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        width:
                                        infoWidget.screenWidth * 0.18,
                                        height:
                                        infoWidget.screenWidth * 0.18,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                    infoWidget.defaultVerticalPadding,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                  "Dr: ${widget.allDrugList[widget.indexForDrugList].allDoctorsInEachDosage[indexForDoctors].doctorData.firstName} ${widget.allDrugList[widget.indexForDrugList].allDoctorsInEachDosage[indexForDoctors].doctorData.lastName}",
                                                  //${patientAppointment.registerData.firstName} ${patientAppointment.registerData.lastName}',
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: infoWidget.title
                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .w400)),
                                            ),
                                            RatingBar(
                                              rating: 3,
                                              icon: Icon(
                                                Icons.star,
                                                size:
                                                infoWidget.screenWidth *
                                                    0.04,
                                                color: Colors.grey,
                                              ),
                                              starCount: 5,
                                              spacing: 2.0,
                                              size: infoWidget.screenWidth *
                                                  0.03,
                                              isIndicator: true,
                                              allowHalfRating: true,
                                              onRatingCallback:
                                                  (double value,
                                                  ValueNotifier<bool>
                                                  isIndicator) {
                                                //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                                                isIndicator.value = true;
                                              },
                                              color: Colors.amber,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: infoWidget
                                                  .defaultVerticalPadding),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                    'Speciality: ${widget.allDrugList[widget.indexForDrugList].allDoctorsInEachDosage[indexForDoctors].doctorData.speciality}'
                                                    //${patientAppointment.registerData.speciality}',
                                                    ,
                                                    style: infoWidget
                                                        .subTitle
                                                        .copyWith(
                                                        fontWeight:
                                                        FontWeight
                                                            .w400)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: infoWidget
                                                  .defaultVerticalPadding),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'Location: ${widget.allDrugList[widget.indexForDrugList].allDoctorsInEachDosage[indexForDoctors].doctorData.address}'
                                                  //${patientAppointment.registerData.address}',
                                                  ,
                                                  style: infoWidget.subTitle
                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .w400),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
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
                          SizedBox(
                            height: 5,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, indexForPrescription) =>
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: infoWidget.defaultHorizontalPadding,
                                      right:
                                      infoWidget.defaultHorizontalPadding,
                                      bottom:
                                      infoWidget.defaultVerticalPadding),
                                  child: Material(
                                    shadowColor: Colors.blueAccent,
                                    color: widget
                                        .allDrugList[
                                    widget.indexForDrugList]
                                        .allDoctorsInEachDosage[
                                    indexForDoctors]
                                        .allPrescription[
                                    indexForPrescription]
                                        .showPrescriptionGet
                                        ? Colors.white
                                        : Colors.blue,
                                    elevation: widget
                                        .allDrugList[
                                    widget.indexForDrugList]
                                        .allDoctorsInEachDosage[
                                    indexForDoctors]
                                        .allPrescription[
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
                                                  widget
                                                      .allDrugList[widget
                                                      .indexForDrugList]
                                                      .allDoctorsInEachDosage[
                                                  indexForDoctors]
                                                      .allPrescription[
                                                  indexForPrescription]
                                                      .showPrescriptionSet =
                                                  !widget
                                                      .allDrugList[widget
                                                      .indexForDrugList]
                                                      .allDoctorsInEachDosage[
                                                  indexForDoctors]
                                                      .allPrescription[
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
                                                          widget
                                                              .allDrugList[widget
                                                              .indexForDrugList]
                                                              .allDoctorsInEachDosage[
                                                          indexForDoctors]
                                                              .allPrescription[
                                                          indexForPrescription]
                                                              .prescriptionName,
                                                          maxLines: 1,
                                                          style: infoWidget
                                                              .titleButton
                                                              .copyWith(
                                                            color: widget
                                                                .allDrugList[
                                                            widget
                                                                .indexForDrugList]
                                                                .allDoctorsInEachDosage[
                                                            indexForDoctors]
                                                                .allPrescription[
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
                                                      widget
                                                          .allDrugList[widget
                                                          .indexForDrugList]
                                                          .allDoctorsInEachDosage[
                                                      indexForDoctors]
                                                          .allPrescription[
                                                      indexForPrescription]
                                                          .prescriptionDate,
                                                      style: infoWidget
                                                          .titleButton
                                                          .copyWith(
                                                        color: widget
                                                            .allDrugList[widget
                                                            .indexForDrugList]
                                                            .allDoctorsInEachDosage[
                                                        indexForDoctors]
                                                            .allPrescription[
                                                        indexForPrescription]
                                                            .showPrescriptionGet
                                                            ? Colors.grey
                                                            : Colors.white,
                                                      )),
                                                  Icon(
                                                    widget
                                                        .allDrugList[widget
                                                        .indexForDrugList]
                                                        .allDoctorsInEachDosage[
                                                    indexForDoctors]
                                                        .allPrescription[
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
                                        widget
                                            .allDrugList[
                                        widget.indexForDrugList]
                                            .allDoctorsInEachDosage[
                                        indexForDoctors]
                                            .allPrescription[
                                        indexForPrescription]
                                            .showPrescriptionGet
                                            ? Divider(
                                          color: Colors.grey,
                                          height: 1,
                                        )
                                            : SizedBox(),
                                        widget
                                            .allDrugList[
                                        widget.indexForDrugList]
                                            .allDoctorsInEachDosage[
                                        indexForDoctors]
                                            .allPrescription[
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
                                                    indexForDoctors:
                                                    indexForDoctors,
                                                    indexForPrescription:
                                                    indexForPrescription),
                                                Column(
                                                  children: <Widget>[
                                                    contentOfRadiologyAndAnalysis(
                                                        infoWidget: infoWidget,
                                                        isAnalysis: false,
                                                        indexForDoctors:
                                                        indexForDoctors,
                                                        indexForPrescription:
                                                        indexForPrescription),
                                                    contentOfRadiologyAndAnalysis(
                                                        infoWidget: infoWidget,
                                                        indexForDoctors:
                                                        indexForDoctors,
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
                            itemCount: widget
                                .allDrugList[widget.indexForDrugList]
                                .allDoctorsInEachDosage[indexForDoctors]
                                .allPrescription
                                .length,
                          )
                        ]))
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            itemCount: widget.allDrugList[widget.indexForDrugList]
                .allDoctorsInEachDosage.length,
          ),
        );
      },
    );
  }
}
