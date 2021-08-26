import 'package:flutter/material.dart';
import '../models/http_request.dart';

class SwitchWidget extends StatefulWidget {
  bool SwitchState;
  String Pin;
  String IP;

  SwitchWidget(this.SwitchState, this.Pin, this.IP);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
              gradient: !widget.SwitchState
                  ? LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                          Colors.red.withOpacity(.6),
                          Colors.red[600]!.withOpacity(.6),
                        ])
                  : LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                          Colors.green.withOpacity(.4),
                          Colors.green.withOpacity(.8)
                        ])),
          padding: EdgeInsets.all((MediaQuery.of(context).size.width >480 ) ? 15 : 8),
          height: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  (widget.Pin == '27')
                      ? 'Switch is ${widget.SwitchState ? 'ON' : 'OFF'}'
                      : 'LED is ${widget.SwitchState ? 'ON' : 'OFF'}',
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).size.width >480 ) ? 22 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                      primary: (widget.SwitchState) ? Colors.redAccent.withOpacity(.8) : Colors.greenAccent.withOpacity(.8),
                    padding: EdgeInsets.all(20),

                    side: BorderSide(color: Colors.white, width: 1),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: (MediaQuery.of(context).size.width >480 ) ? 22 : 15,
                    ),
                  ),
                  onPressed: (widget.IP == '') ? null : _changeValue,
                  child: Text((widget.Pin == '27')
                      ? 'Check Switch'
                      : (widget.SwitchState)
                          ? 'Turn LED Off'
                          : 'Turn Led On'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _changeValue() async {
    print('switch state is + ${widget.SwitchState}');
    HttpRequest.fetchData(
            widget.IP,
            (widget.Pin == '27')
                ? '27'
                :(widget.SwitchState)
                    ? '26/off'
                    : '26/on')
        .then((value) {
          print(value.body);
      if (widget.Pin == '27') {
        (value.body.contains('GPIO 27 - State off'))
            ? setState(() {
                widget.SwitchState = false;
              })
            : setState(() {
                widget.SwitchState = true;
              });
        ;
      } else {
        (value.body.contains('GPIO 26 - State on'))
            ? setState(() {
                widget.SwitchState = true;
              })
            : setState(() {
                widget.SwitchState = false;
              });
        ;
      }
    });
  }
}
