import 'dart:convert';
import 'package:http/http.dart' as http;

class ConversionService {
  // Fallback mock rates in case of network error
  final Map<String, double> _detailsFallbackRates = {
    'NGN_GBP': 0.0005,
    'NGN_EUR': 0.0006,
    'GBP_NGN': 2000.0,
    'GBP_EUR': 1.15,
    'EUR_NGN': 1666.6,
    'EUR_GBP': 0.87,
    'NGN_NGN': 1.0,
    'GBP_GBP': 1.0,
    'EUR_EUR': 1.0,
  };

  Future<double> getRate(String from, String to) async {
    if (from == to) return 1.0;

    try {
      final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/$from');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['rates'] != null && data['rates'][to] != null) {
          // Add a small delay for UX if it's too fast? No, real speed is good.
          return (data['rates'][to] as num).toDouble();
        }
      }
    } catch (e) {
      print('Conversion API Error: $e');
    }

    // Fallback logic
    final key = '${from}_$to';
    return _detailsFallbackRates[key] ?? 0.0;
  }

  double calculateAmount(double amount, double rate) {
    return amount * rate;
  }

  List<String> getSupportedCurrencies() {
    return ['NGN', 'GBP', 'EUR'];
  }
}
