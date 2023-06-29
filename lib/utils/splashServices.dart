import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/screens/login.dart';

class splashServices {
  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    });
  }
}
