import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassPage extends StatefulWidget {
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  List data;
  http.Response response;
  http.Response pushResponse;
  Future res;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    response =
        await http.get('http://peciis.info/PECMIS/APIs/GetStudentIdName.php');
    setState(() {
      data = jsonDecode(response.body);
      print(data);
    });
    processData();
  }

  processData() {
    for (int i = 0; i < data.length; i++) {
      setState(() {
        data[i]['attendance'] = 'present';
      });
    }
    print(data);
  }

  Future pushData() async {
    pushResponse = await http.post('http://peciis.info/PECMIS/APIs/PutData.php',
        body: jsonEncode(data));
    print(pushResponse.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(itemBuilder: (_, index) {
              return Card(
                color: data[index]['attendance'] == 'present'
                    ? Colors.white
                    : Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.album),
                      title: Text(data[index]['StudentName']),
                      subtitle: Text(data[index]['StudentId']),
                      onTap: () {
                        if (data[index]['attendance'] == 'present') {
                          setState(() {
                            data[index]['attendance'] = 'absent';
                          });
                        } else if (data[index]['attendance'] == 'absent') {
                          setState(() {
                            data[index]['attendance'] = 'present';
                          });
                        }
                        // print(data);
                        print(jsonEncode(data));
                      },
                    ),
                  ],
                ),
              );
            }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            res = pushData();
          });
        },
        icon: Icon(Icons.save),
        label: Text("Save"),
      ),
    );
  }
}
