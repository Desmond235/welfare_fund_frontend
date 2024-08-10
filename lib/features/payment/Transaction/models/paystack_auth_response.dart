class PayStackAuthResponse {
  final String authorizationUrl;
  final String reference;
  // final String accessCode;

  PayStackAuthResponse({
    required this.authorizationUrl,
    required this.reference,
    // required this.accessCode,
  });

  factory PayStackAuthResponse.fromJson(Map<String, dynamic> json){
    return PayStackAuthResponse(
      authorizationUrl: json['authorization_url'],
      reference: json['reference'],
      // accessCode: json['access_code'],
    );
  }
}
