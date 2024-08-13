class VerifyPaymentResponse {
  final String status;
  final dynamic data;

  VerifyPaymentResponse({required this.status, required this.data});

  factory VerifyPaymentResponse.fromJson(Map<String, dynamic> json) {
    return VerifyPaymentResponse(
      status: json['status'] ?? '',
      data: json['data'] ?? {},
    );
  }
}
