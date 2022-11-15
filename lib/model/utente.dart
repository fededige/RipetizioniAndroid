class Utente {

  String? nomeutente;
  String? password;
  String? ruolo;

  Utente({ this.nomeutente, this.password, this.ruolo });

  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(
      nomeutente: json['nome_utente'],
      password: json['password'],
      ruolo: json['ruolo']
    );
  }

}