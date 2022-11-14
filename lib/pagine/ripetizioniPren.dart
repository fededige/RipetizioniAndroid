import 'package:flutter/material.dart';
import 'ripetizioni.dart';

class PaginaRipetizioniPren extends StatefulWidget {

  @override
  State<PaginaRipetizioniPren> createState() => _PaginaRipetizioniPrenState();
}

class _PaginaRipetizioniPrenState extends State<PaginaRipetizioniPren> {
  List<Ripetizioni> ripetizioni = [
    Ripetizioni(giorno: "Lunedì", ora: "15:00", docente: "mario", corso: "informatica"),
    Ripetizioni(giorno: "Martedì", ora: "18:00", docente: "luigi", corso: "informatica"),
    Ripetizioni(giorno: "Giovedì", ora: "16:00", docente: "ciccio", corso: "informatica"),
    Ripetizioni(giorno: "Lunedì", ora: "17:00", docente: "mario", corso: "informatica"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ripetizioni Prenotate'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: ripetizioni.map((ripetizione) => ripetizioneTemplate(ripetizione)).toList(),
          ),
        ],
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
                      ripetizione.docente,
                      style: const TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Text(
                      ripetizione.corso,
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
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
            ],
          )
      ),
    );
  }
}

