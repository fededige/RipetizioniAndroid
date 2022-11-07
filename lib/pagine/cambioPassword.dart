import 'package:flutter/material.dart';

class PaginaCambioPassword extends StatefulWidget {
  @override
  State<PaginaCambioPassword> createState() => _PaginaCambioPasswordState();
}

class _PaginaCambioPasswordState extends State<PaginaCambioPassword> {
  bool visible = true;
  bool visible2 = true;
  bool visible3 = true;
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
                  obscureText: visible,
                  decoration: InputDecoration(
                    labelText: 'Vecchia password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                      ),
                      color: Colors.grey[600],
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
                  obscureText: visible2,
                  decoration: InputDecoration(
                    labelText: 'Nuova password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible2 = !visible2;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                      ),
                      color: Colors.grey[600],
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
                  obscureText: visible3,
                  decoration: InputDecoration(
                    labelText: 'Conferma nuova password',
                    labelStyle: const TextStyle(
                      fontSize: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible3 = !visible3;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                      ),
                      color: Colors.grey[600],
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
