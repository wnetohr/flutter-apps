import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request =
    'https://api.hgbrasil.com/finance?format=json-cors&key=139eb1d2';

void main() async {
  runApp(
    MaterialApp(
      home: MyHome(),
      theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.green),
    ),
  );
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final realControl = TextEditingController();
  final dolarControl = TextEditingController();
  final euroControl = TextEditingController();
  double dolar;
  double euro;
  void _realChanged(String text) {
    double real = double.parse(text);
    dolarControl.text = (real / dolar).toStringAsFixed(2);
    euroControl.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realControl.text = (dolar * this.dolar).toStringAsFixed(2);
    euroControl.text = (dolar * this.dolar / this.euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realControl.text = (euro * this.euro).toStringAsFixed(2);
    dolarControl.text = (euro * this.euro / this.dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Conversor',
          style: TextStyle(color: Colors.green),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Carregando...',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Erro ao carregar dados',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else {
                  dolar = snapshot.data['results']['currencies']['USD']['buy'];
                  euro = snapshot.data['results']['currencies']['EUR']['buy'];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          color: Colors.green,
                          size: 75,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        textPreset('Real', 'R\$', realControl, _realChanged),
                        SizedBox(
                          height: 50,
                        ),
                        textPreset(
                            'Dólar', 'US\$', dolarControl, _dolarChanged),
                        SizedBox(
                          height: 50,
                        ),
                        textPreset('Euro', '€', euroControl, _euroChanged),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget textPreset(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      labelText: label,
      labelStyle: TextStyle(color: Colors.green),
      prefixText: prefix,
    ),
    style: TextStyle(color: Colors.green),
    cursorColor: Colors.green,
    keyboardType: TextInputType.number,
    onChanged: f,
  );
}

/*



*/
