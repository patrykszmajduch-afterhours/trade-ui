import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:trade_app_ui/data/CoinValue.dart';
import 'package:trade_app_ui/data/MarketData.dart';
import 'package:trade_app_ui/services/CoinServices.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CoinPage(),
    );
  }
}

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  late Future<List<CoinValue>> coinData;
  CoinValue? selectedCoin;
  late Future<List<MarketData>> marketData;

  @override
  void initState() {
    super.initState();
    coinData = fetchCoinValues();
    marketData = fetchMarketValues("bitcoin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Coin App'),
      ),
      body: FutureBuilder<List<CoinValue>>(
        future: coinData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CoinValue> coins = snapshot.data!;
            return Column(
              children: [
                coinListWidget(coins),
                if (selectedCoin != null)
                  Container(
                      height: 300,
                      padding: EdgeInsets.only(
                          bottom: 20), // Add 20 padding to the bottom
                      decoration: BoxDecoration(
                        border: Border.all(), // Add borders to the container
                      ),
                      child: SingleChildScrollView(
                          child: PriceTableWidget(coinName: selectedCoin!.id))),
              ],
            );
          }
        },
      ),
    );
  }

  Widget coinListWidget(List<CoinValue> coinData) {
    return Expanded(
      child: ListView.builder(
        itemCount: coinData.length,
        itemBuilder: (context, index) {
          CoinValue coin = coinData[index];
          return ListTile(
            title: Text('${coin.rank}. ${coin.name} (${coin.symbol})'),
            subtitle: Text('Price: \$${coin.priceUsd!.toStringAsFixed(2)}'),
            onTap: () {
              setState(() {
                selectedCoin = coin;
              });
            },
          );
        },
      ),
    );
  }
}

class PriceTableWidget extends StatelessWidget {
  String coinName = "";

  PriceTableWidget({super.key, required this.coinName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MarketData>>(
      future: fetchMarketValues(coinName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<MarketData> marketData = snapshot.data!;
          return DataTable(
            columns: [
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Market name')),
            ],
            rows: marketData.map((data) {
              return DataRow(
                cells: [
                  DataCell(Text(data.exchangeId)),
                  DataCell(Text(data.priceUsd)),
                ],
              );
            }).toList(),
          );
        }
      },
    );
  }
}
