import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import '../model/docente.dart';
import '../model/corso.dart';
import '../model/ripetizioni.dart';
import 'package:http/http.dart' as http;

// DICHIARAZIONE VARIABILI
List<Ripetizioni> ripetizioniTot = <Ripetizioni>[];

List<Ripetizioni> ripetizioni = [
  /*Ripetizioni(giorno: "Lunedì", ora: "15:00", docente: Docente(matricola: 123, nome: 'mario', cognome: 'dth'), corso: Corso(codice: 123, titoloCorso: 'informatica'), stato: true,effettuata: true),
  Ripetizioni(giorno: "Martedì", ora: "18:00", docente: Docente(matricola: 456, nome: 'divb', cognome: 'af'), corso: Corso(codice: 456, titoloCorso: 'matematica'), stato: true,effettuata: true),
  Ripetizioni(giorno: "Giovedì", ora: "16:00", docente: Docente(matricola: 789, nome: 'ad', cognome: 'th'), corso: Corso(codice: 789, titoloCorso: 'inglese'), stato: true,effettuata: false),
  Ripetizioni(giorno: "Lunedì", ora: "17:00", docente: Docente(matricola: 135, nome: 'av', cognome: 'ayn'), corso: Corso(codice: 135, titoloCorso: 'geometria'), stato: true,effettuata: true),
  */
];

List<Ripetizioni> ripetizioniEff = <Ripetizioni>[
  Ripetizioni(
      giorno: "Giovedì",
      ora: "16:00",
      docente: Docente(matricola: 789, nome: 'ad', cognome: 'th'),
      corso: Corso(codice: 789, titoloCorso: 'inglese'),
      stato: true,
      effettuata: true,
      utente: 'ema'),
];
List<Ripetizioni> ripetizioniCanc = <Ripetizioni>[];
List<Ripetizioni> visualizza = ripetizioni;
Color colore = Colors.green;
Utente? user;
bool nuovo=true;
// FINE DICHIARAZIONI VARIBILI

class PaginaRipetizioniPren extends StatefulWidget {
  @override
  State<PaginaRipetizioniPren> createState() => _PaginaRipetizioniPrenState();
}

class CaricaInsegnamentiAPI {
Future<List<Ripetizioni>> getCaricaRipetizioni(String usr) async {
  String url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletRipetizionieff?utente=$usr';
  print(url);
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    //List<Insegnamenti> ls = json.decode(response.body)['results'].map((data) => Insegnamenti.fromJson(data)).toList();
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
  Future<bool> postInserisciPrenotazioneEff(Ripetizioni r) async {
    const url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletRipetizioniEffettuate';
    print(url);
    String RipetEff = jsonEncode(r);
    print("71 a");
    print(RipetEff);
    final response = await http.post(Uri.parse(url), headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: RipetEff
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load postInserisciPrenotazione');
    }
  }
}

class RipetizioneCancellataAPI {
  Future<bool> postInserisciPrenotazioneCanc(Ripetizioni r) async {
    const url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletRipetizioneCancellata';
    print(url);
    String RipetEff = jsonEncode(r);
    print("71 a");
    print(RipetEff);
    final response = await http.post(Uri.parse(url), headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: RipetEff
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

void _callCaricaRipetizioni() {
  print('_PaginaRipetizioniState._callCaricaRipetizioni');
  var api = CaricaInsegnamentiAPI();
  api.getCaricaRipetizioni((user!.nomeutente)!).then((list) {
    ripetizioni.removeRange(0, ripetizioni.length);
    ripetizioniEff.removeRange(0, ripetizioni.length);
    ripetizioniCanc.removeRange(0, ripetizioni.length);
    setState(() {
    if (list.isNotEmpty) {
      //ripetizioniTot = list;
      //print("list.isNotEmpty");
      print(list);
      for (int i = 0; i < list.length; i++) {
        print(list.elementAt(i).stato);
        print(list.elementAt(i).effettuata);
        if (list.elementAt(i).stato == true &&
            list.elementAt(i).effettuata == false) {
          ripetizioni.add(list.elementAt(i));
        } else if (list.elementAt(i).stato == false &&
            list.elementAt(i).effettuata == true) {
          ripetizioniEff.add(list.elementAt(i));
        } else if (list.elementAt(i).stato == false && list.elementAt(i).effettuata == false) {
          ripetizioniCanc.add(list.elementAt(i));
        }
        /*print("73" );
        print(ripetizioni.elementAt(0).corso.codice);*/
      }
      // print("corsi: ");
      // print(corsi);
    } else {
      print("errore, non ci sono insegnamenti");
      /*setState(() {
        errore = "non ci sono insegnamenti";
      });*/
    }
   });
  }, onError: (error) {
    print('errore in _callCaricaRipetizioni');
  });
}

void _callPostRipetizioneEff(Ripetizioni r) {
  var api = RipetizioneEffettuataAPI();
  api.postInserisciPrenotazioneEff(r).then((list) {
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

void _callPostRipetizioneCanc(Ripetizioni r) {
  var api = RipetizioneCancellataAPI();
  api.postInserisciPrenotazioneCanc(r).then((list) {
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
    if(ricarica == true && nuovo == true){
      nuovo=false;
      _callCaricaRipetizioni();
    }
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text('Ripetizioni Prenotate'),
        centerTitle: true,
        backgroundColor: Colors.blue,
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
      return ripetizioneEffettuateT(ripetizione);
    }
    return ripetizioneTempl(ripetizione);
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
                width: 100,
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
                child: Column(
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
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(
                  width: 0,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _callPostRipetizioneCanc(ripetizione);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _callPostRipetizioneEff(ripetizione);
                  });
                },
                icon: const Icon(
                  Icons.done_outline_sharp,
                  color: Colors.green,
                ),
              ),
            ],
          )),
    );
  }

  Widget ripetizioneTempl(ripetizione) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
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
                child: Column(
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
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(
                  width: 0,
                ),
              ),
            ],
          )),
    );
  }
}
