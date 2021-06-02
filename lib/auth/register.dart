import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:sample/auth/login.dart';
import 'package:sample/pages/home.dart';
import 'package:sample/api/api.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var passwordConfirmation = TextEditingController();
  bool _isLoading = false;

  TextStyle style = TextStyle(fontFamily: 'Lato', fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    final nameField = TextField(
        controller: name,
        keyboardType: TextInputType.text,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ));
    final emailField = TextField(
        controller: email,
        keyboardType: TextInputType.text,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ));
    final passwordField = TextField(
        obscureText: true,
        controller: password,
        keyboardType: TextInputType.text,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ));
    final confirmField = TextField(
        obscureText: true,
        controller: passwordConfirmation,
        keyboardType: TextInputType.text,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Password Confirmation',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ));
    final registerBtn = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.teal,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          onPressed: _register,
          child: Text(_isLoading ? 'Signing up...' : 'Sign up',
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold))),
    );
    final loginBtn = InkWell(
      onTap: () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Text('Already have an account'),
      ),
    );
    return Scaffold(
        body: Center(
      child: Container(
          child: Container(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 45.0,
            ),
            nameField,
            SizedBox(
              height: 20.0,
            ),
            emailField,
            SizedBox(
              height: 20.0,
            ),
            passwordField,
            SizedBox(
              height: 20.0,
            ),
            confirmField,
            SizedBox(
              height: 20.0,
            ),
            registerBtn,
            SizedBox(
              height: 20.0,
            ),
            loginBtn,
          ],
        ),
      )),
    ));
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    var form = {
      'name': name.text,
      'email': email.text,
      'password': password.text,
      'password_confirmation': passwordConfirmation.text,
    };
    var res = await Api().postData(form, 'register');
    var body = json.decode(res.body);
    print(body);
    if (body['token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Home()));
    }

    setState(() {
      _isLoading = false;
    });
  }
}
