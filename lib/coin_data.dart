import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'BA975C1D-53E7-4419-AD45-6C740FDB7E27';
const coinURL = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<List<double>> getCoinData({required String quoteCurrency}) async {
    List<double> cryptoValues = [];
    for (var crypto in cryptoList) {
      http.Response response = await http
          .get(Uri.parse('$coinURL/$crypto/$quoteCurrency?apikey=$apiKey'));
      cryptoValues.add(jsonDecode(response.body)['rate']);
    }
    return cryptoValues;
  }
}
