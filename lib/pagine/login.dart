import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              'Ripetizioni',
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'EncodeSans'
              )
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 260.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_box,
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
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                  child: TextField(
                    obscureText: visible,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey[600],
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
                      )
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
                  child: const TextButton(
                    onPressed: null, //aggiungere navigazione alla Home
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                TextButton(
                  onPressed: null,
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: null,
                  child: Text(
                    'Join as Guest',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
