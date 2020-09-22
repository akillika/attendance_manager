import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Attendance Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome back - $formatted',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Computer Science Engineering'),
                      subtitle: Text('Section A'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('OPEN'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Computer Science Engineering'),
                      subtitle: Text('Section A'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('OPEN'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Computer Science Engineering'),
                      subtitle: Text('Section A'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('OPEN'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Computer Science Engineering'),
                      subtitle: Text('Section A'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('OPEN'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('Computer Science Engineering'),
                      subtitle: Text('Section A'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('OPEN'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
