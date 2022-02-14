import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<student>> studentList;

  @override
  void initState() {
    super.initState();
    studentList = fetchstudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Django Api data fetcher')],
          ),
        ),
        body: Container(
          color: Colors.green,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<student>>(
            future: studentList,
            builder: (context, abc) {
              if (abc.hasData) {
                return ListView.builder(
                  itemCount: abc.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${abc.data![index].id}'),
                      title: Text('${abc.data![index].name}'),
                      subtitle: Text('${abc.data![index].message}'),
                      trailing: Text('${abc.data![index].rollnumber}'),
                    );
                  },
                );
                //Text(abc.data.length.toString());
              } else if (abc.hasError) {
                return Text("tt:${abc.error}");
              }

              // By default, it show a loading spinner.
              return CircularProgressIndicator();
            },
          ),

          // SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: Card(
          //       elevation: 10,
          //       child: ListTile(
          //         leading: Icon(Icons.person),
          //         title: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           mainAxisSize: MainAxisSize.max,
          //           children: [Text('Name'), Text('RollNumber')],
          //         ),
          //         subtitle: Text('Message'),
          //         trailing: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          //             IconButton(onPressed: () {}, icon: Icon(Icons.delete))
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ));
  }
}

List<student> parseData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<student>((json) => student.fromJson(json)).toList();
}

var url = Uri.parse('http://127.0.0.1:8000/allstudent/');
Future<List<student>> fetchstudent() async {
  //final response = await http.get('https://pcc.edu.pk/mad/consultants.json');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    //var data = json.decode(response.body);

    return parseData(response.body);
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load data');
  }
}

class student {
  final int id;
  final String name;
  final String rollnumber;
  final String message;

  student({
    required this.id,
    required this.name,
    required this.rollnumber,
    required this.message,
  });

  factory student.fromJson(Map<String, dynamic> json) {
    return student(
      id: json['id'],
      name: json['name'],
      rollnumber: json['rollnumber'],
      message: json['message'],
    );
  }
}
