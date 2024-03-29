import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import 'package:http/http.dart' as http;

class LogOutAPI{
  Future<bool> postLogOut(String session) async {
    const url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletLogOut';
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "session": session,
        })
    );
    if (response.statusCode == 200) {
      if(response.body == "true") {
        return true;
      }
      return false;
    } else {
      throw Exception('Failed to load utente');
    }
  }
}

class PaginaImpostazioni extends StatefulWidget {
  @override
  State<PaginaImpostazioni> createState() => _PaginaImpostazioniState();
}

class _PaginaImpostazioniState extends State<PaginaImpostazioni> {
  String? presentazione = '';

  void _callLogOutAPI(String session) {
    var api = LogOutAPI();
    api.postLogOut(session).then((res) {
    }, onError: (error) {
      print("logout errore");
    });
}



  @override
  Widget build(BuildContext context) {
    Utente utente = ModalRoute.of(context)!.settings.arguments as Utente;
    presentazione = utente.nomeutente;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff0073e6),
        title: const Text(
          'Impostazioni',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Ciao $presentazione',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'EncodeSans',
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 260.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cambioPassword', arguments: utente);
                    },
                    child: const Text(
                      'Cambia password',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Container(
                  width: 260.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _callLogOutAPI((utente.session)!);
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
