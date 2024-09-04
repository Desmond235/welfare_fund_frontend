class PaymentModel {
  final String reference;
  final String authorizationUrl;

  PaymentModel({
    required this.reference,
    required this.authorizationUrl,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      reference: json['reference'],
      authorizationUrl: json['authorization_url'],
    );
  }
}
