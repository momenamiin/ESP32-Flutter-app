import 'package:flutter/material.dart';
import '../widgets/switch_widget.dart';
import 'Wifi_Config.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool SwitchState = false;

  bool LedState = false;
  String IP = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('ESP Control app'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnectivityPage()),
              );
            },
            child: Text("Wifi"),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all((MediaQuery.of(context).size.width >480 ) ? 30 : 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SwitchWidget(LedState, '26', IP),
                  SwitchWidget(SwitchState, '27', IP),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 6,
                    child: Text('192.168.', style: TextStyle(fontSize: 20),),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextField(
                        onChanged: (value) {
                          setState(() {
                            IP = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
