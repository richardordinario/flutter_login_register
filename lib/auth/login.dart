import 'package:flutter/material.dart';
import 'package:sample/api/api.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './register.dart';
import 'package:sample/pages/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;
  // var errors = {
  //   'error_email': null,
  //   'error_password': null,
  // };
  var errors;

  TextStyle style = TextStyle(fontFamily: 'Lato', fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        obscureText: false,
        controller: email,
        style: style,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          errorText: errors != null ? '${errors['email'][0]}' : null,
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
          errorText: errors != null ? '${errors['password']}' : null,
        ));
    final loginBtn = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.teal,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          onPressed: _login,
          child: Text(_isLoading ? 'Signing in...' : 'Sign in',
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold))),
    );
    final signupBtn = InkWell(
      onTap: () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Register()));
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Text('Create an account'),
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
            loginBtn,
            SizedBox(
              height: 20.0,
            ),
            signupBtn,
          ],
        ),
      )),
    ));
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var form = {
      'email': email.text,
      'password': password.text,
    };
    var res = await Api().postData(form, 'login');
    var body = json.decode(res.body);
    if (res.statusCode == 422) {
      // print(body);
      Map<String, dynamic> validationErrors = body['errors'];
      print(validationErrors);
      for (var err in validationErrors.values) {
        print(err);
      }

      setState(() {
        errors = body['errors'];
      });
    } else {
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
