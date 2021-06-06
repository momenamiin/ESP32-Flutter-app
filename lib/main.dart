import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ESP APP',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ESP APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String SwitchState = 'OFF' ;

  Future<http.Response> fetchData(String pin) {
    return http.get(Uri.parse('http://192.168.1.6/$pin')).then((value) {
      print(value.body);

      (value.body.contains('GPIO 27 - State off')) ?setState(() {SwitchState = "OFF";}) : setState(() { SwitchState = "ON";});;
      (value.body.contains('GPIO 26 - State off')) ? print('OFF') : print('ON');
      (value.body.contains('GPIO 26 - State on')) ? print('OFF') : print('ON');
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  fetchData("26/on");
                },
                child: Text('Turn LED On', style: TextStyle(fontSize: 20),),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  fetchData("26/off");
                },
                child: Text('Turn LED OFF', style: TextStyle(fontSize: 20),),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
            fetchData("27").toString();
                },
                child: Text('Check Switch', style: TextStyle(fontSize: 20)),
              ),
              Text("Switch is $SwitchState", style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}
