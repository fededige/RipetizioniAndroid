import 'package:flutter/material.dart';

class PaginaHomeUtente extends StatefulWidget {
  @override
  State<PaginaHomeUtente> createState() => _PaginaHomeUtenteState();
}

class _PaginaHomeUtenteState extends State<PaginaHomeUtente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            'Ripetizioni',
          ),
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
                    Navigator.pushNamed(context, '/impostazioni');
                  },
                  iconSize: 50.0,
                  icon: const Icon(
                    color: Colors.black,
                    Icons.settings,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0),
                  child: Text(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    "Ciao Utente", //variabile
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/ripetizioniDisp");
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                  onPressed: null,
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
