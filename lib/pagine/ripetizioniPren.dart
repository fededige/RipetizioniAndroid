import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import 'package:ripetizioni/pagine/ripetizioniDisp.dart';
import 'package:ripetizioni/pagine/ripetizioniPren.dart';
import '../model/docente.dart';
import '../model/corso.dart';
import '../model/ripetizioni.dart';
import 'package:http/http.dart' as http;

// DICHIARAZIONE VARIABILI
List<Ripetizioni> ripetizioni = [];
List<Ripetizioni> ripetizioniEff = <Ripetizioni>[];
List<Ripetizioni> ripetizioniCanc = <Ripetizioni>[];
List<Ripetizioni> visualizza = ripetizioni;
Color colore = Colors.green;
Utente? user;
bool nuovo = true;
bool _isAdmin = true;
bool DaFare = true;
// FINE DICHIARAZIONI VARIBILI

class PaginaRipetizioniPren extends StatefulWidget {
  @override
  State<PaginaRipetizioniPren> createState() => _PaginaRipetizioniPrenState();
}

class CaricaInsegnamentiAPI {
  Future<List<Ripetizioni>> getCaricaRipetizioni(String session, int id) async {
    String url =
        "http://localhost:8081/Ripetizioni_war_exploded/ServletRipetizionieff";
    print("getCaricaRipetizioni" + url);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "session": session,
          "id": id
        })
    );
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<Ripetizioni> liRipetizioni = <Ripetizioni>[];
      print("list: $list");
      for (int i = 0; i < list.length; i++) {
        print(Ripetizioni.fromJson(list.elementAt(i)));
        liRipetizioni.add(Ripetizioni.fromJson(list.elementAt(i)));
      }
      print("50 $liRipetizioni");
      return liRipetizioni;
    } else {
      throw Exception('Failed to load getCaricaRipetizioni');
    }
  }
}

class RipetizioneEffettuataAPI {
  Future<bool> postInserisciPrenotazioneEff(String session, Ripetizioni r) async {
    const url =
        'http://localhost:8081/Ripetizioni_war_exploded/ServletRipetizioniEffettuate';
    //print(url);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "ripetizione": r,
          "session": session,
        })
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load postInserisciPrenotazione');
    }
  }
}

class RipetizioneCancellataAPI {
  Future<bool> postInserisciPrenotazioneCanc(String session, Ripetizioni r) async {
    const url =
        'http://localhost:8081/Ripetizioni_war_exploded/ServletRipetizioneCancellata';
    //print(url);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: <String, dynamic>{
          "ripetizioni": r,
          "session": session
        }
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load postInserisciPrenotazione');
    }
  }
}

class _PaginaRipetizioniPrenState extends State<PaginaRipetizioniPren> {
  responsiveText({required String text, required double dim, required Color color, bool? bold}) { //spostare giù
    return Text(
      text,
      style: TextStyle(
        fontSize: bold != null && bold == true ? (dim + 0.5) * (MediaQuery.of(context).size.height / 100) : dim * (MediaQuery.of(context).size.width / 100),
        color: color,
        fontWeight: bold != null && bold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
  void _callCaricaRipetizioni(String session) {
    var api = CaricaInsegnamentiAPI();
    int id;
    print("_callCaricaRipetizioni");
    if(ripetizioni.isEmpty && ripetizioniEff.isEmpty && ripetizioniCanc.isEmpty ){
      id = 0;
    } else{
      int lenRipetizioni = 0;
      int lenRipetizioniEff = 0;
      int lenRipetizioniCanc = 0;
      if(ripetizioni.isNotEmpty){
        lenRipetizioni = (ripetizioni.last.codice)!;
      }
      if(ripetizioniEff.isNotEmpty){
        lenRipetizioniEff = (ripetizioniEff.last.codice)!;
      }
      if(ripetizioniCanc.isNotEmpty){
        lenRipetizioniCanc = (ripetizioniCanc.last.codice)!;
      }
      id = max(max(lenRipetizioni, lenRipetizioniEff), lenRipetizioniCanc);
    }
    print("id: $id");
    api.getCaricaRipetizioni(session, id).then((list) {
      setState(() {
        if (list.isNotEmpty) {
          for (int i = 0; i < list.length; i++) {
            if (list.elementAt(i).stato == true &&
                list.elementAt(i).effettuata == false) {
              ripetizioni.add(list.elementAt(i));
            } else if (list.elementAt(i).stato == false &&
                list.elementAt(i).effettuata == true) {
              ripetizioniEff.add(list.elementAt(i));
            } else if (list.elementAt(i).stato == false &&
                list.elementAt(i).effettuata == false) {
              ripetizioniCanc.add(list.elementAt(i));
            }
          }
        } else {
          print("errore, non ci sono insegnamenti");
        }
      });
    }, onError: (error) {
      print('errore in _callCaricaRipetizioni');
    });
  }

  void _callPostRipetizioneEff(String session, Ripetizioni r) {
    var api = RipetizioneEffettuataAPI();
    api.postInserisciPrenotazioneEff(session, r).then((list) {
      setState(() {
        if (list == true) {
          ripetizioni.remove(r);
          ripetizioniEff.add(r);
        } else {
          print('errore in _callRipetizioneEff');
        }
      });
    }, onError: (error) {
      print('errore in _callPostRipetizione');
    });
  }

  void _callPostRipetizioneCanc(String session, Ripetizioni r) {
    var api = RipetizioneCancellataAPI();
    api.postInserisciPrenotazioneCanc(session, r).then((list) {
      setState(() {
        if (list == true) {
          ripetizioni.remove(r);
          ripetizioniCanc.add(r);
        } else {
          print('errore in _callRipetizioneEff');
        }
      });
    }, onError: (error) {
      print('errore in _callPostRipetizione');
    });
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    user = arg["utente"];
    bool ricarica = arg["ricarica"];
    print(user!.ruolo);
    if (user!.ruolo == 'cliente') {
      _isAdmin = false;
    }
    if (ricarica == true && nuovo == true) {
      ripetizioni.removeRange(0, ripetizioni.length);
      ripetizioniCanc.removeRange(0, ripetizioniCanc.length);
      ripetizioniEff.removeRange(0, ripetizioniEff.length);
      nuovo = false;
      _callCaricaRipetizioni((user?.session)!);
    }
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text('Ripetizioni Prenotate'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            print("backbutton"),
            nuovo = true,
            Navigator.pop(context, false),
          },
        ),
      ),
      body: ListView(
        //_widgetOptions[_selectedIndex],
        children: <Widget>[
          Column(
            children:
                visualizza.map((ripetizione) => metodo(ripetizione)).toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colore,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse_sharp, color: Colors.white),
            label: 'Da fare',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline, color: Colors.white),
            label: 'Effettuate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close, color: Colors.white),
            label: 'Cancellate',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final _widgetOptions = [PaginaRipetizioniPren()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        visualizza = ripetizioni;
        colore = Colors.green;
      }
      if (index == 1) {
        visualizza = ripetizioniEff;
        colore = Colors.lightGreen;
      }
      if (index == 2) {
        visualizza = ripetizioniCanc;
        colore = Colors.red;
      }
    });
  }

  Widget metodo(ripetizione) {
    if (_selectedIndex == 0) {
      DaFare = true;
      return creaCard(ripetizione);
    }
    DaFare = false;
    return creaCard(ripetizione);
  }

  Widget creaCard(ripetizione) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, //spaceEvenly
        children: <Widget>[
          Container(
            height: 0.13 * MediaQuery.of(context).size.height,
            width: 0.2 * MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                responsiveText(text: ripetizione.giorno, dim: 5.5, color: Colors.white),
                responsiveText(text: "${ripetizione.ora.toString().split(':')[0]}:${ripetizione.ora.toString().split(':')[1]}", dim: 5.5, color: Colors.white),
              ],
            ),
          ),
          SizedBox(
            width: 0.15 * MediaQuery.of(context).size.width,
          ),
          Column(
            children: <Widget>[
              responsiveText(text: "Docente: ${ripetizione.docente.cognome}", dim: 5, color: Colors.black),
              responsiveText(text: "Corso: ${ripetizione.corso.titoloCorso}", dim: 5, color: Colors.black),
              Visibility(
                visible: _isAdmin,
                child: Text(
                  "Utente: ${ripetizione.utente}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ripetizioneEffettuateT(ripetizione) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 110,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        ripetizione.giorno,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        ripetizione.ora,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Docente: ",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text(
                          "Corso: ",
                          style: const TextStyle(fontSize: 20),
                        ),
                        Visibility(
                          visible: _isAdmin,
                          child:const Text(
                            "Utente: ",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ripetizione.docente.cognome,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          ripetizione.corso.titoloCorso,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Visibility(
                          visible: _isAdmin,
                          child: Text(
                            ripetizione.utente,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(
                  width: 0,
                ),
              ),
              Visibility(
                visible: DaFare,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _callPostRipetizioneCanc((user?.session)!, ripetizione);
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
              ),
              Visibility(
                visible: DaFare,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _callPostRipetizioneEff((user?.session)!, ripetizione);
                    });
                  },
                  icon: const Icon(
                    Icons.done_outline_sharp,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
