import 'package:flutter/material.dart';
import 'package:attendance_counter/widgets/ball_slider.dart';
import 'package:attendance_counter/widgets/percentage_indicator.dart';

class AtdCard extends StatefulWidget {
  final String subject;
  int v;
  double percent,criteria;
  final ValueChanged<int> onValueChange;

  AtdCard({@required this.percent,@required this.criteria,@required this.subject,@required this.v,@required this.onValueChange});
  @override
  _AtdCardState createState() => _AtdCardState();
}

class _AtdCardState extends State<AtdCard> {

  Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.percent<widget.criteria ? Colors.red[700] : Colors.green[700] ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:EdgeInsets.fromLTRB(4,4,4,2),
                          child: Text(
                            '${widget.subject}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding:EdgeInsets.fromLTRB(4,2,4,4),
                            child: Text(
                              'You have to attend 5 classes in a row',
                              style: Theme.of(context).textTheme.subtitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                RoundPercentPie(
                  percent: widget.percent,
                  backgroundColor: _color,
                  progressColor: Colors.white,
                )
              ],
            ),

          ),
          Padding(
            padding:EdgeInsets.fromLTRB(4,0,4,0),
            child: BallSlider(
              val: widget.v,
              valueChanged: (v){
                setState(() {
                  widget.v = v;
                  widget.onValueChange(v);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
