import 'package:app_vai/Login/loginUsuario.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginUsuario(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}