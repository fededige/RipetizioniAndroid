class Docente {

  String cognome;
  int matricola;
  String nome;


  Docente({ required this.cognome, required this.matricola, required this.nome });

  factory Docente.fromJson(Map<String, dynamic> json) {
    return Docente(
      cognome: json['cognome'],
      matricola: json['matricola'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "cognome": cognome,
      "matricola": matricola,
      "nome": nome,
    };
  }

}