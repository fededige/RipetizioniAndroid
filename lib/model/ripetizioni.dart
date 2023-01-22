import './corso.dart';
import './docente.dart';

class Ripetizioni {
  int? codice;
  String utente;
  String giorno;
  String ora;
  Docente docente;
  Corso corso;
  bool stato;
  bool effettuata;

  Ripetizioni({ this.codice, required this.giorno, required this.ora, required this.docente, required this.corso, required this.stato,required this.effettuata,required this.utente });

  factory Ripetizioni.fromJson(Map<String, dynamic> json) {
    return Ripetizioni(
      codice: json['codice'],
      utente : json['utente'],
      giorno: json['giorno'],
      ora: json['ora'],
      docente: Docente.fromJson(json['docente']),
      corso: Corso.fromJson(json['corso']),
      stato: json['stato'],
      effettuata: json['effettuata'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "codice": codice,
      "giorno": giorno,
      "ora": ora,
      "docente": docente,
      "corso": corso,
      "utente": utente,
      "stato":stato,
      "effettuata":effettuata
    };
  }
}