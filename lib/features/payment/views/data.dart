import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/get_transactions.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding and decoding JSON

class ViewTransactionScreen extends StatefulWidget {
  const ViewTransactionScreen({super.key});

  @override
  State<ViewTransactionScreen> createState() => _ViewTransactionScreenState();
}

class _ViewTransactionScreenState extends State<ViewTransactionScreen> {
  // Fetch transactions from the API and save them in Shared Preferences
  Future<void> _fetchAndSaveTransactions() async {
    final userId = context.watch<MemFormState>().userId;
    try {
      final transactions = await GetTransactionResponse.getTransactions(userId: userId);
      final prefs = await SharedPreferences.getInstance();
      final transactionList = transactions.map((transaction) => transaction.toJson()).toList();
      await prefs.setString('transactions', jsonEncode(transactionList));
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  // Load transactions from Shared Preferences
  Future<List<TransactionModel>> _loadTransactionsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionData = prefs.getString('transactions');
    if (transactionData != null) {
      final List<dynamic> jsonData = jsonDecode(transactionData);
      return jsonData.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  // Delete a transaction by its index and save the updated list back into Shared Preferences
  Future<void> _deleteTransaction(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionData = prefs.getString('transactions');
    if (transactionData != null) {
      List<dynamic> transactionList = jsonDecode(transactionData);

      // Remove the transaction at the given index
      transactionList.removeAt(index);

      // Save the updated transaction list back into Shared Preferences
      await prefs.setString('transactions', jsonEncode(transactionList));

      // Update the UI
      setState(() {});
    }
  }

  // Format the date
  String formatDate(String dbDate) {
    String correctedDate = dbDate.replaceFirst('-', 'T', dbDate.lastIndexOf('-'));
    DateTime paymentDate = DateTime.parse(correctedDate);
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    bool isYesterday = now.year == yesterday.year &&
        now.month == yesterday.month &&
        now.day == yesterday.day;

    bool isToday = now.year == paymentDate.year &&
        now.month == paymentDate.month &&
        now.day == paymentDate.day;

    if (isToday) {
      return 'Today • ${DateFormat.jm().format(paymentDate)}';
    } else if (isYesterday) {
      return 'Yesterday • ${DateFormat.jm().format(paymentDate)}';
    } else if (paymentDate.year == now.year) {
      return DateFormat('EEE, MMM d • h:mm a ').format(paymentDate);
    } else {
      return DateFormat('EEE, MMM d, yyyy • h:mm a').format(paymentDate);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAndSaveTransactions(); // Fetch and store transactions in Shared Preferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<TransactionModel>>(
            future: _loadTransactionsFromPrefs(), // Load transactions from Shared Preferences
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'An error occurred while fetching transactions',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no-data.png',
                      scale: 4,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No transactions found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final transaction = snapshot.data![index];
                  final date = transaction.date;
                  return Column(
                    children: [
                      Text(
                        formatDate(date),
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.asset('assets/logo.png'),
                        ),
                        subtitle: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: priCol(context),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Payment of GH₵ ${transaction.amount} for Welfare dues made to admin',
                              softWrap: true,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTransaction(index), // Delete transaction on click
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
