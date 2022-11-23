import './corso.dart';
import './docente.dart';

class Ripetizioni {

  String giorno;
  String ora;
  Docente docente;
  Corso corso;
  bool stato;

  Ripetizioni({ required this.giorno, required this.ora, required this.docente, required this.corso, required this.stato });

}