import 'package:church_clique/core/components/menu_item.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/get_transactions.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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
  List<TransactionModel> selectedTransactions = [];
  final AdvancedDrawerController _drawerController = AdvancedDrawerController();
  bool isSelectionMode = false;
  @override
  void initState() {
    super.initState();
    _fetchAndSaveTransactionsIfNeeded(); // Check if data needs to be fetched from the API
  }

  // Fetch transactions from API only if not present in Shared Preferences
  Future<void> _fetchAndSaveTransactionsIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedTransactions = prefs.getString('transactions');
    if (savedTransactions == null || savedTransactions.isEmpty) {
      // Fetch data from API only if Shared Preferences is empty
      if(!mounted) return;
      final userId = context.read<MemFormState>().userId;
      final transactions =
          await GetTransactionResponse.getTransactions(userId: userId);
      final transactionList =
          transactions.map((transaction) => transaction.toJson()).toList();
      await prefs.setString('transactions', jsonEncode(transactionList));
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

  // delete selectedTransaction
  Future<void> _deleteSelectedTransactions(
      List<TransactionModel> transactionsToDelete) async {
    final prefs = await sharedPrefs;
    final String? transactionData = prefs.getString('transactions');

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

  // Delete a transaction by its index and update Shared Preferences
  Future<void> _deleteTransaction(TransactionModel transaction) async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionData = prefs.getString('transactions');

    if (transactionData != null) {
      List<dynamic> transactionList = jsonDecode(transactionData);

      // Remove the transaction at the given index
      transactionList.removeWhere((t) => t['id'] == transaction.id);

      // Save the updated transaction list back into Shared Preferences
      await prefs.setString('transactions', jsonEncode(transactionList));

      // Update the UI
      setState(() {});
    }
  }

  // show dialog
  Future<void> _showDeleteDialog({TransactionModel? singleTransaction}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(singleTransaction != null
            ? 'Delete Transaction'
            : 'Delete Transactions'),
        content: Text(
          singleTransaction != null
              ? 'Are you sure you want to delete this transaction permanently?'
              : 'Are you sure you want to delete ${selectedTransactions.length} transactions permanently?',
        ),
        actions: <Widget>[
          OutlinedButton(
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(15)),
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: priCol(context),
                foregroundColor: Colors.white),
            child: const Text('Delete'),
            onPressed: () {
              if (singleTransaction != null) {
                _deleteTransaction(singleTransaction);
              } else {
                _deleteSelectedTransactions(selectedTransactions);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void toggleSelection(TransactionModel transaction) {
    if (selectedTransactions.contains(transaction)) {
      selectedTransactions.remove(transaction);
    } else {
      selectedTransactions.add(transaction);
    }

    setState(() {
      isSelectionMode = selectedTransactions.isNotEmpty;
    });
  }

  void cancelSelection() {
    setState(() {
      selectedTransactions.clear();
      isSelectionMode = false;
    });
  }

  // Format the date
  String formatDate(String dbDate) {
    String correctedDate =
        dbDate.replaceFirst('-', 'T', dbDate.lastIndexOf('-'));
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
  Widget build(BuildContext context) {
    return MenuItem(
      drawerController: _drawerController,
      child: Scaffold(
        appBar: isSelectionMode
            ? AppBar(
                leading: IconButton(
                  onPressed: cancelSelection,
                  icon: const Icon(Icons.close),
                ),
                title: Text('${selectedTransactions.length} selected'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showDeleteDialog(),
                  )
                ],
              )
            : AppBarScreen(drawerController: _drawerController, title: 'Transactions'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<List<TransactionModel>>(
              future: _loadTransactionsFromPrefs(),
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
                    final isSelected = selectedTransactions.contains(transaction);
                    return Column(
                      children: [
                        Text(
                          formatDate(date),
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        ListTile(
                          onTap: () => toggleSelection(transaction),
                          onLongPress: () {
                            if (!isSelectionMode) {
                              toggleSelection(transaction);
                            }
                          },
                          leading: CircleAvatar(
                            child: isSelectionMode
                                ? Icon(
                                    isSelectionMode
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                  )
                                : Image.asset('assets/logo.png'),
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
                          trailing: isSelectionMode
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _showDeleteDialog(
                                    singleTransaction: transaction,
                                  ), // Delete transaction on click
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
      ),
    );
  }
}
