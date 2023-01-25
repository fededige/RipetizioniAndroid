import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import 'package:http/http.dart' as http;

class RegistrazioneAPI{
  Future<Utente?> postRegistrazione(String nomeutente, String password, String confpassword) async {
    final url = 'http://10.0.2.2:8081/Ripetizioni_war_exploded/ServletRegistrazione?username=$nomeutente&password=$password&confpassword=$confpassword';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      return Utente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load utente');
    }
  }
}

class PaginaRegistrazione extends StatefulWidget {
  @override
  State<PaginaRegistrazione> createState() => _PaginaRegistrazioneState();
}

class _PaginaRegistrazioneState extends State<PaginaRegistrazione> {
  final nomeutenteController = TextEditingController();
  final passwordController = TextEditingController();
  final confpasswordController = TextEditingController();
  bool visible = true;
  bool visible2 = true;
  String errore = "";

  void _callRegistrazione(String nomeutente, String password, String confpassword) {
    var api = RegistrazioneAPI();
    api.postRegistrazione(nomeutente, password, confpassword).then((utente) {
      if(utente != null) {
        setState(() {
          errore = "";
        });
        Navigator.pushNamed(context, '/homeUtente');
      }
    }, onError: (error) {
      setState(() {
        errore = "username già in uso";
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
                  'Crea Account',
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
                          )
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
                      controller: confpasswordController,
                      obscureText: visible2,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          hintText: 'Conferma Password',
                          hintStyle: TextStyle(
                            fontSize: 17.0,
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
                                visible2 = !visible2;
                              });
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                            color: Colors.grey[600],
                          )
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
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
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
                        if(nomeutenteController.text.isNotEmpty && passwordController.text.isNotEmpty && confpasswordController.text.isNotEmpty) {
                          if(passwordController.text == confpasswordController.text) {
                            _callRegistrazione(nomeutenteController.text, passwordController.text, confpasswordController.text);
                          } else {
                            setState(() {
                              errore = "Le password non corrispondono";
                            });
                          }
                        }
                        else {
                          setState(() {
                            errore = "Campi incompleti";
                          });
                        }
                        //Navigator.pushNamed(context, '/homeUtente');
                      }, //aggiungere navigazione alla Home
                      child: const Text(
                        'Registrati',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
