import 'package:api_user/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class updateStudentForm extends StatefulWidget {
  final int id;
  final String name;
  final String rollnumber;
  final String message;
  updateStudentForm(
      {Key? key,
      required this.id,
      required this.name,
      required this.rollnumber,
      required this.message})
      : super(key: key);

  @override
  State<updateStudentForm> createState() => _updateStudentFormState();
}

class _updateStudentFormState extends State<updateStudentForm> {
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
          child:
              form(widget.id, widget.name, widget.rollnumber, widget.message)),
    );
  }
}

class form extends StatefulWidget {
  final int id;
  final String name;
  final String rollnumber;
  final String message;
  form(this.id, this.name, this.rollnumber, this.message, {Key? key})
      : super(key: key);

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController rollnumbercontroller = new TextEditingController();
  TextEditingController messagecontroller = new TextEditingController();

  Client client = http.Client();

  Uri urlget(String str_id) {
    var createUrl = Uri.parse('http://127.0.0.1:8000/update/${str_id}/');
    return createUrl;
  }

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
                  // initialValue: widget.name,
                  controller: namecontroller,
                  // namecontroller.text=widget.name,

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
                  // initialValue: widget.rollnumber,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone, color: Colors.green),
                    hintText: 'Enter your roll number',
                    labelText: 'Roll Number',
                  ),
                ),
                TextFormField(
                  controller: messagecontroller,
                  // initialValue: widget.message,
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
                          client.put(urlget(widget.id.toString()), body: {
                            // "id": widget.id,
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
