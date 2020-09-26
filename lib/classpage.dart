import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// This Widget is the main application widget.
class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Student{
  final String id;
  final String name;
  Student({this.id,this.name});
  factory Student.fromjson(Map<String,dynamic> json){
    return Student(
      id: json['StudentId'] as String,
      name: json['StudentName'] as String,
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  http.Response response;
  Future<http.Response> getData(http.Client client) async {
    return client.get('https://peciis.info/PECMIS/APIs/GetStudentIdName.php');
  }
  List<Student> parsejson(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Student>((json)=>Student.fromjson(json)).toList();
  }
  Future<List<Student>> fetchjson(http.Client client) async {
    final response = await client.get('https://peciis.info/PECMIS/APIs/GetStudentIdName.php');
    return parsejson(response.body);
  }
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<Student>>(
          future: fetchjson(http.Client()),
          builder: (_,snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? StudentList(students: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        )
    );
  }
}
class StudentList extends StatelessWidget {
  final List<Student> students;
  StudentList({Key key, this.students}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: students.length ,
        itemBuilder: (_,index){
          return  Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.album),
                  title: Text(students[index].name),
                  subtitle: Text(students[index].id),
                  trailing: Checkbox(onChanged: (value){
                    setState(){
                      value = false;
                    }
                  },value: true,),
                ),
              ],
            ),
          );
        });
  }
}