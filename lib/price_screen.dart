import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String quoteCurrency = 'USD';
  Map<String, double> cryptoValues = {};

  Future<void> getCryptoValue() async {
    cryptoValues = await CoinData().getCoinData(quoteCurrency: quoteCurrency);
    setState(() {});
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (var currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: quoteCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          quoteCurrency = value!;
          getCryptoValue();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];
    for (var currency in currenciesList) {
      pickerItems.add(Text(
        currency,
        style: const TextStyle(color: Colors.white),
      ));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (value) {
        quoteCurrency = currenciesList[value];
        getCryptoValue();
      },
      children: pickerItems,
    );
  }

  List<Padding> buildCoinCards() {
    List<Padding> coinCards = [];
    for (var crypto in cryptoList) {
      var coinCard = Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = ${cryptoValues[crypto]?.toInt() ?? '?'} $quoteCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      coinCards.add(coinCard);
    }
    return coinCards;
  }

  @override
  void initState() {
    super.initState();
    getCryptoValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildCoinCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
