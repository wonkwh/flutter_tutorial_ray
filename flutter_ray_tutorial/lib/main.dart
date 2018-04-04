import 'dart:convert';

import 'package:flutter/material.dart';
import 'strings.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: Strings.appTitle, home: new GHFlutter());
  }
}

class GHFlutter extends StatefulWidget {
  @override
  _GHFlutterState createState() => new _GHFlutterState();
}

class _GHFlutterState extends State<GHFlutter> {
  var _members = [];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.appTitle),
        ),
        body: new ListView.builder(
          itemCount: _members.length,
          itemBuilder: (context, position) {
            return _buildRow(position);
          },
        ));
  }

  _loadData() async {
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataURL);
    setState(() {
      _members = JSON.decode(response.body);
    });
  }

  Widget _buildRow(int i) {
    debugPrint("${_members[i]["id"]}");
    return new ListTile(
        title: new Text("${_members[i]["login"]}", style: _biggerFont));
  }
}
