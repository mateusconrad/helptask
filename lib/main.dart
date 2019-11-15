import 'package:app_vai/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}