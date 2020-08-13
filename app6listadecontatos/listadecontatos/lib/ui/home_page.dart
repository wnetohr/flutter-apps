import 'package:flutter/material.dart';
import 'package:listadecontatos/helpers/contact_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();
    Contact teste2 = Contact();
    teste2.name = 'netindogera';
    teste2.email = 'netindogero@gmail.com';
    teste2.number = '996958484';
    teste2.img = 'fotozada';
    helper.saveContact(teste2);
    helper.getAllContacts().then((list) {
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
