import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';
import 'package:healthbook/models/user_data.dart';
import 'package:healthbook/providers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'showDrugs.dart';



class DrugAndRadiologyAndAnalysis extends StatefulWidget {
  final bool isDrugs;

  DrugAndRadiologyAndAnalysis({this.isDrugs = true});

  @override
  _DrugAndRadiologyAndAnalysisState createState() =>
      _DrugAndRadiologyAndAnalysisState();
}

class _DrugAndRadiologyAndAnalysisState
    extends State<DrugAndRadiologyAndAnalysis> {

  bool isLoading = true;
  Auth _auth;

  @override
  void initState() {
    print('ttttttttttttttttttttttttt');
    _auth = Provider.of<Auth>(context, listen: false);
    getHistory();
    super.initState();
  }

  getHistory() async {
    await _auth.getAllDiagnoseName();
    print('aaaaaaaaaaaaaaaaa');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, infoWidget) {
        return RefreshIndicator(
          onRefresh: ()async{
            await _auth.getAllDiagnoseName();
          },
          backgroundColor: Colors.white,
          color: Colors.blue,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.isDrugs ? 'Drugs' : 'Radiology And Analysis',
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
                              size: infoWidget.orientation == Orientation.portrait
                                  ? infoWidget.screenHeight * 0.04
                                  : infoWidget.screenHeight * 0.07,
                            ),
                            Positioned(
                                right: 2.9,
                                top: 2.8,
                                child: Container(
                                  width: infoWidget.orientation ==
                                          Orientation.portrait
                                      ? infoWidget.screenWidth * 0.023
                                      : infoWidget.screenWidth * 0.014,
                                  height: infoWidget.orientation ==
                                          Orientation.portrait
                                      ? infoWidget.screenWidth * 0.023
                                      : infoWidget.screenWidth * 0.014,
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
                      size: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.05
                          : MediaQuery.of(context).size.width * 0.035,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
              body: isLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                    child: Consumer<Auth>(
                builder: (context,data,_){
                    if(data.allDiagnose.length == 0){
                      return SizedBox(
                        height: infoWidget.screenHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('There in no any ${widget.isDrugs?'Drugs':'Radiology and Analysis'} yet',style: infoWidget.titleButton.copyWith(color: Colors.blue),maxLines: 3,),
                              ],
                            )
                          ],
                        ),
                      );
                    }else{
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => RaisedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowAllDoctorsInDiagnose(
                                    diagnoseName:
                                    data.allDiagnose[index],
                                    isShowMedicine: widget.isDrugs,
                                  )));
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                data.allDiagnose[index],
                                style: infoWidget.titleButton,
                              ),
                            ),
                          ),
                          itemCount: data.allDiagnose.length,
                        ),
                      );
                    }
                },
              ),
                  )),
        );
      },
    );
  }
}
