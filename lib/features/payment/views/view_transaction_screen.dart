import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/get_transactions.dart';
import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewTransactionScreen extends StatelessWidget {
  const ViewTransactionScreen({super.key});

  Future<List<TransactionModel>> _getTransaction() async {
    try {
      final prefs = await sharedPrefs;
      final id = prefs.getInt('id') ?? 0;
      return await GetTransactionResponse.getTransactions(id);
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  String formatDate(String dbDate) {
    // parse the date from database
    DateTime paymentDate = DateTime.parse(dbDate);

    // current date
    final now = DateTime.now();
    // check if paymentDate is today
    bool isToday = now.year == paymentDate.year &&
        now.month == paymentDate.month &&
        now.day == paymentDate.day;
    if (isToday) {
      return DateFormat.jm().format(paymentDate);
    } else {
      return DateFormat('MMM d').format(paymentDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
            future: _getTransaction(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                const Center(
                  child: Text(
                    'An error occurred while fetching transactions',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    'No transactions found',
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

              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final date = snapshot.data![index].date;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Image.asset('assets/logo.png'),
                      ),
                      title: const Text(
                        'Welfare Fund',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Text(formatDate(date)),
                      subtitle: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Container(
                          decoration: BoxDecoration(
                              color: priCol(context),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                              softWrap: true,
                              'Payment of ${snapshot.data![index].amount} made  '),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      )),
    );
  }
}
