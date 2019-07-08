import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TrainNumber extends StatefulWidget {
  final ValueChanged<String> onChanged;

  TrainNumber({this.onChanged});
  @override
  _TrainNumberState createState() => _TrainNumberState();
}

class _TrainNumberState extends State<TrainNumber> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        padding: EdgeInsets.fromLTRB(8.0,0,8.0,8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Train no.",style: TextStyle(color: Colors.blue[900]),),
            Divider(height: 2,),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                hintText: "Example: 11111",
              ),
              onChanged: (val) => widget.onChanged(val),
            ),
          ],
        ),
      );
  }
}