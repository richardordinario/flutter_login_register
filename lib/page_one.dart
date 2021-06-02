import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24.4, 42.0, 24.4, 42.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'left.png',
                  height: 20,
                  width: 20,
                ),
                Text('Skip')
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 34.0),
            constraints: BoxConstraints.expand(
                height: 300.0, width: MediaQuery.of(context).size.width * 0.65),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('men.jpg'), fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
            width: MediaQuery.of(context).size.width * 0.60,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                'Visible Changes in 3 weeks',
                style: TextStyle(fontSize: 38.0),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Text(
                'Get My Plan'.toUpperCase(),
                style: TextStyle(fontSize: 14.0),
              ),
              onPressed: () {},
              color: _colorFromHex('#c0392b'),
              textColor: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 18.0),
            ),
          )
        ],
      )),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
