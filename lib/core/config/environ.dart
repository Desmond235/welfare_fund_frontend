import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironConfig{
  static final url = dotenv.env['URL'];
  static final paystackEndpoint = dotenv.env['PAYSTACK_ENDPOINT'];
  static final publicKey = dotenv.env['PUBLIC_KEY'];
  static final secretKey = dotenv.env['SECRET_KEY'];
}