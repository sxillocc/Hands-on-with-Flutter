import 'package:flutter/material.dart';

class DropList extends StatefulWidget {
  final String title;
  final List<String> item;
  final ValueChanged<String> onChanged;

  DropList({Key key,this.item,this.title,this.onChanged}): super(key: key);

  @override
  _DropListState createState() => _DropListState();
}

class _DropListState extends State<DropList> {
  List<DropdownMenuItem> menuList = List<DropdownMenuItem>();
  int _value;
  
  void initState(){
    super.initState();
    _value = 0;
    widget.item.asMap().forEach(
      (index,itemTitle){
        menuList.add(
          DropdownMenuItem(
            child: Text(itemTitle),
            value: index,
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0,0,8.0,4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0)
      ),      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${widget.title}",style: TextStyle(color: Colors.blue[900]),),
          Divider(height: 2,),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isDense: true,
                    items: menuList,
                    onChanged: (val){
                      setState(() {
                        _value = val;
                        widget.onChanged(widget.item[val]);
                      });
                    },
                    value: _value,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // Widget _drawDropDownCard(){
  //   return
  //     Container(
  //           height: 46,
  //           padding: EdgeInsets.fromLTRB(8.0,0,8.0,4.0),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(4.0)
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text("${widget.title}",style: TextStyle(color: Colors.blue[900]),),
  //               Divider(height: 2,),
  //               Row(
  //                 children: <Widget>[
  //                   Expanded(child: Text("${widget.itemSelected}",textAlign: TextAlign.center,)),
  //                   Icon(Icons.keyboard_arrow_down),
  //                 ],
  //               ),
  //             ],
  //           )
  //   );
  // }
}