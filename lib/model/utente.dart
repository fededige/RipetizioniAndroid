class Utente {

  String? nomeutente;
  String? password;
  String? ruolo;
  bool stato;
  String? session;

  Utente({ this.nomeutente, this.password, this.ruolo , required this.stato, this.session});

  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(
      nomeutente: json['nome_utente'],
      password: json['password'],
      ruolo: json['ruolo'],
      stato: json['stato'],
      session: json['session'],
    );
  }
}