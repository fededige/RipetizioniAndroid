import 'package:flutter/material.dart';

class PaginaCambioNomeU extends StatefulWidget {
  @override
  State<PaginaCambioNomeU> createState() => _PaginaCambioNomeUState();
}

class _PaginaCambioNomeUState extends State<PaginaCambioNomeU> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 260.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Vecchio nome utente',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                width: 260.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nuovo nome utente',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Container(
                width: 136.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/homeUtente');
                  },
                  child: const Text(
                    'Conferma',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
