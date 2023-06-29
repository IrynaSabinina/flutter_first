import 'auth.dart';
import 'home-login_page.dart';
import 'package:flutter_application_1/login-register-page.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key?key}):super (key: key);
@override
State<WidgetTree> createState() =>_WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeLoginPage();
        } else {
          return LoginRegisterPage();
        }
      }
    );
  }
}