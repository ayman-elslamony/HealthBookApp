import 'package:flutter/material.dart';

class SpecialtyAndGovernrateCard extends StatefulWidget {
 final List<String> listData;
 final String name;
 Function selected;
 SpecialtyAndGovernrateCard({this.name,this.listData,this.selected});
 @override
  _SpecialtyAndGovernrateCardState createState() => _SpecialtyAndGovernrateCardState();
}

class _SpecialtyAndGovernrateCardState extends State<SpecialtyAndGovernrateCard> {
  bool _isSelected = false;
  String selected;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Material(
        shadowColor: Colors.blueAccent,
        elevation: 8.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        type: MaterialType.card,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.51,
                  child: Text(
                    _isSelected == false ? widget.name : '${widget.name}: ' + selected,
                    maxLines: 1,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              PopupMenuButton(
                tooltip: 'Select ${widget.name}',
                padding: EdgeInsets.all(10.0),
                elevation: 8.0,
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
  }
}
