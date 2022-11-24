import './corso.dart';
import './docente.dart';

class Ripetizioni {

  String giorno;
  String ora;
  Docente docente;
  Corso corso;
  bool stato;
  bool effettuata;

  Ripetizioni({ required this.giorno, required this.ora, required this.docente, required this.corso, required this.stato,required this.effettuata });

  factory Ripetizioni.fromJson(Map<String, dynamic> json) {
    return Ripetizioni(
      giorno: json['giorno'],
      ora: json['ora'],
      docente: Docente.fromJson(json['docente']),
      corso: Corso.fromJson(json['corso']),
      stato: json['stato'],
      effettuata: json['effettuata'],
    );
  }
}