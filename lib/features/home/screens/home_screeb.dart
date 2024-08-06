import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/membership_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> list = [
    {
      'name': "John Smith",
      'email': 'johnsmitih@example.com',
      "phone": "234-45-67",
      "status": "inactive",
    },
    {
      'name': "John Doe",
      'email': 'johnsdoe@example.com',
      "phone": "345-42-78",
      "status": "active",
    }
  ];
  bool _isEditMode = false;

  int _currentSortIndex = 0;
  bool _isSortAsc = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: theme.copyWith(
                      iconTheme: theme.iconTheme.copyWith(color: Colors.white)),
                  child: DataTable(
                    // dataRowColor: WidgetStateProperty.resolveWith((state) =>
                    //     const Color.fromARGB(255, 235, 209, 218).withOpacity(0.1)),
                    headingRowColor: WidgetStateProperty.resolveWith(
                        (state) => priCol(context)), 
                    showCheckboxColumn: true,
                    sortColumnIndex: _currentSortIndex,
                    sortAscending: _isSortAsc,
                    columns: <DataColumn>[
                      DataColumn(
                          onSort: (columnIndex, value) {
                            setState(() {
                              _currentSortIndex = columnIndex;
                              if (_isSortAsc) {
                                list.sort(
                                    (a, b) => b['email'].compareTo(a['email']));
                              } else {
                                list.sort(
                                    (a, b) => a['email'].compareTo(b['email']));
                              }
                              _isSortAsc = !_isSortAsc;
                            });
                          },
                          label: Text(
                            'Name',
                            style: TextStyle(color: Colors.white),
                          )),
                      DataColumn(
                          onSort: (columnIndex, value) {
                            setState(() {
                              _currentSortIndex = columnIndex;
                              if (_isSortAsc) {
                                list.sort(
                                    (a, b) => b['email'].compareTo(a['email']));
                              } else {
                                list.sort(
                                    (a, b) => a['email'].compareTo(b['email']));
                              }
                              _isSortAsc = !_isSortAsc;
                            });
                          },
                          label: Text(
                            'Email',
                            style: TextStyle(color: Colors.white),
                          )),
                      DataColumn(
                          label: Text(
                        'Phone',
                        style: TextStyle(color: Colors.white),
                      )),
                      DataColumn(
                          label: Text(
                        'Status',
                        style: TextStyle(color: Colors.white),
                      )),
                    ],
                    rows: <DataRow>[
                      for (var items in list)
                        DataRow(
                          cells: [
                            _createTitleCell(items['name']),
                            DataCell(Text(items['email'])),
                            DataCell(Text(items['phone'])),
                            DataCell(Text(items['status'])),
                          ],
                        )
                    ],
                  ),
                ),
                _createCheckboxField()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:_isEditMode  == true ? Theme(
        data: theme.copyWith(
          floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
            backgroundColor: priCol(context),
            foregroundColor: Colors.white,
            shape: CircleBorder()
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.save),
        ),
      ): null,
    );
  }

  DataCell _createTitleCell(name) {
    return DataCell(_isEditMode == true
        ? TextFormField(
            initialValue: name,
            style: TextStyle(fontSize: 14),
          )
        : Text(name));
  }

  Row _createCheckboxField() {
    return Row(
      children: [
        Checkbox(
          value: _isEditMode,
          onChanged: (value) {
            setState(() {
              _isEditMode = value!;
            });
          },
        ),
        Text('Edit mode'),
      ],
    );
  }
}
