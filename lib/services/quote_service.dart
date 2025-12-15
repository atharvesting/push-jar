import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:push_jar/quote.dart';

const String zenAPI = 'https://zenquotes.io/api/quotes/keyword=inspirational';

Future<Quote> fetchQuote() async {
  final response = await http.get(Uri.parse(zenAPI));
  
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return Quote.fromJson(jsonResponse[0]);

  } else {
    throw Exception('Failed to load quote. Status code: ${response.statusCode}');
  }
}

