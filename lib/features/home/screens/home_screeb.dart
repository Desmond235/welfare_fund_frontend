import 'package:church_clique/core/components/data_column.dart';
import 'package:church_clique/core/components/data_row.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/controls/data_column.dart';
import 'package:church_clique/features/form/models/membership_model.dart';
import 'package:church_clique/features/form/service/form_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEditMode = false;

  int _currentSortIndex = 0;
  bool _isSortAsc = true;

  late Future<List<MembershipModel>> loadMembership;
  MembershipModel? members;

  final _formKey = GlobalKey<FormState>();

void updateMembers(){
  _formKey.currentState!.save();
}

  @override
  void initState() {
    super.initState();
    loadMembership = loadMembers();
  }

  Future<List<MembershipModel>> loadMembers() async {
    final membership = await FormServiceResponse.getMembershipDetails(1);
    if (membership.isNotEmpty) {
      members = membership.first;

      return await FormServiceResponse.getMembershipDetails(members!.id);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          // Ensures the DataTable is centered
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<MembershipModel>>(
              future: loadMembership,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                }

                final members = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme(
                      data: theme.copyWith(
                        iconTheme:
                            theme.iconTheme.copyWith(color: Colors.white),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Form(
                              key: _formKey,
                              child: DataTable(
                                showBottomBorder: true,
                                headingRowColor: WidgetStateProperty.resolveWith(
                                    (states) => priCol(context)),
                                showCheckboxColumn: true,
                                sortColumnIndex: _currentSortIndex,
                                sortAscending: _isSortAsc,
                                columns: getDataColumns(members),
                                rows: [
                                  for (var item in members)
                                    DataRow(
                                      cells: [
                                        createTitleCell(item.full_name.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.date_of_birth.toString(),
                                            _isEditMode , onSaved: (value){}),
                                        createTitleCell(
                                            item.date_of_registration.toString(),
                                            _isEditMode, onSaved:(value){}),
                                        createTitleCell(
                                            item.contact.toString(), _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.house_number.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.place_of_abode.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(item.land_mark.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(item.home_town.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.region.toString(), _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.marital_status.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.name_of_spouse.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.life_status.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        // _createTitleCell(item.no_of_children.toString(),_isEditMode),
                                        // _createTitleCell(item.names_of_children.toString(),_isEditMode),
                                        createTitleCell(
                                            item.occupation.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.fathers_name.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.father_life_status.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.mothers_name.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.mother_life_status.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.next_of_kin.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.next_of_kin_contact.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.class_leader.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.class_leader_contact.toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.organization_of_member
                                                .toString(),
                                            _isEditMode, onSaved: (value){}),
                                        createTitleCell(
                                            item.org_leader_contact.toString(),
                                            _isEditMode,onSaved: (value){})
                                      ],
                                    ),
                                ],
                                // rows: <DataRow>[
                                //   for (var items in list)
                                //     DataRow(
                                //       cells: [
                                //         _createTitleCell(items['name']),
                                //         DataCell(Text(items['email'])),
                                //         DataCell(Text(items['phone'])),
                                //         DataCell(Text(items['status'])),
                                //       ],
                                //     ),
                                // ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: _switchField(),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: priCol(context),
                          ),
                          onPressed: () {
                            setState(() {
                              loadMembership = loadMembers();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              'Refresh',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: priCol(context),
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  List<DataColumn> getDataColumns(List<MembershipModel> members) {
    return [
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.id.compareTo(a.id));
            } else {
              members.sort((a, b) => a.id.compareTo(b.id));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: Text(
          'Full Name',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        onSort: (columnIndex, value) {
          setState(() {
            _currentSortIndex = columnIndex;
            if (_isSortAsc) {
              members.sort((a, b) => b.full_name.compareTo(a.full_name));
            } else {
              members.sort((a, b) => a.full_name.compareTo(b.full_name));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
        label: Text(
          'Date of Birth',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ...getColumns()
    ];
  }

  Row _switchField() {
    return Row(
      children: [
        Text('Edit mode'),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Switch(
            value: _isEditMode,
            onChanged: (value) {
              setState(() {
                _isEditMode = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
