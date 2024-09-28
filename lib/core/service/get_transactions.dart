import 'dart:convert';
import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:http/http.dart' as http;


class GetTransactionResponse {
  static Future<List<TransactionModel>> getTransactions({required int userId}) async {
     final serverUrl = 'http://10.0.2.2:3000/api/v1/get-transactions/$userId';

    try {
      final response = await http.get(
        Uri.parse(serverUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData= jsonDecode(response.body);
        final List<dynamic> getTransactions = responseData['data'];

        final List<TransactionModel> getAllTransactions =
            getTransactions.map((json) =>  TransactionModel.fromJson(json)).toList();
        return getAllTransactions;
      }
      // else if(response.statusCode == 404){
      //   return [];
      // }
       else {
        throw Exception("failed to fetch members");
      }
    } on Exception catch (e) {
      throw Exception('an Error occurred: $e');
    }
  }
}
