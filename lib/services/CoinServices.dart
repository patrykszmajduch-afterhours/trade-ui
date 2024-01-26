import 'dart:async';
import 'dart:convert';

import 'package:trade_app_ui/data/CoinData.dart';
import 'package:http/http.dart' as http;
import 'package:trade_app_ui/data/CoinValue.dart';
import 'package:trade_app_ui/data/MarketData.dart';

Future<List<CoinData>> getCoins() async {
  final response =
      await http.get(Uri.parse('http://localhost:5005/trace/getCoins'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    jsonDecode(response.body);
    // return CoinData.fromJson( as CoinData[]);
    final List body = json.decode(response.body);
    return body
        .map((e) => CoinData.fromJson(e as Map<String, dynamic>))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load coins list');
  }
}

Future<List<CoinValue>> fetchCoinValues() async {
  final response =
      await http.get(Uri.parse('http://localhost:5005/trace/fetch'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    jsonDecode(response.body);
    final List body = json.decode(response.body);
    return body
        .map((e) => CoinValue.fromJson(e as Map<String, dynamic>))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load coins list');
  }
}

Future<List<MarketData>> fetchMarketValues(String? coin) async {
  final response =
      await http.get(Uri.parse('http://localhost:5005/trace/market/$coin'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    jsonDecode(response.body);
    final List body = json.decode(response.body);
    return body
        .map((e) => MarketData.fromJson(e as Map<String, dynamic>))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load market list');
  }
}
