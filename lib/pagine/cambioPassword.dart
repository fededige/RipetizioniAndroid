import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import 'package:http/http.dart' as http;

class CambioPasswordAPI{
  Future<bool> postCambioPassword(String session, String vecchiaPassword, String nuovaPassword) async {
    const url1 = 'http://localhost:8081/Ripetizioni_war_exploded/ServletImpostazioni';
    final response = await http.post(Uri.parse(url1),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "vecchiaPassword": vecchiaPassword,
        "nuovaPassword": nuovaPassword,
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

class PaginaCambioPassword extends StatefulWidget {
  @override
  State<PaginaCambioPassword> createState() => _PaginaCambioPasswordState();
}

class _PaginaCambioPasswordState extends State<PaginaCambioPassword> {
  bool visible = true;
  bool visible2 = true;
  bool visible3 = true;
  final vecchiaPController = TextEditingController();
  final confnuovaPController = TextEditingController();
  final nuovaPController = TextEditingController();
  String errore = "";
  Utente? user;

  void _callCambioPassword(String session, String vecchiaPassword, String nuovaPassword) {
    var api = CambioPasswordAPI();
    api.postCambioPassword(session, vecchiaPassword, nuovaPassword).then((risultato) {
      if(risultato == true) {
        final user = this.user;
        if(user != null) {
          user.password = nuovaPassword;
          _showToast(context);
          Navigator.pushNamed(context, "/homeUtente", arguments: user);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as Utente;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff0073e6),
        title: const Text(
          'Cambio Password',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context, false),
          },
        ),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 260.0,
                child: TextField(
                  controller: vecchiaPController,
                  obscureText: visible,
                  decoration: InputDecoration(
                    labelText: 'Vecchia password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
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
                height: 18.0,
              ),
              SizedBox(
                width: 260.0,
                child: TextField(
                  controller: nuovaPController,
                  obscureText: visible2,
                  decoration: InputDecoration(
                    labelText: 'Nuova password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible2 = !visible2;
                        });
                      },
                      icon: visible2 ? const Icon(
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
                height: 18.0,
              ),
              SizedBox(
                width: 260.0,
                child: TextField(
                  controller: confnuovaPController,
                  obscureText: visible3,
                  decoration: InputDecoration(
                    labelText: 'Conferma nuova password',
                    labelStyle: const TextStyle(
                      fontSize: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible3 = !visible3;
                        });
                      },
                      icon: visible3 ? const Icon(
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
                    if(vecchiaPController.text.isNotEmpty && nuovaPController.text.isNotEmpty &&  confnuovaPController.text.isNotEmpty){
                      if(nuovaPController.text == confnuovaPController.text){
                        if(vecchiaPController.text == user?.password){
                          if(user?.nomeutente != null) {
                            _callCambioPassword((user?.session)!, vecchiaPController.text,  nuovaPController.text);
                          }
                        } else {
                          setState(() {
                            errore = "Vecchia Password errata";
                          });
                        }
                      } else {
                        setState(() {
                          errore = "Le due nuove password non corrispondono";
                        });
                      }
                    } else {
                      setState(() {
                        errore = "Campi incompleti";
                      });
                    }
                  },
                  child: const Text(
                    'Conferma',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    const SnackBar(
      content: Text('Password cambiata correttamente'),
      backgroundColor: Color(0xff0073e6),
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      elevation: 30,
      duration: Duration(milliseconds: 2000),
    ),
  );
}
