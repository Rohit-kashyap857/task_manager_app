import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  Future<Map<String, dynamic>>
  getQuote() async {

    final response = await http.get(
      Uri.parse(
        'https://api.quotable.io/random',
      ),
    );

    return jsonDecode(response.body);
  }

}