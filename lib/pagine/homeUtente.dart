import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';

class PaginaHomeUtente extends StatefulWidget {
  @override
  State<PaginaHomeUtente> createState() => _PaginaHomeUtenteState();
}
bool _isAdmin=true;
bool _isClient=false;
class _PaginaHomeUtenteState extends State<PaginaHomeUtente> {
  Text responsiveText({required String text, required double dim, required Color color, bool? bold}) { //spostare giù
    return Text(
      text,
      style: TextStyle(
        fontSize: (dim) * ((MediaQuery.of(context).size.height * MediaQuery.of(context).size.width) / 10000),
        color: color,
        fontWeight: bold != null && bold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
  String? presentazione = '';
  @override
  Widget build(BuildContext context) {
    Utente utente = ModalRoute.of(context)!.settings.arguments as Utente;
    if(utente.ruolo== 'cliente'){
      _isAdmin=false;
      _isClient=true;
    }
    presentazione = utente.nomeutente;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff0073e6),
          title: const Text(
            'Ripetizioni',
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/impostazioni', arguments: utente);
                  },
                  iconSize: (1.5) * ((MediaQuery.of(context).size.height * MediaQuery.of(context).size.width) / 10000),
                  icon: const Icon(
                    color: Colors.black,
                    Icons.settings,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0),
                  child: responsiveText(text: "Ciao $presentazione", dim: 1, color: Colors.black, bold: true),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ripetizioniDisp', arguments: {"utente":utente, "ricarica":true});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              color: Colors.black,
                              Icons.calendar_month,
                              size: (1.5) * ((MediaQuery.of(context).size.height * MediaQuery.of(context).size.width) / 10000),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: responsiveText(text: "Calendario \n Prenotazioni", dim: 0.8, color: Colors.black, bold: true),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/ripetizioniPren",arguments: {"utente":utente, "ricarica":true});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              color: Colors.black,
                              Icons.menu_book,
                              size: (1.5) * ((MediaQuery.of(context).size.height * MediaQuery.of(context).size.width) / 10000),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: responsiveText(text: "Ripetizioni \n Prenotate", dim: 0.8, color: Colors.black, bold: true),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        )
    );
  }
}
