import 'package:flutter/material.dart';
import 'package:ripetizioni/pagine/login.dart';
import 'package:ripetizioni/pagine/registrazione.dart';
import 'package:ripetizioni/pagine/homeOspite.dart';
import 'package:ripetizioni/pagine/homeUtente.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/homeUtente',
    routes: {
      '/login': (context) => LoginPage(),
      '/registrazione': (context) => PaginaRegistrazione(),
      '/homeOspite': (context) => PaginaHomeOspite(),
      '/homeUtente': (context) => PaginaHomeUtente(),
    }
));