import 'package:church_clique/features/form/models/membership_model.dart';
import 'package:flutter/material.dart';

List<DataCell> cells(MembershipModel memberData, bool editMode) {
  return [
    
  ];
}



createTitleCell(String name, bool isEditMode, {required void Function(String?) onSaved} ) {
  return DataCell(
    isEditMode
        ? TextFormField(
            initialValue: name,
            onSaved: onSaved ,
            style: const TextStyle(fontSize: 14),
          )
        : Text(name),
  );
}
 
 

  
