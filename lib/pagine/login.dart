import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import 'package:http/http.dart' as http;

class AuthenticationAPI{
  Future<Utente> getAuthentication(String nomeutente, String password) async {
    final url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletAuth?login=$nomeutente&password=$password';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if(response.body == "UtenteInesistente"){
        return Utente(nomeutente: null, password: null, ruolo: null, stato: false, session: null);
      } else if(response.body == "PasswordErrata"){
        return Utente(nomeutente: null, password: null, ruolo: null, stato: true, session: null);
      } else{
        return Utente(nomeutente: nomeutente, password: password, ruolo: response.body.split(";")[1].replaceAll("\"", ""), stato: true, session: response.body.split(";")[0].replaceAll("\"", ""));
      }
    } else {
      throw Exception('Failed to load utente');
    }
  }
}


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nomeutenteController = TextEditingController();
  final passwordController = TextEditingController();
  bool visible = true;
  String errore = "";

  void _callAuthentication(String nomeutente, String password) {
    var api = AuthenticationAPI();
    api.getAuthentication(nomeutente, password).then((utente) {
      if(utente.nomeutente != null) {
        setState(() {
          errore = "";
        });
        Navigator.pushNamed(context, "/homeUtente", arguments: utente);
      } else if( utente.nomeutente == null){
        setState(() {
          if(utente.stato == false){
            errore = "utente inesistente";
          }else if(utente.stato == true){
            errore = "password errata";
          }
        });
      }
    }, onError: (error) {
      setState(() {
        errore = "errore richiesta";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            const SizedBox(
              height: 50.0,
            ),
            const Text(
                'Ripetizioni',
                style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'EncodeSans'
                )
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
                  child: TextField(
                    controller: nomeutenteController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_box,
                        color: Colors.grey[600],
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
                  child: TextField(
                    controller: passwordController,
                    obscureText: visible,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: visible ? const Icon(
                          Icons.visibility,
                        ) : const Icon(
                          Icons.visibility_off,
                        ),
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  errore,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFFE91B0C),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 136.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff0073e6),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if(nomeutenteController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                        _callAuthentication(nomeutenteController.text, passwordController.text);
                      }
                    }, //aggiungere navigazione alla Home
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registrazione');
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/homeOspite');
                  },
                  child: const Text(
                    'Join as Guest',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff0073e6),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
