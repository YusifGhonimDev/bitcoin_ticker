import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'CAB794CC-44B5-4B5E-A8E6-4E11FD4BE0A4';
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
  Future<Map<String, double>> getCoinData(
      {required String quoteCurrency}) async {
    Map<String, double> cryptoValues = {};
    for (var crypto in cryptoList) {
      http.Response response = await http
          .get(Uri.parse('$coinURL/$crypto/$quoteCurrency?apikey=$apiKey'));
      if (response.statusCode == 200) {
        cryptoValues[crypto] = jsonDecode(response.body)['rate'];
      } else {
        print(response.statusCode);
      }
    }
    return cryptoValues;
  }
}
