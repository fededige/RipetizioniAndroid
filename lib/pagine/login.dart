import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import 'package:http/http.dart' as http;

Future<Utente> fetchUtente(String nomeutente, String password) async {
  String link = 'http://10.0.2.2:8081/Ripetizioni_war_exploded/ServletAuth?login=$nomeutente&password=$password';
  String cio = 'https://jsonplaceholder.typicode.com/albums/1';
  print(link);
  final response;
  if(nomeutente != "") {
    print("nomeutente != 0");
    response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      print("response OK");
      return Utente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load utente');
    }
  }
  return Utente(nomeutente: null, password: null, ruolo: null);
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nomeutenteController = TextEditingController();
  final passwordController = TextEditingController();
  late Future<Utente> futureUtente = fetchUtente(nomeutenteController.text, passwordController.text);
  bool visible = true;
  bool passwordSbagliata = false;
  bool utenteInesistente = false;
  bool transit = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomeutenteController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Utente>(
          future: futureUtente,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.nomeutente == null){
                passwordSbagliata = true;
              }
              else {
                print("ciao");
                transit = true;
              }
            } else if (!snapshot.hasData) {
              utenteInesistente = true;
            } else if (snapshot.hasError) {
              Text('${snapshot.error}');
            }

            return Column(
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
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Container(
                      width: 136.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            futureUtente = fetchUtente(nomeutenteController.text, passwordController.text);
                            print("s.hD");
                            print(snapshot.data!.nomeutente);
                          });
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
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
