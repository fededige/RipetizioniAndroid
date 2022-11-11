import 'package:flutter/material.dart';
import 'package:ripetizioni/pagine/login.dart';
import 'package:ripetizioni/pagine/registrazione.dart';
import 'package:ripetizioni/pagine/homeOspite.dart';
import 'package:ripetizioni/pagine/homeUtente.dart';
import 'package:ripetizioni/pagine/impostazioni.dart';
import 'package:ripetizioni/pagine/cambioNomeUtente.dart';
import 'package:ripetizioni/pagine/cambioPassword.dart';
import 'pagine/ripetizioniDisp.dart';


void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(),
      '/registrazione': (context) => PaginaRegistrazione(),
      '/homeOspite': (context) => PaginaHomeOspite(),
      '/homeUtente': (context) => PaginaHomeUtente(),
      '/impostazioni': (context) => PaginaImpostazioni(),
      '/cambioNomeUtente': (context) => PaginaCambioNomeU(),
      '/cambioPassword': (context) => PaginaCambioPassword(),
      '/ripetizioniDisp': (context) => PaginaRipetizioni(),
    }
));