import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/get_transactions.dart';
import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewTransactionScreen extends StatefulWidget {
  const ViewTransactionScreen({super.key});

  @override
  State<ViewTransactionScreen> createState() => _ViewTransactionScreenState();
}

class _ViewTransactionScreenState extends State<ViewTransactionScreen> {
  Future<List<TransactionModel>> _getTransaction() async {
    try {
      // final prefs = await sharedPrefs;
      // final id = prefs.getInt('id') ?? 0;
      return await GetTransactionResponse.getTransactions();
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }

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
    }else if(isYesterday){
      return 'Yesterday • ${DateFormat.jm().format(paymentDate)}';
    } else if(paymentDate.year == now.year) {
      return DateFormat('EEE, MMM d • h:mm a ').format(paymentDate);
    }else{
      return DateFormat('EEE, MMM d, yyyy • h:mm a').format(paymentDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<TransactionModel>>(
            future: _getTransaction(),
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
                return const Center(
                  child: Text(
                    'No transactions found',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
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
                        // title: Text(
                        //   'Welfare Fund',
                        //   style: TextStyle(color: Colors.grey[700]),
                        // ),
                        subtitle: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: priCol(context),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Payment of GH₵ ${snapshot.data![index].amount} for Welfare dues made to admin   ',
                              softWrap: true, // softWrap belongs here
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,) 
                    ],
                  );
                },
              );
            }),
      )),
    );
  }
}
