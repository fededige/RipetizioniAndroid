import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import 'package:http/http.dart' as http;

class CambioPasswordAPI{
  Future<bool> postCambioPassword(String nomeutente, String vecchiaPassword, String nuovaPassword, String confNuovaPassword) async {
    final url = 'http://10.0.2.2:8081/Ripetizioni_war_exploded/ServletImpostazioni?nomeUtente=$nomeutente&vecchiaPassword=$vecchiaPassword&nuovaPassword=$nuovaPassword&confermaNuovaPassword=$confNuovaPassword';
    final response = await http.post(Uri.parse(url));
    print(response.body);
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
  bool transit = false;

  void _callCambioPassword(String nomeutente, String vecchiaPassword, String nuovaPassword, String confNuovaPassword) {
    var api = CambioPasswordAPI();
    api.postCambioPassword(nomeutente, vecchiaPassword, nuovaPassword, confNuovaPassword).then((risultato) {
      if(risultato == true) {
        setState(() {
          errore = "";
          transit = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Utente utente = ModalRoute.of(context)!.settings.arguments as Utente;
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
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
                      icon: const Icon(
                        Icons.remove_red_eye,
                      ),
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
                      icon: const Icon(
                        Icons.remove_red_eye,
                      ),
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
                      icon: const Icon(
                        Icons.remove_red_eye,
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
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    if(transit) {
                      Navigator.pushNamed(context, "/impostazioni", arguments: utente);
                    } else if(vecchiaPController.text.isNotEmpty && nuovaPController.text.isNotEmpty &&  confnuovaPController.text.isNotEmpty){
                      transit = false;
                      if(nuovaPController.text == confnuovaPController.text){
                        if(vecchiaPController.text == utente.password){
                          if(utente.nomeutente != null) {
                            _callCambioPassword(utente.nomeutente!, vecchiaPController.text,  nuovaPController.text,  confnuovaPController.text);
                          }
                        } else {
                          setState(() {
                            errore = "Le due nuove password non corrispondono";
                          });
                        }

                      } else {
                        setState(() {
                          errore = "Vecchia Password errata";
                        });
                      }
                    } else {
                      setState(() {
                        errore = "Campi incompleti";
                      });
                    }
                    //Navigator.pushNamed(context, '/homeUtente');
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
