import 'package:flutter/material.dart';
import '../model/docente.dart';
import '../model/corso.dart';
import '../model/ripetizioni.dart';
import '../pagine/login.dart';
import '../pagine/homeUtente.dart';

class PaginaRipetizioniPren extends StatefulWidget {

  @override
  State<PaginaRipetizioniPren> createState() => _PaginaRipetizioniPrenState();
}


List<Ripetizioni> ripetizioni = [
  Ripetizioni(giorno: "Lunedì", ora: "15:00", docente: Docente(matricola: 123, nome: 'mario', cognome: 'dth'), corso: Corso(codice: 123, titoloCorso: 'informatica'), stato: true),
  Ripetizioni(giorno: "Martedì", ora: "18:00", docente: Docente(matricola: 456, nome: 'divb', cognome: 'af'), corso: Corso(codice: 456, titoloCorso: 'matematica'), stato: true),
  Ripetizioni(giorno: "Giovedì", ora: "16:00", docente: Docente(matricola: 789, nome: 'ad', cognome: 'th'), corso: Corso(codice: 789, titoloCorso: 'inglese'), stato: true),
  Ripetizioni(giorno: "Lunedì", ora: "17:00", docente: Docente(matricola: 135, nome: 'av', cognome: 'ayn'), corso: Corso(codice: 135, titoloCorso: 'geometria'), stato: true),
];

List<Ripetizioni> ripetizioniEff = <Ripetizioni>[
  Ripetizioni(giorno: "Giovedì", ora: "16:00", docente: Docente(matricola: 789, nome: 'ad', cognome: 'th'), corso: Corso(codice: 789, titoloCorso: 'inglese'), stato: true),
];
List<Ripetizioni> ripetizioniCanc = <Ripetizioni>[];
List<Ripetizioni> visualizza = ripetizioni;
class _PaginaRipetizioniPrenState extends State<PaginaRipetizioniPren> {

  @override
  Widget build(BuildContext context) {
    void initState(){
      visualizza=ripetizioni;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ripetizioni Prenotate'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(//_widgetOptions[_selectedIndex],
      children: <Widget>[
          Column(
          children: visualizza.map((ripetizione) => ripetizioneTemplate(ripetizione)).toList(),
          ),
          ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse_sharp),
            label: 'Da fare',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline),
            label: 'Effettuate',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close),
            label: 'Cancellate',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close),
            label: 'Cancellate',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final _widgetOptions = [
    PaginaRipetizioniPren()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index==0){
        visualizza=ripetizioni;
      }
      if(index==1){
        visualizza=ripetizioniEff;
      }
      if(index==2){
        visualizza=ripetizioniCanc;
      }
    });
  }

  Widget ripetizioneTemplate(ripetizione) {
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
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        ripetizione.ora,
                        style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      ripetizione.corso.titoloCorso,
                      style: const TextStyle(fontSize: 20),
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
                    ripetizioniCanc.add(ripetizione);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    ripetizioni.remove(ripetizione);
                    ripetizioniEff.add(ripetizione);
                  });
                },
                icon: const Icon(
                  Icons.done_outline_sharp,
                  color: Colors.grey,
                ),
              ),
            ],
          )),
      
    );
  }

}