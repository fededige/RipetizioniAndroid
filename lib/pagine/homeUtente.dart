import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';

class PaginaHomeUtente extends StatefulWidget {
  @override
  State<PaginaHomeUtente> createState() => _PaginaHomeUtenteState();
}
bool _isAdmin=true;
bool _isClient=false;
class _PaginaHomeUtenteState extends State<PaginaHomeUtente> {
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
          backgroundColor: Colors.blue,
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
                  iconSize: 50.0,
                  icon: const Icon(
                    color: Colors.black,
                    Icons.settings,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0),
                  child: Text(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    'Ciao $presentazione' //variabile
                  ),
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
                          children: const <Widget>[
                            Icon(
                              color: Colors.black,
                              Icons.calendar_month,
                              size: 50.0,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                'Calendario \n Prenotazioni',
                                textAlign: TextAlign.center,
                              ),
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
                          children: const <Widget>[
                            Icon(
                              color: Colors.black,
                              Icons.menu_book,
                              size: 50.0,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                'Ripetizioni \n Prenotate',
                                textAlign: TextAlign.center,
                              ),
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
