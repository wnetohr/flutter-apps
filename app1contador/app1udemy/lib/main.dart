import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Customers count',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int numberC = 0;
  //CheckCustomers checkCustomers = checkCustomers();
  String mensagem = 'Welcome, you can enter!';
  String CheckCustomers() {
    if (numberC >= 0 && numberC < 10) {
      mensagem = 'Welcome, you can enter!';
    } else if (numberC < 0) {
      mensagem = 'do you think it\'s funny?';
    } else if (numberC > 10) {
      mensagem = 'Sorry, we are full';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        Image.asset(
          'images/rest.png',
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Customers: $numberC',
                style: TextStyle(color: Colors.white, fontSize: 32.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        '+1',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          ++numberC;
                          CheckCustomers();
                        });
                      }),
                  FlatButton(
                    child: Text(
                      '-1',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        --numberC;
                        CheckCustomers();
                      });
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                mensagem,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
