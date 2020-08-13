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
  final _todoControler = TextEditingController();
  List _todoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastIndex;

  @override
  void initState() {
    super.initState();
    _readFile().then((data) {
      setState(() {
        _todoList = json.decode(data);
      });
    });
  }

  void addTask() {
    Map<String, dynamic> newTodo = Map();
    newTodo['name'] = _todoControler.text;
    newTodo['ok'] = false;
    setState(() {
      _todoControler.text = '';
      _todoList.add(newTodo);
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _todoList.sort((a, b) {
        if (a['ok'] && !b['ok'])
          return 1;
        else if (!a['ok'] && b['ok'])
          return -1;
        else
          return 0;
      });
      _saveData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Task List',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 7, 7, 7),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoControler,
                    decoration: InputDecoration(
                      labelText: 'Task',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    addTask();
                  },
                  child: Text('Add', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: _todoList.length,
                  itemBuilder: checkWidget),
            ),
          ),
        ],
      ),
    );
  }

  Widget checkWidget(context, index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_todoList[index]['name']),
        value: _todoList[index]['ok'],
        secondary: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(
            _todoList[index]['ok'] ? Icons.check : Icons.cancel,
            color: Colors.white,
          ),
        ),
        onChanged: (check) {
          setState(() {
            _todoList[index]['ok'] = check;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_todoList[index]);
          _lastIndex = index;
          _todoList.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content: Text('Tarefa \'${_lastRemoved['name']}\"removido da list'),
            action: SnackBarAction(
                label: 'Desfazer',
                onPressed: () {
                  setState(() {
                    _todoList.insert(_lastIndex, _lastRemoved);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
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
