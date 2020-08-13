import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _gifSrc;
  GifPage(this._gifSrc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifSrc['title']),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(_gifSrc["images"]["fixed_height"]["url"]);
              }),
        ],
      ),
      body: Center(
        child: Image.network(_gifSrc["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
