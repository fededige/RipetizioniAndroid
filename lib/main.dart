import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ripetizioni/pagine/login.dart';
import 'package:ripetizioni/pagine/registrazione.dart';
import 'package:ripetizioni/pagine/homeOspite.dart';
import 'package:ripetizioni/pagine/homeUtente.dart';
import 'package:ripetizioni/pagine/impostazioni.dart';
import 'package:ripetizioni/pagine/cambioPassword.dart';
import 'pagine/ripetizioniDisp.dart';
import 'pagine/ripetizioniPren.dart';


void main() {
      HttpOverrides.global = MyHttpOverrides();
      runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
                '/login': (context) => LoginPage(),
                '/registrazione': (context) => PaginaRegistrazione(),
                '/homeOspite': (context) => PaginaHomeOspite(),
                '/homeUtente': (context) => PaginaHomeUtente(),
                '/impostazioni': (context) => PaginaImpostazioni(),
                '/cambioPassword': (context) => PaginaCambioPassword(),
                '/ripetizioniDisp': (context) => PaginaRipetizioni(),
                '/ripetizioniPren': (context) => PaginaRipetizioniPren(),
          }
      )
      );
}

class MyHttpOverrides extends HttpOverrides{
      @override
      HttpClient createHttpClient(SecurityContext? context){
            return super.createHttpClient(context)
                  ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
      }
}