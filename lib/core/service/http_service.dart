import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Http {
  static post(Map<String, dynamic> data)  async{
     await http.post(
      Uri.parse(dotenv.env["URL"]!),
      headers: {'Content-Type': 'application/json'},
      body:jsonEncode(data),
    );
  }
}
