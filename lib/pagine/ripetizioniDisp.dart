import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import '../model/insegnamenti.dart';
import '../model/corso.dart';
import '../model/docente.dart';
import '../model/ripetizioni.dart';
import 'package:http/http.dart' as http;

class CaricaInsegnamentiAPI{
  Future<List<Insegnamenti>> getCaricaInsegnamenti() async {
    const url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletInsegnamenti';
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //List<Insegnamenti> ls = json.decode(response.body)['results'].map((data) => Insegnamenti.fromJson(data)).toList();
      List<dynamic> list = json.decode(response.body);
      List<Insegnamenti> li = <Insegnamenti>[];
      print("list: $list");
      for(int i = 0; i < list.length; i++){
        li.add(Insegnamenti.fromJson(list.elementAt(i)));
      }
      return li;
    } else {
      throw Exception('Failed to load utente');
    }
  }
}

class PaginaRipetizioni extends StatefulWidget {
  @override
  State<PaginaRipetizioni> createState() => _PaginaRipetizioniState();
}

List<Insegnamenti> insegnamenti = <Insegnamenti>[];
List<Corso> corsi = <Corso>[];
List<String> corsiS = ["Deseleziona Corso"];
List<Docente> docenti = <Docente>[];
List<String> docentiS = ["Deseleziona Docente"];
List<Ripetizioni> ripetizioni = [
  Ripetizioni(giorno: "Lunedì", ora: "15:00", docente: Docente(matricola: 123, nome: 'mario', cognome: 'dth'), corso: Corso(codice: 123, titoloCorso: 'informatica')),
  Ripetizioni(giorno: "Martedì", ora: "18:00", docente: Docente(matricola: 456, nome: 'divb', cognome: 'af'), corso: Corso(codice: 456, titoloCorso: 'matematica')),
  Ripetizioni(giorno: "Giovedì", ora: "16:00", docente: Docente(matricola: 789, nome: 'ad', cognome: 'th'), corso: Corso(codice: 789, titoloCorso: 'inglese')),
  Ripetizioni(giorno: "Lunedì", ora: "17:00", docente: Docente(matricola: 135, nome: 'av', cognome: 'ayn'), corso: Corso(codice: 135, titoloCorso: 'geometria')),
];
String? docenteScelto;
String? corsoScelto;
bool nuovo = true;
String dropdownValue = "ciaociao";

class _PaginaRipetizioniState extends State<PaginaRipetizioni> {

  void _callCaricaInsegnamenti(){
    var api = CaricaInsegnamentiAPI();
    api.getCaricaInsegnamenti().then((list) {
      if(list.isNotEmpty) {
        insegnamenti = list;
        print("list.isNotEmpty");
        for(int i = 0; i < list.length; i++){
          corsi.add(list.elementAt(i).corso);
          docenti.add(list.elementAt(i).docente);
        }
        print(corsi);
        convertStr(corsi, docenti);
      } else {
        /*setState(() {
        errore = "non ci sono insegnamenti";
      });*/
      }
    }, onError: (error) {
      print('errore');
    });
  }


  void convertStr(List<Corso> corsi, List<Docente> docenti){
    for(int i = 0; i < corsi.length; i++) {
      String temp = "${corsi.elementAt(i).codice} ${corsi.elementAt(i).titoloCorso}";
      if (!corsiS.contains(temp)) {
        corsiS.add("${corsi.elementAt(i).codice} ${corsi.elementAt(i).titoloCorso}");
      }
    }

    for(int i = 0; i < docenti.length; i++) {
      String temp = "${docenti.elementAt(i).matricola} ${docenti.elementAt(i).cognome}";
      if (!docentiS.contains(temp)) {
        docentiS.add("${docenti.elementAt(i).matricola} ${docenti.elementAt(i).cognome}");
      }
    }

    print(corsiS);
    print(docentiS);
  }

  void aggiornaCorsi(){
    print("aggiorna Corsi");
    if(docenteScelto != null ){
      print("!= null");
      if(docenteScelto != "Deseleziona Docente") {
        setState(() {
          corsiS.removeRange(1, corsiS.length);
          for(int i = 0; i < insegnamenti.length; i++){
            if("${insegnamenti.elementAt(i).docente.matricola} ${insegnamenti.elementAt(i).docente.cognome}" == docenteScelto){
              corsiS.add("${insegnamenti.elementAt(i).corso.codice} ${insegnamenti.elementAt(i).corso.titoloCorso}");
            }
          }
        });
      }else {
        print("spazio");
        setState(() {
          docenteScelto = null;
          for(int i = 0; i < corsi.length; i++) {
            String temp = "${corsi.elementAt(i).codice} ${corsi.elementAt(i).titoloCorso}";
            if (!corsiS.contains(temp)) {
              corsiS.add("${corsi.elementAt(i).codice} ${corsi.elementAt(i).titoloCorso}");
            }
          }
        });
      }
    }
  }

  void aggiornaDocenti(){
    print("aggiorna Docenti");
    if(corsoScelto != null ){
      if(corsoScelto != "Deseleziona Corso") {
        setState(() {
          docentiS.removeRange(1, docentiS.length);
          for(int i = 0; i < insegnamenti.length; i++){
            if("${insegnamenti.elementAt(i).corso.codice} ${insegnamenti.elementAt(i).corso.titoloCorso}" == corsoScelto){
              docentiS.add("${insegnamenti.elementAt(i).docente.matricola} ${insegnamenti.elementAt(i).docente.cognome}");
            }
          }
        });
      } else {
        setState(() {
          corsoScelto = null;
          for(int i = 0; i < docenti.length; i++) {
            String temp = "${docenti.elementAt(i).matricola} ${docenti.elementAt(i).cognome}";
            if (!docentiS.contains(temp)) {
              docentiS.add("${docenti.elementAt(i).matricola} ${docenti.elementAt(i).cognome}");
            }
          }
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Utente utente = arg["utente"];
    bool ricarica = arg["ricarica"];
    if (ricarica == true && nuovo == true) {
      nuovo = false;
      setState(() {
        _callCaricaInsegnamenti();
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Ripetizioni Disponibili',
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 25.0, 0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            carrelloPrenotazioni(context);
                          });
                        },
                        iconSize: 35.0,
                        icon: const Icon(
                          color: Colors.black,
                          Icons.shopping_cart_sharp,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownSearch<String>(
                      onChanged: (value) =>
                      {
                        docenteScelto = value,
                        print("docente scelto $docenteScelto"),
                        aggiornaCorsi(),
                      },
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: docentiS,
                      dropdownSearchDecoration: const InputDecoration(
                        constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
                        labelText: "Scegli Professore",
                        contentPadding: EdgeInsets.all(8.0),
                      ),

                      showSearchBox: true,
                      searchFieldProps: const TextFieldProps(
                        cursorColor: Colors.blue,
                      ),
                    ),
                    DropdownSearch<String>(
                      onChanged: (value) =>
                      {
                        print("corso scelto $corsoScelto"),
                        corsoScelto = value,
                        aggiornaDocenti(),
                      },
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: corsiS,
                      dropdownSearchDecoration: const InputDecoration(
                        constraints: BoxConstraints(maxWidth: 170, maxHeight: 50),
                        labelText: "Scegli Materia",
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      //selectedItem: "",
                      showSearchBox: true,
                      searchFieldProps: const TextFieldProps(
                        cursorColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextButton(
                  onPressed: null,
                  child: Container(
                    width: 100.0,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ), //aggiungere navigazione alla Home
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Align(
                        child: Text(
                          'Cerca',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Column(
                  children: <Widget>[
                    /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const <Widget>[
                            Text('L'),
                            Text('M'),
                            Text('M'),
                            Text('G'),
                            Text('V'),
                          ]),
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Table(
                          /*border: const TableBorder(
                            horizontalInside: BorderSide(
                              color : Colors.black,
                            ),
                            verticalInside: BorderSide(
                              color : Colors.black,
                            ),
                            right: BorderSide(
                              color : Colors.black,
                            ),
                            /*bottom: BorderSide(
                              color : Colors.black,
                            )*/
                          ),*/
                          columnWidths: const <int, TableColumnWidth>{
                            0: IntrinsicColumnWidth(),
                            1: IntrinsicColumnWidth(),
                            2: IntrinsicColumnWidth(),
                            3: IntrinsicColumnWidth(),
                            4: IntrinsicColumnWidth(),
                            5: IntrinsicColumnWidth(),
                          },
                          children: [
                            const TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Text(
                                    ' ',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Text(
                                    'L',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Text(
                                    'M',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Text(
                                    'M',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Text(
                                    'G',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Text(
                                    'V',
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      '15',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Lunedì", "15:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(color: Colors.black),
                                          right: BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Martedì", "15:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Mercoledì", "15:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Giovedì", "15:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Venerdì", "15:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        '16',
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Lunedì", "16:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Martedì", "16:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Mercoledì", "16:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Giovedì", "16:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Venerdì", "16:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        '17',
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Lunedì", "17:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Martedì", "17:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Mercoledì", "17:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Giovedì", "17:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Venerdì", "17:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        '18',
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Lunedì", "18:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.black),
                                            bottom: BorderSide(
                                                color: Colors.black),
                                            left: BorderSide(
                                                color: Colors.black))),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(context, "Martedì", "18:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      right: BorderSide(color: Colors.black),
                                      bottom: BorderSide(color: Colors.black),
                                    )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Mercoledì", "18:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      return confermaPrenotazione(
                                          context, "Giovedì", "18:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      confermaPrenotazione(
                                          context, "Venerdì", "18:00");
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                        )),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 45, 15, 45),
                                      child: Align(
                                        child: Text(
                                          'Disp',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget setupAlertDialoadContainer() {
    return Container(
      height: 400.0, // Change as per your requirement
      width: 400.0, // Change as per your requirement
      child: ListView(
        shrinkWrap: true,
        children: ripetizioni.map((ripetizione) => ripetizioneTemplate(ripetizione)).toList(),
      ),
    );
  }
  Widget ripetizioneTemplate(ripetizione){
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 85,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      ripetizione.giorno,
                      style: const TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Text(
                      ripetizione.ora,
                      style: const TextStyle(
                          fontSize: 20
                      ),
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
                    style: const TextStyle(
                        fontSize: 20
                    ),
                  ),
                  Text(
                    ripetizione.corso.titoloCorso,
                    style: const TextStyle(
                        fontSize: 20
                    ),
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
                  ripetizioni.remove(ripetizione);
                  Navigator.pop(context, 'Cancel');
                  carrelloPrenotazioni(context);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void carrelloPrenotazioni(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Carrello ripetizioni'),
            content: setupAlertDialoadContainer(),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ), //aggiungere navigazione alla Home
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: const <Widget>[
                        Text(
                          "Aggiungi",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          color: Colors.white,
                          Icons.add_shopping_cart,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Container(
                  width: 105.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ), //aggiungere navigazione alla Home
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Align(
                      child: Text(
                        'Prenota',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}

void confermaPrenotazione(BuildContext context, String giorno, String ora) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: const Text('Riepilogo'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Giorno: $giorno',
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Ora: $ora',
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: docentiS,
            dropdownSearchDecoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
              labelText: "Scegli Professore",
              contentPadding: EdgeInsets.all(8.0),
            ),
            //selectedItem: "",
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              cursorColor: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: corsiS,
            dropdownSearchDecoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
              labelText: "Scegli Corso",
              contentPadding: EdgeInsets.all(8.0),
            ),
            //selectedItem: "",
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              cursorColor: Colors.blue,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Container(
            width: 100.0,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Colors.black,
                width: 3.0,
              ),
            ), //aggiungere navigazione alla Home
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Container(
            width: 105.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Colors.black,
                width: 3.0,
              ),
            ), //aggiungere navigazione alla Home
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                child: Text(
                  'Conferma',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
