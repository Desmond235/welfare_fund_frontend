class Transaction {
  String email;
  String amount;
  String reference;
  String currency;

  Transaction({
    required this.email,
    required this.reference,
    required this.amount,
    required this.currency,
  });

  factory Transaction.froJson(Map<String, dynamic> json){
    return Transaction(
      email: json['email'],
      amount: json['amount'],
      currency: json['currency'],
      reference: json['reference']
    );
  }
}
