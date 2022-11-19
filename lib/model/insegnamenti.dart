import './corso.dart';
import './docente.dart';

class Insegnamenti {

  Corso corso;
  Docente docente;


  Insegnamenti({ required this.corso, required this.docente, });

  factory Insegnamenti.fromJson(Map<String, dynamic> json) {
    return Insegnamenti(
      corso: Corso.fromJson(json['corso']),
      docente: Docente.fromJson(json['docente']),
    );
  }
}