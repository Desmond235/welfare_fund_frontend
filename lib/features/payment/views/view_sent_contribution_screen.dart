import 'package:church_clique/core/components/menu_item.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/get_transactions.dart';
import 'package:church_clique/core/service/verify_payment_service.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:church_clique/features/payment/transaction/db/local_db.dart';
import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class ViewSentContributionScreen extends StatefulWidget {
  const ViewSentContributionScreen({super.key});

  @override
  State<ViewSentContributionScreen> createState() =>
      _ViewSentContributionScreenState();
}

class _ViewSentContributionScreenState
    extends State<ViewSentContributionScreen> {
  int? userId;
  List<TransactionModel> selectedTransactions = [];
  bool isSelectionMode = false;
  final AdvancedDrawerController _drawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    userId = context.read<MemFormState>().userId;
  }

  Future<List<TransactionModel>>_loadTransactions(int userId) async {
   return await DatabaseHelper.instance.getTransactionsById(userId);
  }

  Future<void> _deleteTransaction(TransactionModel transaction) async {
    await DatabaseHelper.instance.deleteTransaction(transaction);
  }

  Future<void> _deleteSelectedTransactions(
      List<TransactionModel> transactionsToDelete) async {
    await DatabaseHelper.instance.deleteSelectedTransactions(
      transactionsToDelete,
      selectedTransactions,
      isSelectionMode,
    );
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
                    onPressed: _showDeleteDialog,
                    icon: const Icon(Icons.delete),
                  )
                ],
              )
            : AppBarScreen(
                drawerController: _drawerController, title: 'Transactions'),
        body: Center(
          child: Padding(
            padding: isSelectionMode
                ? const EdgeInsets.fromLTRB(0, 10, 0, 0)
                : const EdgeInsets.all(10),
            child: FutureBuilder(
              future: _loadTransactions(userId!),
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
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final transaction = snapshot.data![index];
                    final date = transaction.date;
                    final isSelected =
                        selectedTransactions.contains(transaction);
                    return Column(
                      children: [
                        Text(
                          formatDate(date),
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        Container(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1)
                              : Colors.transparent,
                          child: ListTile(
                            onTap: () => toggleSelection(transaction),
                            onLongPress: () {
                              if (!isSelectionMode) {
                                toggleSelection(transaction);
                              }
                            },
                            leading: CircleAvatar(
                              child: isSelectionMode
                                  ? Icon(
                                      isSelected
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
