import 'package:http/http.dart' as http;

class Quote {
  final String quote;
  final String author;

  Quote({required this.quote, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['q'] as String,
      author: json['a'] as String,
    );
  }

  Map<String, String> toMap() {
    return {
      "quote": quote,
      "author": author,
    };
  }
}