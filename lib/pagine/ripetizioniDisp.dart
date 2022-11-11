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
                      constraints: BoxConstraints(maxWidth: 180, maxHeight: 50),
                      labelText: "Scegli Professore",
                      hintText: "Prof. disponibili",
                    ),
                    popupItemDisabled: isItemDisabled,
                    onChanged: itemSelectionChanged,
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
                      hintText: "Materie disponibili",
                    ),
                    popupItemDisabled: isItemDisabled,
                    onChanged: itemSelectionChanged,
                    //selectedItem: "",
                    showSearchBox: true,
                    searchFieldProps: const TextFieldProps(
                      cursorColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
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
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: Colors.black
                                      ),
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      top: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      top: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      top: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      top: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      top: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
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
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      left: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
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
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                      left: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
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
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.black
                                        ),
                                        bottom: BorderSide(
                                            color: Colors.black
                                        ),
                                        left: BorderSide(
                                            color: Colors.black
                                        )
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black
                                      ),
                                      bottom: BorderSide(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
                                  child: Align(
                                    child: Text(
                                      'Disp',
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

bool isItemDisabled(String s) {
  //return s.startsWith('I');

  if (s.startsWith('I')) {
    return true;
  } else {
    return false;
  }
}

void itemSelectionChanged(String? s) {
  print(s);
}
