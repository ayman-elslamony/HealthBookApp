import 'package:flutter/material.dart';
import 'package:healthbook/core/ui_components/info_widget.dart';

class SpecialtyAndGovernrateCard extends StatefulWidget {
 final List<String> listData;
 final String name;
 final Function selected;
 SpecialtyAndGovernrateCard({this.name,this.listData,this.selected});
 @override
  _SpecialtyAndGovernrateCardState createState() => _SpecialtyAndGovernrateCardState();
}

class _SpecialtyAndGovernrateCardState extends State<SpecialtyAndGovernrateCard> {
  bool _isSelected = false;
  String selected;
  @override
  Widget build(BuildContext context) {

    return InfoWidget(
      builder: (context ,infoWidget){
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Material(
            shadowColor: Colors.blueAccent,
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            type: MaterialType.card,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: infoWidget.screenWidth*0.30,
                  maxWidth: infoWidget.orientation==Orientation.portrait?infoWidget.screenWidth*0.55:infoWidget.screenWidth*0.35,
                ),
                child: Text(
                _isSelected == false ? widget.name : '${widget.name}: ' + selected,
                  maxLines: 3,

                  style: infoWidget.subTitle.copyWith(color: Colors.black)
                ),
              ),
                  PopupMenuButton(
                    tooltip: 'Select ${widget.name}',
                    padding: EdgeInsets.all(10.0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (ctx) => widget.listData
                        .map((String val) => PopupMenuItem<String>(
                      value: val,
                      child: Center(child: Text(val)),
                    ))
                        .toList(),
                    onSelected: (String val) {
                      setState(() {
                        selected = val;
                        _isSelected = true;
                        widget.selected(val);
                      });
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
