import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

int count;
List<int> _list = List.generate(count, (index) => index, growable: true);
List<bool> _selected = List.generate(count, (index) => true, growable: true);
Future<http.Response> pushData(Student student) async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  int index;
  final http.Response response = await http.post(
    'https://jsonplaceholder.typicode.com/albums',
    body: jsonEncode(<String,String>{
     "title":"title"
    }),
  );
  if (response.statusCode == 200) {
    print(response.body);
  }
  else{
    print(response.statusCode);
  }
}

// Future<http.Response> createAttendance(String title) async {
//   final http.Response response = await http.post(
//     'https://jsonplaceholder.typicode.com/albums',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
//   if (response.statusCode == 200) {
//     print(response.body);
//   }
// }

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

class Student {
  final String id;
  final String name;
  Student({this.id, this.name});
  factory Student.fromjson(Map<String, dynamic> json) {
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

  List<Student> parsejson(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json) => Student.fromjson(json)).toList();
  }

  Future<List<Student>> fetchjson(http.Client client) async {
    final response = await client
        .get('https://peciis.info/PECMIS/APIs/GetStudentIdName.php');
    return parsejson(response.body);
  }

  Student student = new Student();
  StudentList studentList = new StudentList();
  Future<http.Response> res;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Student>>(
        future: fetchjson(http.Client()),
        builder: (_, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) count = snapshot.data.length;
          return snapshot.hasData
              ? StudentList(students: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            res = pushData(student);
          });
        },
        icon: Icon(Icons.save),
        label: Text("Save"),
      ),
    );
  }
}

class StudentList extends StatefulWidget {
  final List<Student> students;
  StudentList({Key key, this.students}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  // initially fill it up with false
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.students.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () => setState(() => _selected[index] = !_selected[index]),
            child: Card(
              color: _selected[index] ? Colors.white : Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text(widget.students[index].name),
                    subtitle: Text(widget.students[index].id),
                    trailing: Checkbox(
                      onChanged: (value) {
                        setState() {
                          value = false;
                        }
                      },
                      value: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
