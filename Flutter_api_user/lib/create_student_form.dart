import 'package:api_user/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Student_Form extends StatefulWidget {
  Student_Form({Key? key}) : super(key: key);

  @override
  State<Student_Form> createState() => _Student_FormState();
}

class _Student_FormState extends State<Student_Form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Student Data'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        child: MyStudentForm(),
      ),
    );
  }
}

class MyStudentForm extends StatefulWidget {
  MyStudentForm({Key? key}) : super(key: key);

  @override
  State<MyStudentForm> createState() => _MyStudentFormState();
}

class _MyStudentFormState extends State<MyStudentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController rollnumbercontroller = new TextEditingController();
  TextEditingController messagecontroller = new TextEditingController();

  Client client = http.Client();
  var createUrl = Uri.parse('http://127.0.0.1:8000/create/');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    hintText: 'Enter your name',
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: rollnumbercontroller,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone, color: Colors.green),
                    hintText: 'Enter your roll number',
                    labelText: 'Roll Number',
                  ),
                ),
                TextFormField(
                  controller: messagecontroller,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.calendar_today, color: Colors.green),
                    hintText: 'Enter your message',
                    labelText: 'Message',
                  ),
                ),
                new Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: new RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Submit'),
                        ),
                        onPressed: () {
                          client.post(createUrl, body: {
                            "name": namecontroller.text,
                            "rollnumber": rollnumbercontroller.text,
                            "message": messagecontroller.text
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
