import 'package:flutter/material.dart';
import 'package:ripetizioni/pagine/login.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(),
    }
));