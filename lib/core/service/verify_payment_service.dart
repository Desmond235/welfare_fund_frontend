import 'dart:convert';
import 'package:church_clique/core/config/environ.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/payment/transaction/db/local_db.dart';
import 'package:church_clique/features/payment/transaction/models/verify_payment.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<VerifyPaymentResponse> verifyPayment(
    String reference, int userId) async {
  final response = await http.post(
      Uri.parse(
          'http://10.0.2.2:3000/api/v1/verify-payment/$reference/$userId'),
      headers: {
        'Authorization': 'Bearer ${EnvironConfig.secretKey}',
      });

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    // final jsonList = responseData.cast<String, dynamic>().values.toList();
    // final List<TransactionModel> transactions =
    //     jsonList.whereType<Map<String, dynamic >>()
    //     . map((json) => TransactionModel.fromJson(json))
    //     .toList();
    final id = responseData['id'];
    final userId = responseData['userId'];
    final amount = responseData['data']['amount'];
    final date = responseData['data']['date'];

    final prefs = await sharedPrefs;
    // prefs.setString('transactions', jsonEncode(transactions));

    // Store the id in shared preferences
    prefs.setInt('id', id);

    

    await DatabaseHelper.instance.insertTransaction({
      'id': id,
      'userId': userId,
      'amount': amount,
      'date': date,
    });
    return VerifyPaymentResponse.fromJson(responseData);
  } else {
    throw Exception('Failed to verify payment${response.statusCode}');
  }
}

Future<Database> initDatabase({Database? database}) async {
  final dbPath = await getDatabasesPath();

  if(database !=null){
    database = await openDatabase(
      join(dbPath, 'transactions.db'),
    );
  }
  return await openDatabase(
    join(dbPath, 'transactions.db'),
    onCreate: (db, version) => db.execute(
      "CREATE TABLE transactions (id INTEGER PRIMARY KEY,userId INTEGER, amount REAL, date TEXT)",
    ),
    version: 1,
  );
}
