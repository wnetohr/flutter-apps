import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String mensagem = 'Bem vindo!';
  TextEditingController heightC = TextEditingController();
  TextEditingController weightC = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetOptions() {
    setState(() {
      heightC.text = '';
      weightC.text = '';
      mensagem = 'Bem vindo!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcImc() {
    var weight = double.parse(weightC.text);
    var height = double.parse(heightC.text);
    var imc = weight / (height * height);
    if (imc < 18.5) {
      setState(() {
        mensagem = 'imc: $imc , abaixo do peso.';
      });
    } else if (imc >= 18.5 && imc < 24.9) {
      setState(() {
        mensagem = 'imc: $imc , peso normal.';
      });
    } else if (imc >= 24.9 && imc < 29.9) {
      setState(() {
        mensagem = 'imc: $imc, sobrepeso.';
      });
    } else if (imc >= 29.9 && imc < 34.9) {
      setState(() {
        mensagem = 'imc:  $imc, obesidade grau 1.';
      });
    } else if (imc >= 34.9 && imc < 39.9) {
      setState(() {
        mensagem = 'imc: $imc, obesidade grau 2.';
      });
    } else if (imc >= 39.9) {
      setState(() {
        mensagem = 'imc: $imc, obesidade grau3.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadore de IMC'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              resetOptions();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: weightC,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira o seu peso.";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Peso(kg)',
                      labelStyle: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: heightC,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira a sua altura.";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Altura(m)',
                      labelStyle: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calcImc();
                    }
                  },
                  child: Text(
                    'Calcular!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  mensagem,
                  style: TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
