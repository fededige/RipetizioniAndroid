import 'package:flutter/material.dart';
import 'package:ripetizioni/model/utente.dart';
class PaginaHomeOspite extends StatefulWidget {
  @override
  State<PaginaHomeOspite> createState() => _PaginaHomeOspiteState();
}
Utente usr = Utente(stato:false);
class _PaginaHomeOspiteState extends State<PaginaHomeOspite> {
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
    usr.nomeutente="";
    usr.password="";
    usr.stato=false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff0073e6),
        title: const Text(
          'Ripetizioni',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0),
              child: responsiveText(text: "Ciao Ospite", dim: 1, color: Colors.black, bold: true),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/ripetizioniDisp",   arguments: {"utente":usr, "ricarica":true});
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
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      size: (4) * ((MediaQuery.of(context).size.height * MediaQuery.of(context).size.width) / 10000),
                      color: Colors.black,
                      Icons.calendar_month,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                      child: responsiveText(text: "Calendario \n Prenotazioni", dim: 1, color: Colors.black, bold: true),
                    ),
                  ],
                ),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: responsiveText(text: "Log in", dim: 1, color: Colors.black, bold: false),
            ),
          ),
        ],
      )
    );
  }
}
