import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Task List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                ),
                RaisedButton(
                  color: Colors.black,
                  onPressed: () {},
                  child: Text('Add', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            ListView(),
          ],
        ),
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (error) {
      return null;
    }
  }
}

/*

SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                ),
                RaisedButton(
                  color: Colors.black,
                  onPressed: () {},
                  child: Text('Add', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            ListView(),
          ],
        ),
      ),

*/
