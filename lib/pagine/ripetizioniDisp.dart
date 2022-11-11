import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class PaginaRipetizioni extends StatefulWidget {
  @override
  State<PaginaRipetizioni> createState() => _PaginaRipetizioniState();
}

List<String> list = <String> ["ciaociao", "nonono", "wasdwasdwas", "sdibvsidv"];
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Text(
                            'L'
                          ),
                          Text(
                              'M'
                          ),
                          Text(
                              'M'
                          ),
                          Text(
                              'G'
                          ),
                          Text(
                              'V'
                          ),
                        ]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Text(
                              '15'
                          ),
                          SizedBox(
                            height: 90.0,
                          ),
                          Text(
                              '16'
                          ),
                          SizedBox(
                            height: 90.0,
                          ),
                          Text(
                              '17'
                          ),
                          SizedBox(
                            height: 90.0,
                          ),
                          Text(
                              '18'
                          ),
                        ],
                      ),
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: IntrinsicColumnWidth(),
                          1: IntrinsicColumnWidth(),
                          2: IntrinsicColumnWidth(),
                          3: IntrinsicColumnWidth(),
                          4: IntrinsicColumnWidth(),
                        },
                        children: const [
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                            ],
                          ),TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 30.0),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Disp',
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
