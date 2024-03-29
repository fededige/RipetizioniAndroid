import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
import '../model/insegnamenti.dart';
import '../model/corso.dart';

import '../model/docente.dart';
import '../model/ripetizioni.dart';
import 'package:http/http.dart' as http;

class CaricaInsegnamentiAPI {
  Future<List<Insegnamenti>> getCaricaInsegnamenti(int length) async {
    String url =
        'http://localhost:8081/Ripetizioni_war_exploded/ServletInsegnamenti?id=$length';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<Insegnamenti> li = <Insegnamenti>[];
      if(list.isNotEmpty){
        for (int i = 0; i < list.length; i++) {
          li.add(Insegnamenti.fromJson(list.elementAt(i)));
        }
      }
      return li;
    } else {
      throw Exception('Errore in getCaricaInsegnamenti');
    }
  }
}

class InserisciPrenotazioniAPI {
  Future<List<dynamic>> postInserisciPrenotazioni(String session, List<Ripetizioni> prenotazioni) async {
    const url =
        'http://localhost:8081/Ripetizioni_war_exploded/ServletInserimentoRipetizioni';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "prenotazione": prenotazioni.map((el) => el.toJson()).toList(),
        "session": session,
      })
    );
    if (response.statusCode == 200) {
      List<dynamic> res = jsonDecode(response.body);
      return res;
    } else {
      throw Exception('Failed to insert ripetizioni in cart.');
    }
  }
}

class CaricaDocentiAPI {
  Future<List<Docente>> getCaricaDocenti(
      int corso, String giorno, String ora) async {
    final url =
        'http://localhost:8081/Ripetizioni_war_exploded/ServletDocentiDisp?corso=$corso&giorno=$giorno&ora=$ora';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<Docente> doc = <Docente>[];
      for (int i = 0; i < list.length; i++) {
        doc.add(Docente.fromJson(list.elementAt(i)));
      }
      return doc;
    } else {
      throw Exception('Errore in getCaricaDocenti');
    }
  }
}

class CaricaPrenotazioneAPI {
  Future<List<List<int>>> getCaricaPrenotazioni(
      int? c, int? doc, String session) async {
    const url = 'http://localhost:8081/Ripetizioni_war_exploded/ServletPrenotazioni';
    final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "corso": c,
        "docente": doc,
        "session": session,
      })
    );
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<List<int>> liPrenotazione = <List<int>>[];
      for (int j = 0; j < 4; j++) {
        List<int> temp = <int>[];
        for (int i = 0; i < 5; i++) {
          temp.add(list.elementAt(j).elementAt(i).hashCode);
        }
        liPrenotazione.add(temp);
      }
      return liPrenotazione;
    } else {
      throw Exception('Errore in getCaricaPrenotazioni');
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
List<Corso> corsi = <Corso>[Corso(codice: 0, titoloCorso: "Deseleziona corso")];
List<Corso> corsiL = <Corso>[
  Corso(codice: 0, titoloCorso: "Deseleziona corso")
];
List<Corso> corsiNonOccu = <Corso>[];
List<Docente> docenti = <Docente>[
  Docente(cognome: "Deseleziona docente", matricola: 0, nome: "")
];
List<Docente> docentiL = <Docente>[
  Docente(cognome: "Deseleziona docente", matricola: 0, nome: "")
];
List<Docente> docentiNonOccu = <Docente>[];
List<List<String>> prenotazioniDisp =
    <List<String>>[]; // tab che riempie tabella

List<String> ripetizioniDispLun = <String>[];
List<String> ripetizioniDispMar = <String>[];
List<String> ripetizioniDispMer = <String>[];
List<String> ripetizioniDispGio = <String>[];
List<String> ripetizioniDispVen = <String>[];

List<Ripetizioni> ripetizioni = [];
List<Ripetizioni> ripetizioniDisponibili = [];
List<String> visualizza = ["prova"];

Docente? docenteScelto;
Docente? docenteSceltoTmp;
Docente? docenteToCart;
int? matricolaDoce;
int? codCorso;
Corso? corsoScelto;
Corso? corsoSceltoTmp;
Corso? corsoToCart;
bool nuovo = true;
String dropdownValue = "ciaociao";
Utente? utente;
bool _isVisibile = true;
String? messaggioInserimento;
String giornoScelto = "";
double larghezzaSchermo=0;
double altezzaSchermo=0;
String schermo='';
List<bool> giornoCliccato = [];
List<List<Color>> cardBackGroundColors = <List<Color>>[[const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)]];
class _PaginaRipetizioniState extends State<PaginaRipetizioni> {
  void riempiTab() {
    prenotazioniDisp.removeRange(0, prenotazioniDisp.length);
    //prenotazioniDispC.removeRange(0, prenotazioniDispC.length);
  }

  void _callInserisciPrenotazioni(String session, List<Ripetizioni> prenotazioni) {
    var api = InserisciPrenotazioniAPI();
    api.postInserisciPrenotazioni(session, prenotazioni).then((res) {
      if (res.isEmpty){
        messaggioInserimento = "prenotazioni confermate";
      } else {
        messaggioInserimento = "La ripetizione rimasta nel carrello non poteva essere prenotata";
      }
      _showToast(context, messaggioInserimento!);
      if(res.isEmpty){
        ripetizioni.removeRange(0, ripetizioni.length);
      }else{
        res.sort();
        for(int i = ripetizioni.length - 1; i >= 0; i--){
          if(!res.contains(i)){
            ripetizioni.removeAt(i);
          }
        }
      }
      if ((corsoScelto != null && corsoScelto!.codice != 0) ||
          (docenteScelto != null && docenteScelto!.matricola != 0)) {
        setState(() {
          _callCaricaPrenotazione();
        });
      }
    }, onError: (error) {
      _showToast(context, "Errore durante la fase di prenotazione, riprova");
    });
  }

  void _callCaricaInsegnamenti() {
    var api = CaricaInsegnamentiAPI();
    api.getCaricaInsegnamenti(insegnamenti.length).then((list) {
      if (list.isNotEmpty) {
        insegnamenti = list;
        setState(() {
          for (int i = 0; i < list.length; i++) {
            bool flag = true;
            for (int j = 1; j < docenti.length; j++) {
              if (docenti.elementAt(j).matricola ==
                  list.elementAt(i).docente.matricola) {
                flag = false;
                break;
              }
            }
            if (flag) {
              docenti.add(list.elementAt(i).docente);
            }

            flag = true;
            for (int j = 1; j < corsi.length; j++) {
              if (corsi.elementAt(j).codice == list.elementAt(i).corso.codice) {
                flag = false;
                break;
              }
            }
            if (flag) {
              corsi.add(list.elementAt(i).corso);
            }
          }
          for (int k = 1; k < corsi.length; k++) {
            corsiL.add(corsi.elementAt(k));
          }
          for (int k = 1; k < docenti.length; k++) {
            docentiL.add(docenti.elementAt(k));
          }
        });
      } else {
        print("non ci sono insegnamenti da aggiungere");
      }
    }, onError: (error) {});
  }

  void _callCaricaPrenotazione() {
    ripetizioniDispLun = [];
    ripetizioniDispMar = [];
    ripetizioniDispMer = [];
    ripetizioniDispGio = [];
    ripetizioniDispVen = [];

    if (docenteSceltoTmp != null) {
      matricolaDoce = docenteSceltoTmp!.matricola;
    } else {
      matricolaDoce = null;
    }
    if (corsoSceltoTmp != null) {
      codCorso = corsoSceltoTmp!.codice;
    } else {
      codCorso = null;
    }
    String usr = "null";
    if (utente?.nomeutente != "") {
      usr = (utente?.session)!;
    }
    var api = CaricaPrenotazioneAPI();
    api.getCaricaPrenotazioni(codCorso, matricolaDoce, usr).then((list) {
      docenteScelto = docenteSceltoTmp;
      corsoScelto = corsoSceltoTmp;
      if (list.isNotEmpty) {
        prenotazioni = list;
        setState(() {
          _prenotazioniDisp();
        });
      } else {
        print("non ci sono prenotazioni");
      }
    }, onError: (error) {
      print(error);
    });
  }

  void aggiornaCorsi() {
    if (docenteScelto != null) {
      if (docenteScelto!.matricola != 0) {
        setState(() {
          corsiL.removeRange(1, corsiL.length);
          for (int i = 0; i < insegnamenti.length; i++) {
            if (insegnamenti.elementAt(i).docente.matricola ==
                docenteScelto!.matricola) {
              corsiL.add(Corso(
                  codice: insegnamenti.elementAt(i).corso.codice,
                  titoloCorso: insegnamenti.elementAt(i).corso.titoloCorso));
            }
          }
        });
      } else {
        setState(() {
          docenteScelto = null;
          for (int i = 0; i < corsi.length; i++) {
            bool flag = true;
            for (int j = 0; j < corsiL.length; j++) {
              if (corsiL.elementAt(j).codice ==
                  insegnamenti.elementAt(i).corso.codice) {
                flag = false;
                break;
              }
            }
            if (flag) {
              corsiL.add(insegnamenti.elementAt(i).corso);
            }
          }
        });
      }
    }
  }

  void aggiornaDocenti() {
    if (corsoScelto != null) {
      if (corsoScelto!.codice != 0) {
        setState(() {
          docentiL.removeRange(1, docentiL.length);
          for (int i = 0; i < insegnamenti.length; i++) {
            if (insegnamenti.elementAt(i).corso.codice ==
                corsoScelto!.codice) {
              docentiL.add(Docente(
                  cognome: insegnamenti.elementAt(i).docente.cognome,
                  matricola: insegnamenti.elementAt(i).docente.matricola,
                  nome: insegnamenti.elementAt(i).docente.nome));
            }
          }
        });
      } else {
        setState(() {
          corsoScelto = null;
          for (int i = 0; i < docenti.length; i++) {
            bool flag = true;
            for (int j = 0; j < docentiL.length; j++) {
              if (docentiL.elementAt(j).matricola ==
                  insegnamenti.elementAt(i).docente.matricola) {
                flag = false;
                break;
              }
            }
            if (flag) {
              docentiL.add(insegnamenti.elementAt(i).docente);
            }
          }
        });
      }
    }
  }

  void _prenotazioniDisp() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 5; j++) {
        if (prenotazioni.elementAt(i).elementAt(j) == 0) {
          switch (j) {
            case 0:
              ripetizioniDispLun.add(indexToHour(i));
              break;
            case 1:
              ripetizioniDispMar.add(indexToHour(i));
              break;
            case 2:
              ripetizioniDispMer.add(indexToHour(i));
              break;
            case 3:
              ripetizioniDispGio.add(indexToHour(i));
              break;
            case 4:
              ripetizioniDispVen.add(indexToHour(i));
              break;
          }
        }
      }
    }
    for(int i = 1; i < 5; i++){
      giornoCliccato[i] = false;
    }
    giornoCliccato[0] = true;
    visualizza = ripetizioniDispLun;
  }

  Widget creaCard(ripetizione, context) {
    return GestureDetector(
      onTap: () {
        mostraConferma(context, giornoScelto, ripetizione);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, //spaceEvenly
          children: <Widget>[
            Container(
              height: 0.13 * altezzaSchermo,
              width: 0.2 * larghezzaSchermo,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: cardBackGroundColors[dayToIndex(giornoScelto)][hourToIndex(ripetizione)],
              ),
              child: Align(
                child: responsiveText(text: "${ripetizione.toString().split(':')[0]}:${ripetizione.toString().split(':')[1]}", dim: 5.5, color: Colors.white),
              ),
            ),
            SizedBox(
              width: larghezzaSchermo  * 0.15,
            ),
            Column(
              children: <Widget>[
                Visibility(
                  visible: docenteScelto != null && docenteScelto?.matricola != 0,
                  child:
                    responsiveText(text: docenteScelto != null && docenteScelto?.matricola != 0 ? "Docente: ${docenteScelto!.cognome}" : "", dim: 5, color: Colors.black)
                ),
                Visibility(
                    visible: corsoScelto != null && corsoScelto?.codice != 0,
                    child:
                    responsiveText(text: corsoScelto != null && corsoScelto?.codice != 0 ? "Corso: ${corsoScelto!.titoloCorso}" : "", dim: 5, color: Colors.black)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void pushToCart(BuildContext context, String giorno, String ora, Corso corso,
      Docente docente) {
    corsoToCart = null;
    docenteToCart = null;
    Ripetizioni r = Ripetizioni(
        giorno: giorno,
        ora: ora,
        docente: docente,
        corso: corso,
        utente: (utente!.nomeutente)!,
        stato: true,
        effettuata: false);
    setState(() {
      bool flag = true;
      /*
      * ripetizioni.elementAt(j).corso.codice == r.corso.codice &&
            ripetizioni.elementAt(j).docente.matricola == r.docente.matricola &&*/
      for (int j = 0; j < ripetizioni.length; j++) {
        if (ripetizioni.elementAt(j).giorno == r.giorno &&
            ripetizioni.elementAt(j).ora == r.ora) {
          flag = false;
          break;
        }
      }
      if (flag) {
        ripetizioni.add(r);
      } else {
        _showToast(context, "Ripetizione già inserita nel carrello");
      }
    });
    Navigator.pop(context, 'Cancel');
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    utente = arg["utente"];
    bool ricarica = arg["ricarica"];
    altezzaSchermo = MediaQuery.of(context).size.height;
    larghezzaSchermo = MediaQuery.of(context).size.width;
    giornoCliccato.add(true);
    for(int i = 0; i < 4; i++){
      giornoCliccato.add(false);
    }
    if (ricarica == true && nuovo == true) {
      docenti.removeRange(1, docenti.length);
      corsi.removeRange(1, corsi.length);
      docentiL.removeRange(1, docentiL.length);
      corsiL.removeRange(1, corsiL.length);
      nuovo = false;
      giornoScelto = "Lunedì";
      visualizza = ripetizioniDispLun;
      if (utente!.nomeutente == "" || utente!.ruolo == 'admin') {
        _isVisibile = false;
      } else {
        _isVisibile = true;
      }
      setState(() {
        _callCaricaInsegnamenti();
        riempiTab();
      });
      (context,constraints){
        if(constraints.maxWidth < 600){
          schermo = 'mobile';
        }else{
          schermo = 'pc';
        }
      };
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff0073e6),
        title: const Text(
          'Ripetizioni Disponibili',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            nuovo = true,
            Navigator.pop(context, false),
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: _isVisibile,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.005 * altezzaSchermo, 0.005 * larghezzaSchermo, 0),
                    child: ripetizioni.isNotEmpty ?
                    Badge(
                      badgeContent: Text(ripetizioni.length.toString()),
                      position: BadgePosition.topStart(),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            carrelloPrenotazioni(context);
                          });
                        },
                        iconSize: 0.08 * larghezzaSchermo,
                        icon: const Icon(
                          color: Colors.black,
                          Icons.shopping_cart_sharp,
                        ),
                      ),
                    ) : IconButton(
                      onPressed: () {
                        setState(() {
                          carrelloPrenotazioni(context);
                        });
                      },
                      iconSize: 0.08 * larghezzaSchermo,
                      icon: const Icon(
                        color: Colors.black,
                        Icons.shopping_cart_sharp,
                      ),
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
                    setState(() {
                      docenteSceltoTmp = docentiL.firstWhere((element) =>
                      element.matricola ==
                      int.parse(value!.split(" ").first));
                    }),
                    aggiornaCorsi(),
                  },
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: docentiL
                      .map((el) => "${el.matricola} ${el.cognome}")
                      .toList(),
                  dropdownSearchDecoration: InputDecoration(
                    constraints: BoxConstraints(maxWidth: larghezzaSchermo/2.3, maxHeight: altezzaSchermo/10),
                    label: responsiveText(
                        text: "Scegli Professore",
                        dim: 4,
                        color: Colors.grey
                    ),
                  ),
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(
                    cursorColor: Color(0xff0073e6),
                  ),
                ),
                DropdownSearch<String>(
                  onChanged: (value) => {
                    corsoSceltoTmp = corsiL.firstWhere((element) =>
                        element.codice == int.parse(value!.split(" ").first)),
                    aggiornaDocenti(),
                  },
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: corsiL
                      .map((el) => "${el.codice} ${el.titoloCorso}")
                      .toList(),
                  dropdownSearchDecoration: InputDecoration(
                    constraints: BoxConstraints(maxWidth: larghezzaSchermo/2.5, maxHeight: altezzaSchermo/10),
                    label: responsiveText(
                        text: "Scegli Materia",
                        dim: 4,
                        color: Colors.grey
                    ),
                  ),
                  //selectedItem: "",
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(
                    cursorColor: Color(0xff0073e6),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: altezzaSchermo * 0.03,
            ),
            TextButton(
              onPressed: () => setState(() {
                cardBackGroundColors = <List<Color>>[[const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)],
                                                    [const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6), const Color(0xff0073e6)]];
                if ((corsoSceltoTmp != null && corsoSceltoTmp!.codice != 0) ||
                    (docenteSceltoTmp != null &&
                        docenteSceltoTmp!.matricola != 0)) {
                  _callCaricaPrenotazione();
                }
              }),
              child: Container(
                width: larghezzaSchermo / 3,
                decoration: const BoxDecoration(
                  color: Color(0xff0073e6),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ), //aggiungere navigazione alla Home
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    child: responsiveText(
                      text: 'Cerca',
                      dim: 6,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: altezzaSchermo * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        for(int i = 0; i < 5; i++){
                          giornoCliccato[i] = false;
                        }
                        giornoCliccato[0] = true;
                        visualizza = ripetizioniDispLun;
                        giornoScelto = "Lunedì";
                      });
                    },
                    child: responsiveText(
                        text: "Lun",
                        dim: 5,
                        color: const Color(0xff0073e6),
                        bold: giornoCliccato[0]
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        for(int i = 0; i < 5; i++){
                          giornoCliccato[i] = false;
                        }
                        giornoCliccato[1] = true;
                        visualizza = ripetizioniDispMar;
                        giornoScelto = "Martedì";
                      });
                    },
                    child: responsiveText(
                      text: "Mar",
                      dim: 5,
                      color: const Color(0xff0073e6),
                      bold: giornoCliccato[1]
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        for(int i = 0; i < 5; i++){
                          giornoCliccato[i] = false;
                        }
                        giornoCliccato[2] = true;
                        visualizza = ripetizioniDispMer;
                        giornoScelto = "Mercoledì";
                      });
                    },
                    child: responsiveText(
                        text: "Mer",
                        dim: 5,
                        color: const Color(0xff0073e6),
                        bold: giornoCliccato[2]
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        for(int i = 0; i < 5; i++){
                          giornoCliccato[i] = false;
                        }
                        giornoCliccato[3] = true;
                        visualizza = ripetizioniDispGio;
                        giornoScelto = "Giovedì";
                      });
                    },
                    child: responsiveText(
                        text: "Gio",
                        dim: 5,
                        color: const Color(0xff0073e6),
                        bold: giornoCliccato[3]
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        for(int i = 0; i < 5; i++){
                          giornoCliccato[i] = false;
                        }
                        giornoCliccato[4] = true;
                        visualizza = ripetizioniDispVen;
                        giornoScelto = "Venerdì";
                      });
                    },
                    child: responsiveText(
                        text: "Ven",
                        dim: 5,
                        color: const Color(0xff0073e6),
                        bold: giornoCliccato[4]
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              // color: Colors.pink,
              // height: 0.50 * altezzaSchermo, // Change as per your requirement
              // width: 0.85 * larghezzaSchermo, // Change as per your requirement
              child: ListView(
                shrinkWrap: true,
                children: visualizza
                    .map((ripetizione) => creaCard(ripetizione, context))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return SizedBox(
      height: altezzaSchermo * 0.7, // Change as per your requirement
      width: larghezzaSchermo * 0.7, // Change as per your requirement
      child: ListView(
        shrinkWrap: true,
        children: ripetizioni
            .map((ripetizione) => ripetizioneTemplate(ripetizione))
            .toList(),
      ),
    );
  }

  String indexToDay(int indice) {
    String giorno = "";
    switch (indice) {
      case 0:
        giorno = "lunedì";
        break;
      case 1:
        giorno = "martedì";
        break;
      case 2:
        giorno = "mercoledì";
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

  String indexToHour(int indice) {
    String orario = "";
    switch (indice) {
      case 0:
        orario = "15:00:00";
        break;
      case 1:
        orario = "16:00:00";
        break;
      case 2:
        orario = "17:00:00";
        break;
      case 3:
        orario = "18:00:00";
        break;
    }
    return orario;
  }

  int hourToIndex(String orario) {
    int indice = -1;
    orario = orario.toLowerCase();
    switch (orario) {
      case "15:00:00":
        indice = 0;
        break;
      case "16:00:00":
        indice = 1;
        break;
      case "17:00:00":
        indice = 2;
        break;
      case "18:00:00":
        indice = 3;
        break;
    }
    return indice;
  }

  int dayToIndex(String giorno) {
    int indice = -1;
    giorno = giorno.toLowerCase();
    switch (giorno) {
      case "lunedì":
        indice = 0;
        break;
      case "martedì":
        indice = 1;
        break;
      case "mercoledì":
        indice = 2;
        break;
      case "giovedì":
        indice = 3;
        break;
      case "venerdì":
        indice = 4;
        break;
    }
    return indice;
  }

  Widget ripetizioneTemplate(ripetizione) {
    return SizedBox(
      height: 0.2 * larghezzaSchermo,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 0.2 * larghezzaSchermo,
              width: 0.2 * larghezzaSchermo,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Color(0xff0073e6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  responsiveText(text: ripetizione.giorno, dim: 4.5, color: Colors.white),
                  responsiveText(text: "${ripetizione.ora.split(':')[0]}:${ripetizione.ora.split(':')[1]}", dim: 5, color: Colors.white),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                responsiveText(text: "${ripetizione.docente.matricola} ${ripetizione.docente.cognome}", dim: 5, color: Colors.black),
                responsiveText(text: "${ripetizione.corso.codice} ${ripetizione.corso.titoloCorso}", dim: 5, color: Colors.black),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cardBackGroundColors[dayToIndex(giornoScelto)][hourToIndex(ripetizione.ora)] = const Color(0xff0073e6);
                  ripetizioni.remove(ripetizione);
                  Navigator.pop(context, 'Cancel');
                  carrelloPrenotazioni(context);
                });
              },
              icon: Icon(
                size: larghezzaSchermo * 0.05,
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
          title: const Text('Carrello'),
          insetPadding: const EdgeInsets.all(10),
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
              onPressed: () => {
                if (ripetizioni.isNotEmpty)
                  {
                    _callInserisciPrenotazioni((utente?.session)!, ripetizioni),
                  }
                else
                  {
                    _showToast(
                        context, "Non ci sono prenotazioni nel carrello"),
                  },
                Navigator.pop(context, 'Cancel'),
              },
              child: Container(
                width: 105.0,
                decoration: BoxDecoration(
                  color: const Color(0xff0073e6),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
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
      });
  }

  void confermaPrenotazioneDocCor(BuildContext context, String giorno, String ora) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: responsiveText(text: "Riepilogo", dim: 5, color: const Color(0xff0073e6), bold: true),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            responsiveText(text: "Giorno: $giorno", dim: 4.5, color: Colors.black),
            SizedBox(
              height: altezzaSchermo * 0.02,
            ),
            responsiveText(text: "Ora: ${ora.split(":")[0]}:${ora.split(":")[1]}", dim: 4.5, color: Colors.black),
            SizedBox(
              height: altezzaSchermo * 0.02,
            ),
            responsiveText(text: "${docenteScelto!.matricola} ${docenteScelto!.cognome}", dim: 4.5, color: Colors.black),
            SizedBox(
              height: altezzaSchermo * 0.02,
            ),
            responsiveText(text: "${corsoScelto!.codice} ${corsoScelto!.titoloCorso}", dim: 4.5, color: Colors.black),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Container(
              width: larghezzaSchermo / 4.5,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.black,
                  width: larghezzaSchermo/400,
                ),
              ), //aggiungere navigazione alla Home
              child: Padding(
                padding: EdgeInsets.all(larghezzaSchermo/100),
                child: Align(
                  child: responsiveText(text: "Cancel", dim: 4.5, color: Colors.white, bold: true),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: (){
              cardBackGroundColors[dayToIndex(giorno)][hourToIndex(ora)] = Colors.lightGreen[900]!;
              pushToCart(context, giorno, ora, corsoScelto!, docenteScelto!);
            },
            child: Container(
              width: larghezzaSchermo / 4,
              decoration: BoxDecoration(
                color: const Color(0xff0073e6),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.black,
                  width: larghezzaSchermo/400,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(larghezzaSchermo/100),
                child: Align(
                  child: responsiveText(text: "Aggiungi", dim: 4.5, color: Colors.white, bold: true)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confermaPrenotazioneCor(
      BuildContext context, String giorno, String ora) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: responsiveText(text: "Riepilogo", dim: 5, color: const Color(0xff0073e6), bold: true),
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
              onChanged: (value) => {
                docenteToCart = docentiL.firstWhere((element) =>
                    element.matricola == int.parse(value!.split(" ").first)),
              },
              mode: Mode.MENU,
              showSelectedItems: true,
              items: docentiL.map((el) => "${el.matricola} ${el.cognome}").toList(),
              dropdownSearchDecoration: const InputDecoration(
                constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
                labelText: "Scegli Professore",
                contentPadding: EdgeInsets.all(8.0),
              ),
              //selectedItem: "",
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(
                cursorColor: Color(0xff0073e6),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "${corsoScelto!.codice} ${corsoScelto!.titoloCorso}",
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
            onPressed: (){
              cardBackGroundColors[dayToIndex(giorno)][hourToIndex(ora)] = Colors.lightGreen[900]!;
              pushToCart(context, giorno, ora, corsoScelto!, docenteToCart!);
            },
            child: Container(
              width: 105.0,
              decoration: BoxDecoration(
                color: const Color(0xff0073e6),
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
                    'Aggiungi',
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

  void confermaPrenotazioneDoc(
      BuildContext context, String giorno, String ora) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: responsiveText(text: "Riepilogo", dim: 5, color: const Color(0xff0073e6), bold: true),
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
              "${docenteScelto!.matricola} ${docenteScelto!.cognome}",
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            DropdownSearch<String>(
              onChanged: (value) => {
                corsoToCart = corsiL.firstWhere((element) =>
                    element.codice == int.parse(value!.split(" ").first)),
              },
              mode: Mode.MENU,
              showSelectedItems: true,
              items:
                  corsiL.map((el) => "${el.codice} ${el.titoloCorso}").toList(),
              dropdownSearchDecoration: const InputDecoration(
                constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
                labelText: "Scegli Corso",
                contentPadding: EdgeInsets.all(8.0),
              ),
              //selectedItem: "",
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(
                cursorColor: Color(0xff0073e6),
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
            onPressed: (){
              cardBackGroundColors[dayToIndex(giorno)][hourToIndex(ora)] = Colors.lightGreen[900]!;
              pushToCart(context, giorno, ora, corsoToCart!, docenteScelto!);
            },
            child: Container(
              width: 105.0,
              decoration: BoxDecoration(
                color: const Color(0xff0073e6),
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
                    'Aggiungi',
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

  void mostraConferma(BuildContext context, String giorno, String ora) {
    if (docenteScelto != null &&
        docenteScelto!.matricola != 0 &&
        (corsoScelto == null || corsoScelto!.codice == 0)) {
      confermaPrenotazioneDoc(context, giorno, ora);
    } else if (corsoScelto != null &&
        corsoScelto!.codice != 0 &&
        (docenteScelto == null || docenteScelto!.matricola == 0)) {
      confermaPrenotazioneCor(context, giorno, ora);
    } else if (corsoScelto != null &&
        corsoScelto!.codice != 0 &&
        docenteScelto != null &&
        docenteScelto!.matricola != 0) {
      confermaPrenotazioneDocCor(context, giorno, ora);
    }
  }

  responsiveText({required String text, required double dim, required Color color, bool? bold}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: bold != null && bold == true ? (dim + 0.5) * (larghezzaSchermo / 100) : dim * (larghezzaSchermo / 100),
        color: color,
        fontWeight: bold != null && bold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

void _showToast(BuildContext context, String str) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(str),
      backgroundColor: const Color(0xff0073e6),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
