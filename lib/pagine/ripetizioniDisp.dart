import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import '../model/insegnamenti.dart';
import '../model/corso.dart';
import '../model/docente.dart';
import 'package:http/http.dart' as http;

class CaricaInsegnamentiAPI{
  Future<List<Insegnamenti>> getCaricaInsegnamenti() async {
    const url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletInsegnamenti';
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("ciao");
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

List<Corso> corsi = <Corso>[];
List<String> corsiS = <String>[];
List<Docente> docenti = <Docente>[];
List<String> docentiS = <String>[];
String dropdownValue = "ciaociao";

class _PaginaRipetizioniState extends State<PaginaRipetizioni> {

  void _callCaricaInsegnamenti(){
    var api = CaricaInsegnamentiAPI();
    api.getCaricaInsegnamenti().then((list) {
      if(list.isNotEmpty) {
        print("list.isNotEmpty");
        for(int i = 0; i < list.length; i++){
          corsi.add(list.elementAt(i).corso);
          docenti.add(list.elementAt(i).docente);
        }
        print(corsi.elementAt(0).titoloCorso);
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

  void convertStr(List<Corso> corsi, List<Docente> docenti){ //TODO: gestire solo corsi differenti
    for(int i = 0; i < corsi.length; i++) {
      if (corsiS.contains(corsi.elementAt(i).titoloCorso)) {
        for (int j = 0; j < corsiS.length; j++) {
          if (corsi.elementAt(i).titoloCorso == corsiS.elementAt(j)) {
            corsiS.removeAt(j);
            corsiS.insert(j, "${corsi.elementAt(i).codice} ${corsi.elementAt(i).titoloCorso}");
          }
        }
      } else {
        corsiS.add(corsi.elementAt(i).titoloCorso);
      }
    }
    for(int i = 0; i < docenti.length; i++) {
      if (docentiS.contains(docenti.elementAt(i).cognome)) {
        for (int j = 0; j < docentiS.length; j++) {
          if (docenti.elementAt(i).cognome == docentiS.elementAt(j)) {
            docentiS.removeAt(j);
            docentiS.insert(j, "${docenti.elementAt(i).matricola} ${docenti.elementAt(i).cognome}");
          }
        }
      } else {
        docentiS.add(docenti.elementAt(i).cognome);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Utente utente = arg["utente"];
    bool ricarica = arg["ricarica"];
    if(ricarica == true){
      setState((){
        ricarica = false;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,25.0,0),
                    child: IconButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/impostazioni');
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
                  DropdownSearch<String>(
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
                                    return confermaPrenotazione(context, "Lunedì", "15:00");
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
                                    return confermaPrenotazione(context, "Martedì", "15:00");
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
                                    return confermaPrenotazione(context, "Mercoledì", "15:00");
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
                                    return confermaPrenotazione(context, "Giovedì", "15:00");
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
                                    return confermaPrenotazione(context, "Venerdì", "15:00");
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
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
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
                                    return confermaPrenotazione(context, "Lunedì", "16:00");
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
                                    return confermaPrenotazione(context, "Martedì", "16:00");
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
                                    return confermaPrenotazione(context, "Mercoledì", "16:00");
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
                                    return confermaPrenotazione(context, "Giovedì", "16:00");
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
                                    return confermaPrenotazione(context, "Venerdì", "16:00");
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
                                    return confermaPrenotazione(context, "Lunedì", "17:00");
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
                                    return confermaPrenotazione(context, "Martedì", "17:00");
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
                                    return confermaPrenotazione(context, "Mercoledì", "17:00");
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
                                    return confermaPrenotazione(context, "Giovedì", "17:00");
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
                                    return confermaPrenotazione(context, "Venerdì", "17:00");
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
                                    return confermaPrenotazione(context, "Lunedì", "18:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black))),
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
                                    return confermaPrenotazione(context, "Mercoledì", "18:00");
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
                                    return confermaPrenotazione(context, "Giovedì", "18:00");
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
                                    confermaPrenotazione(context, "Venerdì", "18:00");
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
