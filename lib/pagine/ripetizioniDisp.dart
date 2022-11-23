import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import '../model/insegnamenti.dart';
import '../model/corso.dart';
//import 'package:ripetizioni/model/utente.dart';
import '../model/docente.dart';
import '../model/ripetizioni.dart';
import 'package:http/http.dart' as http;

class CaricaInsegnamentiAPI{
  Future<List<Insegnamenti>> getCaricaInsegnamenti() async {
    const url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletInsegnamenti';
    //print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //List<Insegnamenti> ls = json.decode(response.body)['results'].map((data) => Insegnamenti.fromJson(data)).toList();
      List<dynamic> list = json.decode(response.body);
      List<Insegnamenti> li = <Insegnamenti>[];
      for(int i = 0; i < list.length; i++){
        li.add(Insegnamenti.fromJson(list.elementAt(i)));
      }
      return li;
    } else {
      throw Exception('Failed to load utente');
    }
  }
}



class CaricaPrenotazioneAPI{
  Future<List<List<int>>> getCaricaPrenotazioni(int? c,int? doc,String? usr) async {
    final url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletPrenotazioni?corso=$c&docente=$doc&utente=$usr';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      /*print("list: $list");
      print(list.elementAt(0));*/
      List<List<int>> liPrenotazione = <List<int>>[];

      for(int j=0;j<4;j++){
        List<int> temp=<int>[];
        for(int i=0;i<5;i++){
          temp.add(list.elementAt(j).elementAt(i).hashCode);
        }
        liPrenotazione.add(temp);
      }
      return liPrenotazione;
    } else {
      throw Exception('Failed to load utente');
    }
  }
}

class PaginaRipetizioni extends StatefulWidget {
  const PaginaRipetizioni({super.key});

  @override
  State<PaginaRipetizioni> createState() => _PaginaRipetizioniState();
}

List<Insegnamenti> insegnamenti = <Insegnamenti>[];
List<List<int>> prenotazioni = <List<int>>[];
List<Corso> corsi = <Corso>[];
List<Corso> corsiL = <Corso>[];
List<Docente> docenti = <Docente>[];
List<Docente> docentiL = <Docente>[];
List<List<String>> prenotazioniDisp = <List<String>>[]; // tab che riempie tabella
List<List<Color>> prenotazioniDispC = <List<Color>>[];
List<Ripetizioni> ripetizioni = [
  Ripetizioni(giorno: "Lunedì", ora: "15:00", docente: Docente(matricola: 123, nome: 'mario', cognome: 'dth'), corso: Corso(codice: 123, titoloCorso: 'informatica')),
  Ripetizioni(giorno: "Martedì", ora: "18:00", docente: Docente(matricola: 456, nome: 'divb', cognome: 'af'), corso: Corso(codice: 456, titoloCorso: 'matematica')),
  Ripetizioni(giorno: "Giovedì", ora: "16:00", docente: Docente(matricola: 789, nome: 'ad', cognome: 'th'), corso: Corso(codice: 789, titoloCorso: 'inglese')),
  Ripetizioni(giorno: "Lunedì", ora: "17:00", docente: Docente(matricola: 135, nome: 'av', cognome: 'ayn'), corso: Corso(codice: 135, titoloCorso: 'geometria')),
];
String? docenteScelto;
Docente? docenteSceltoTmp;
int? matricolaDoce;
int? codCorso;
String? corsoScelto;
Corso? corsoSceltoTmp;
bool nuovo = true;
String dropdownValue = "ciaociao";
Utente? utente;

class _PaginaRipetizioniState extends State<PaginaRipetizioni> {

  void riempiTab(){
    for(int i=0;i<4;i++) {
      prenotazioniDisp.add(["disp","disp","disp","disp","disp"]);
      prenotazioniDispC.add([Colors.white,Colors.white,Colors.white,Colors.white,Colors.white]);
    }
  }

  void _callCaricaInsegnamenti(){
    var api = CaricaInsegnamentiAPI();
    api.getCaricaInsegnamenti().then((list) {
      if(list.isNotEmpty) {
        insegnamenti = list; //TODO: mettere nella dichiarazione
        docenti.add(Docente(cognome: "Deseleziona docente", matricola: 0, nome: ""));
        docentiL.add(Docente(cognome: "Deseleziona docente", matricola: 0, nome: ""));
        corsi.add(Corso(codice: 0, titoloCorso: "Deseleziona corso"));
        corsiL.add(Corso(codice: 0, titoloCorso: "Deseleziona corso"));
        setState(() {
          for(int i = 0; i < list.length; i++){
            bool flag = true;
            for(int j = 1; j < docenti.length; j++){
              if(docenti.elementAt(j).matricola == list.elementAt(i).docente.matricola){
                flag = false;
                break;
              }
            }

            if(flag){
              docenti.add(list.elementAt(i).docente);
            }

            flag = true;
            for(int j = 1; j < corsi.length; j++){
              if(corsi.elementAt(j).codice == list.elementAt(i).corso.codice){
                flag = false;
                break;
              }
            }
            if(flag){
              corsi.add(list.elementAt(i).corso);
            }
          }
          for(int k = 1; k < corsi.length; k++){
            corsiL.add(corsi.elementAt(k));
          }
          for(int k = 1; k < docenti.length; k++){
            docentiL.add(docenti.elementAt(k));
          }
        });
      } else {
        print("non ci sono insegnamenti");
      }
    }, onError: (error) {
    });
  }

  void _callCaricaPrenotazione(){
    if(docenteSceltoTmp != null){
      matricolaDoce = docenteSceltoTmp!.matricola;
    }else{
      matricolaDoce= null;
    }
    if(corsoSceltoTmp != null) {
      codCorso = corsoSceltoTmp!.codice;
    }else{
      codCorso=null;
    }
    String? usr;
    if(utente != null){
      usr=(utente!.nomeutente);
    }
    var api = CaricaPrenotazioneAPI();
    api.getCaricaPrenotazioni(codCorso,matricolaDoce,usr).then((list) {
      if(list.isNotEmpty) {
        prenotazioni = list;
        setState((){
          _PrenotazioniDisp();
        });
      } else {
        print("non ci sono prenotazioni");
      }
    }, onError: (error) {
    });

}

  void aggiornaCorsi(){
    if(docenteSceltoTmp != null ){
      if(docenteSceltoTmp!.matricola != 0) {
        setState(() {
          corsiL.removeRange(1, corsiL.length);
          for(int i = 0; i < insegnamenti.length; i++){
            if(insegnamenti.elementAt(i).docente.matricola == docenteSceltoTmp!.matricola){
              corsiL.add(Corso(codice: insegnamenti.elementAt(i).corso.codice, titoloCorso: insegnamenti.elementAt(i).corso.titoloCorso));
            }
          }
        });
      }else {
        setState(() {
          docenteSceltoTmp = null;
          for(int i = 0; i < corsi.length; i++) {
            bool flag = true;
            for(int j = 0; j < corsiL.length; j++){
              if(corsiL.elementAt(j).codice == insegnamenti.elementAt(i).corso.codice){
                flag = false;
                break;
              }
            }
            if(flag){
              corsiL.add(insegnamenti.elementAt(i).corso);
            }
          }
        });
      }
    }
  }

  void aggiornaDocenti(){
    if(corsoSceltoTmp != null ){
      if(corsoSceltoTmp!.codice != 0) {
        setState(() {
          docentiL.removeRange(1, docentiL.length);
          for(int i = 0; i < insegnamenti.length; i++){
            if(insegnamenti.elementAt(i).corso.codice == corsoSceltoTmp!.codice){
              docentiL.add(Docente(cognome: insegnamenti.elementAt(i).docente.cognome, matricola: insegnamenti.elementAt(i).docente.matricola, nome: insegnamenti.elementAt(i).docente.nome));
            }
          }
        });
      } else {
        setState(() {
          corsoSceltoTmp = null;
          for(int i = 0; i < docenti.length; i++) {
            print("docente: ${docenti.elementAt(i).matricola}");
            bool flag = true;
            for(int j = 0; j < docentiL.length; j++){
              if(docentiL.elementAt(j).matricola == insegnamenti.elementAt(i).docente.matricola){
                flag = false;
                break;
              }
            }
            if(flag){
              docentiL.add(insegnamenti.elementAt(i).docente);
            }
          }
        });
      }
    }
  }

 void _PrenotazioniDisp() {
    prenotazioniDisp.removeRange(0, prenotazioniDisp.length);
    prenotazioniDispC.removeRange(0, prenotazioniDispC.length);
    for(int i=0;i<4;i++) {
      List<String> temp= <String>[];
      List<Color> tempC= <Color>[];
      for (int j = 0; j < 5; j++) {
        if(prenotazioni.elementAt(i).elementAt(j) == 0){
          temp.add("DISP");
          tempC.add(Colors.green);
        }else if(prenotazioni.elementAt(i).elementAt(j) == 1){
          temp.add("DOCENTE NON DISP");
          tempC.add(Colors.red);
        }else if(prenotazioni.elementAt(i).elementAt(j) == 2){
          temp.add("UTENTE NON DISP");
          tempC.add(Colors.yellow);
        }
      }
      prenotazioniDisp.add(temp);
      prenotazioniDispC.add(tempC);
    }
  }


  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    utente = arg["utente"];
    bool ricarica = arg["ricarica"];
    if (ricarica == true && nuovo == true) {
      nuovo = false;
      _callCaricaInsegnamenti();
      setState(() {
        riempiTab();
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
                      onChanged: (value) => {
                        docenteSceltoTmp = docentiL.firstWhere((element) => element.matricola == int.parse(value!.split(" ").first)),
                        aggiornaCorsi(),
                      },
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: docentiL.map((el)=>"${el.matricola} ${el.cognome}").toList(),
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
                    onChanged: (value) => {
                      corsoSceltoTmp = corsiL.firstWhere((element) => element.codice == int.parse(value!.split(" ").first)),
                      aggiornaDocenti(),
                    },
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: corsiL.map((el)=>"${el.codice} ${el.titoloCorso}").toList(),
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
                onPressed: () => setState(() {
                  if((corsoSceltoTmp != null && corsoSceltoTmp!.codice != 0) || (docenteSceltoTmp != null  && docenteSceltoTmp!.matricola != 0)) {
                    _callCaricaPrenotazione();
                  }
                }),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Table(
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
                              tile(0, 0),
                              tile(0, 1),
                              tile(0, 2),
                              tile(0, 3),
                              tile(0, 4),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                child: Align(
                                  child: Text(
                                    '16',
                                  ),
                                ),
                              ),
                              tile(1, 0),
                              tile(1, 1),
                              tile(1, 2),
                              tile(1, 3),
                              tile(1, 4),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                child: Align(
                                  child: Text(
                                    '17',
                                  ),
                                ),
                              ),
                              tile(2, 0),
                              tile(2, 1),
                              tile(2, 2),
                              tile(2, 3),
                              tile(2, 4),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                child: Align(
                                  child: Text(
                                    '18',
                                  ),
                                ),
                              ),
                              tile(3, 0),
                              tile(3, 1),
                              tile(3, 2),
                              tile(3, 3),
                              tile(3, 4),
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
    return SizedBox(
      height: 400.0, // Change as per your requirement
      width: 400.0, // Change as per your requirement
      child: ListView(
        shrinkWrap: true,
        children: ripetizioni.map((ripetizione) => ripetizioneTemplate(ripetizione)).toList(),
      ),
    );
  }

  Widget tile(int x, y){
    return GestureDetector(
      onTap: () {
        if(prenotazioni.elementAt(x).elementAt(y) == 0) {
          setState(() {
            mostraConferma(context, indexToDay(x), indexToHour(y));
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: prenotazioniDispC.elementAt(x).elementAt(y),
            border: const Border(
              left: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
              top: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black),
            )),
        child: Padding(
          padding:
          const EdgeInsets.fromLTRB(15, 45, 15, 45),
          child: Align(
            child: Text(
              prenotazioniDisp.elementAt(x).elementAt(y),
            ),
          ),
        ),
      ),
    );
  }

  String indexToDay(int indice){
    String giorno = "";
    switch(indice){
      case 0:
        giorno = "lunedì";
        break;
      case 1:
        giorno =  "martedì";
        break;
      case 2:
        giorno =  "mercoledì";
        break;
      case 3:
        giorno = "giovedì";
        break;
      case 4:
        giorno = "venerdì";
        break;
    }
    return giorno;
  }

   String indexToHour(int indice){
    String orario = "";
    switch(indice){
      case 0:
        orario = "15:00:00";
        break;
      case 1:
        orario =  "16:00:00";
        break;
      case 2:
        orario =  "17:00:00";
        break;
      case 3:
        orario = "18:00:00";
        break;
    }
    return orario;
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
  void confermaPrenotazioneDocCor(BuildContext context, String giorno, String ora) {
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
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "${docenteSceltoTmp!.matricola} ${docenteSceltoTmp!.cognome}",
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "${corsoSceltoTmp!.codice} ${corsoSceltoTmp!.titoloCorso}",
              style: const TextStyle(
                fontSize: 20.0,
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
            onPressed: ((){
              setState(() {
                ripetizioni.add(Ripetizioni(giorno: giorno, ora: ora, docente: Docente(matricola: 123, nome: 'mario', cognome: 'dth '), corso: Corso(codice: 123, titoloCorso: 'informatica')));
              });
              Navigator.pop(context, 'Cancel');
            }),
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
                    'Aggiungi al carrello',
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
            const SizedBox(
              height: 10.0,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items:  docentiL.map((el)=>"${el.matricola} ${el.cognome}").toList(),
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
              items: corsiL.map((el)=>"${el.codice} ${el.titoloCorso}").toList(),
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
                    'Aggiungi al Carrello',
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

  void confermaPrenotazioneCor(BuildContext context, String giorno, String ora) {
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
            const SizedBox(
              height: 10.0,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items:  docentiL.map((el)=>"${el.matricola} ${el.cognome}").toList(),
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
            Text(
              "${corsoSceltoTmp!.codice} ${corsoSceltoTmp!.titoloCorso}",
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
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
                    'Aggiungi al carrello',
                    style: TextStyle(
                      fontSize: 15.0,
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

  void confermaPrenotazioneDoc(BuildContext context, String giorno, String ora) {
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
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "${docenteSceltoTmp!.matricola} ${docenteSceltoTmp!.cognome}",
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items:  corsiL.map((el)=>"${el.codice} ${el.titoloCorso}").toList(),
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
            onPressed: () => {
              Navigator.pop(context, 'Cancel'),
            },
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
                    'Aggiungi al carrello',
                    style: TextStyle(
                      fontSize: 15.0,
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
  void mostraConferma(BuildContext context, String giorno, String ora){
    if(docenteSceltoTmp != null && docenteSceltoTmp!.matricola != 0 && (corsoSceltoTmp == null || corsoSceltoTmp!.codice == 0)) {
      confermaPrenotazioneDoc(context, giorno, ora);
    } else if(corsoSceltoTmp != null && corsoSceltoTmp!.codice != 0 && (docenteSceltoTmp == null || docenteSceltoTmp!.matricola == 0)) {
      confermaPrenotazioneCor(context, giorno, ora);
    } else if(corsoSceltoTmp != null && corsoSceltoTmp!.codice != 0 && docenteSceltoTmp != null  && docenteSceltoTmp!.matricola != 0){
      confermaPrenotazioneDocCor(context, giorno, ora);
    }
  }
}
