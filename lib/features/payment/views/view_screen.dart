import 'dart:convert';

import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    List<TransactionModel> selectedTransactions = [];
    bool isSelectionMode = false;

    void _deleteSelectedTransactions(
        List<TransactionModel> transactionsToDelete) async {
      final prefs = await sharedPrefs;
      String? transactionData = prefs.getString('transactions');

      if (transactionData != null) {
        List<dynamic> transactionList = jsonDecode(transactionData);
        transactionList.removeWhere((transaction) =>
            transactionsToDelete.any((t) => t.id == transaction['id']));

        await prefs.setString('transactions', jsonEncode(transactionList));

        setState(() {
          selectedTransactions.clear();
          isSelectionMode = false;
        });
      }
    }

    void _deleteTransaction(TransactionModel transaction) async {
      final prefs = await sharedPrefs;
      String? transactionData = prefs.getString('transactions');

      if (transactionData != null) {
        List<dynamic> transactionList = jsonDecode(transactionData);
        transactionList.removeWhere((t) => t['id'] == transaction.id);

        await prefs.setString('transactions', jsonEncode(transactionList));
        setState(() {});
      }
    }

   void _toggleSelection( TransactionModel transaction) {
    if(selectedTransactions.contains(transaction)){
      selectedTransactions.remove(transaction);
    }else{
      selectedTransactions.add(transaction);
    }

    setState(() {
       isSelectionMode = selectedTransactions.isNotEmpty;
    });
   }

   void _cancelSelection (){
    setState(() {
      isSelectionMode = false;
      selectedTransactions.clear();
    });
   }

    return Container();
  }
}
