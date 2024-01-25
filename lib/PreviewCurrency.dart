import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trade_app_ui/coinData.dart';

import 'album.dart';

Future<CoinData> fetchCurrency() async {
  final response = await http
      .get(Uri.parse('https://localhost:5005/trace/getCoins'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CoinData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class PreviewCurrency extends StatefulWidget {
  const PreviewCurrency({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _MyAppState extends State<MyApp>
