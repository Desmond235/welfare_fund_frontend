class TransactionModel {
  final int id;
  final int userId;
  final int amount;
  final String email;
  final String date;
  final bool isSelected;

  TransactionModel({
    this.isSelected = false,
    required this.id,
    required this.userId,
    required this.amount,
    required this.email,
    required this.date,
  });
 
 Map<String, dynamic> toJson(){
  return {
    "id": id,
    "userId": userId,
    "amount": amount,
    "email": email,
     "date": date,
  };
 }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      isSelected: false,
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      amount: json['amount'] ?? 0,
      email: json['email'] ?? "",
      date: json['date'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
   if (identical(this, other)) return true;
   return other is TransactionModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
