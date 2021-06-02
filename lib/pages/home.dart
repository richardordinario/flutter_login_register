import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sample/api/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user;
  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _getUser() async {
    var res = await Api().getData('user');
    print(res.body);
    setState(() {
      user = json.decode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: view());
  }

  Widget view() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 24,
                ))
          ],
        )
      ],
    );
  }
}
