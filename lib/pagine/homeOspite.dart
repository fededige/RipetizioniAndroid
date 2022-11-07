import 'package:flutter/material.dart';

class PaginaHomeOspite extends StatefulWidget {
  @override
  State<PaginaHomeOspite> createState() => _PaginaHomeOspiteState();
}

class _PaginaHomeOspiteState extends State<PaginaHomeOspite> {
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
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0),
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                "Ciao Ospite",
              ),
            ),
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
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: const <Widget>[
                  IconButton(
                    iconSize: 100.0,
                    icon: Icon(
                      color: Colors.black,
                      Icons.calendar_month,
                    ),
                    onPressed: null,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
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
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
