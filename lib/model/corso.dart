class Corso {

  int codice;
  String titoloCorso;


  Corso({ required this.codice, required this.titoloCorso });

  factory Corso.fromJson(Map<String, dynamic> json) {
    return Corso(
      codice: json['codice'],
      titoloCorso: json['titolo_corso'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "codice": codice,
      "titoloCorso": titoloCorso,
    };
  }

}