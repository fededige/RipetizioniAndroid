import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class PaginaRipetizioni extends StatefulWidget {
  @override
  State<PaginaRipetizioni> createState() => _PaginaRipetizioniState();
}

List<String> list = <String>["ciaociao", "nonono", "wasdwasdwas", "sdibvsidv"];
String dropdownValue = "ciaociao";

class _PaginaRipetizioniState extends State<PaginaRipetizioni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Ripetizioni Disponibili',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: list,
                    dropdownSearchDecoration: const InputDecoration(
                      constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
                      labelText: "Scegli Professore",
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    //selectedItem: "",
                    showSearchBox: true,
                    searchFieldProps: const TextFieldProps(
                      cursorColor: Colors.blue,
                    ),
                  ),
                  DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: list,
                    dropdownSearchDecoration: const InputDecoration(
                      constraints: BoxConstraints(maxWidth: 170, maxHeight: 50),
                      labelText: "Scegli Materia",
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    //selectedItem: "",
                    showSearchBox: true,
                    searchFieldProps: const TextFieldProps(
                      cursorColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextButton(
                onPressed: null,
                child: Container(
                  width: 100.0,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ), //aggiungere navigazione alla Home
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Align(
                      child: Text(
                        'Cerca',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Column(
                children: <Widget>[
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Text('L'),
                          Text('M'),
                          Text('M'),
                          Text('G'),
                          Text('V'),
                        ]),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Table(
                        /*border: const TableBorder(
                          horizontalInside: BorderSide(
                            color : Colors.black,
                          ),
                          verticalInside: BorderSide(
                            color : Colors.black,
                          ),
                          right: BorderSide(
                            color : Colors.black,
                          ),
                          /*bottom: BorderSide(
                            color : Colors.black,
                          )*/
                        ),*/
                        columnWidths: const <int, TableColumnWidth>{
                          0: IntrinsicColumnWidth(),
                          1: IntrinsicColumnWidth(),
                          2: IntrinsicColumnWidth(),
                          3: IntrinsicColumnWidth(),
                          4: IntrinsicColumnWidth(),
                          5: IntrinsicColumnWidth(),
                        },
                        children: [
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Text(
                                  ' ',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Text(
                                  'L',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Text(
                                  'M',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Text(
                                  'M',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Text(
                                  'G',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Text(
                                  'V',
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                child: Align(
                                  child: Text(
                                    '15',
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Lunedì", "15:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                  )),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Martedì", "15:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                  )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Mercoledì", "15:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Giovedì", "15:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Venerdì", "15:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      '16',
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Lunedì", "16:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                  )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Martedì", "16:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                  )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Mercoledì", "16:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Giovedì", "16:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Venerdì", "16:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      '17',
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Lunedì", "17:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                  )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Martedì", "17:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Mercoledì", "17:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                  )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Giovedì", "17:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Venerdì", "17:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Container(
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      '18',
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Lunedì", "18:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(color: Colors.black),
                                          bottom: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black))),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Martedì", "18:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                  )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Mercoledì", "18:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Giovedì", "18:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    return confermaPrenotazione(context, "Venerdì", "18:00");
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                    child: Align(
                                      child: Text(
                                        'Disp',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void confermaPrenotazione(BuildContext context, String giorno, String ora) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: const Text('Riepilogo'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Giorno: $giorno',
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Ora: $ora',
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: list,
            dropdownSearchDecoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
              labelText: "Scegli Professore",
              contentPadding: EdgeInsets.all(8.0),
            ),
            //selectedItem: "",
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              cursorColor: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: list,
            dropdownSearchDecoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 190, maxHeight: 50),
              labelText: "Scegli Corso",
              contentPadding: EdgeInsets.all(8.0),
            ),
            //selectedItem: "",
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(
              cursorColor: Colors.blue,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Container(
            width: 100.0,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Colors.black,
                width: 3.0,
              ),
            ), //aggiungere navigazione alla Home
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Container(
            width: 105.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Colors.black,
                width: 3.0,
              ),
            ), //aggiungere navigazione alla Home
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                child: Text(
                  'Conferma',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
