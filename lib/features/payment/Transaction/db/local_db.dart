import 'dart:async';

import 'package:church_clique/features/payment/transaction/models/transaction_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper extends ChangeNotifier {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('transactions1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE transactions (id INTEGER PRIMARY KEY, amount INTEGER, date TEXT, userId INTEGER)',
    );
  }

  Future<void> fetchAndSaveTransactions(int userId,
      {required List<TransactionModel>? transactions}) async {
    // final transactions = await GetTransactionResponse.getTransactions(userId: userId);
    final db = await instance.database;

    for (var transaction in transactions!) {
      await db.insert('transactions', transaction.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<TransactionModel>> getTransactionsById(int userId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> transactions = await db.query(
      'transactions',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return List.generate(transactions.length, (index) {
      return TransactionModel.fromJson(transactions[index]);
    });
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    final db = await instance.database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [transaction.id]
    );
  }

Future<int> insertTransaction(Map<String, dynamic> transaction) async{
  final db = await instance.database;
  return await db.insert('transactions', transaction);
}
  Future<void> deleteSelectedTransactions(
    List<TransactionModel> transactions,
    List<TransactionModel> selectedTransactions,
    bool isSelectionMode,
  ) async {
    final db = await instance.database;
    for (var transaction in transactions) {
      await db.delete(
        'transactions',
        where: 'id = ?',
        whereArgs: [transaction.id],
      );
    }

    selectedTransactions.clear();
    isSelectionMode = false;
    notifyListeners();
  }
  

  Future<void> syncTransactions(int userId) async {

  }
}
