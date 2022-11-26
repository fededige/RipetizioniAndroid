import './corso.dart';
import './docente.dart';

class Ripetizioni {

  String giorno;
  String ora;
  Docente docente;
  String utente;
  Corso corso;
  bool stato;


  Ripetizioni({ required this.giorno, required this.ora, required this.docente, required this.corso, required this.utente, required this.stato});

  Map<String, dynamic> toJson(){
    return {
      "giorno": giorno,
      "ora": ora,
      "docente": docente,
      "corso": corso,
      "utente": utente,
      "stato": stato,
    };
  }

}