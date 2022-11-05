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
              children: const <Widget>[
                IconButton(
                  onPressed: null,
                  iconSize: 50.0,
                  icon: Icon(
                    color: Colors.black,
                    Icons.settings,
                  ),
                ),
                Padding(
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
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 3.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: const <Widget>[
                          IconButton(
                            iconSize: 50.0,
                            icon: Icon(
                              color: Colors.black,
                              Icons.calendar_month,
                            ),
                            onPressed: null,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Text(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              'Calendario \n Prenotazioni',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 3.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                      child: Column(
                        children: const <Widget>[
                          IconButton(
                            iconSize: 50.0,
                            icon: Icon(
                              color: Colors.black,
                              Icons.menu_book,
                            ),
                            onPressed: null,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Text(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              'Ripetizioni \n Prenotate',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
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
