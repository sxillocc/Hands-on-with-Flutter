import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.fromLTRB(8.0,0,8.0,4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Journey Date",style: TextStyle(color: Colors.blue[900]),),
            Divider(height: 2,),
            Row(
              children: <Widget>[
                Icon(Icons.date_range),
                Expanded(child: Text("Tue, 9 Jul",textAlign: TextAlign.center,))
              ],
            ),
          ],
        )
      );
  }
}