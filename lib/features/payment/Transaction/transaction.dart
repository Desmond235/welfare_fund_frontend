class Transaction {
  final String amount;
  final String reference;
  final String currency;
  final String email;
  final List channels;

  Transaction({
    required this.amount,
    required this.reference,
    required this.currency,
    required this.email,
    required this.channels,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      reference: json['reference'],
      currency: json['currency'],
      email: json['email'],
      channels: json['channels'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'reference': reference,
      'currency': currency,
      'email': email,
      'channels': channels,
    };
  }
}
