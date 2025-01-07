import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future getMedicines() async {
    final response = await http.get(Uri.parse(
        'https://api.fda.gov/drug/label.json?search=openfda.generic_name:[* TO *]&limit=100'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      // If the server does not return a 200 OK response, throw an error
      throw Exception('Failed to load data');
    }
  }
}
