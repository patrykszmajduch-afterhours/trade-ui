import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:trade_app_ui/data/CoinValue.dart';
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

  @override
  void initState() {
    super.initState();
    coinData = fetchCoinValues();
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
                if (selectedCoin != null) coinPriceChartWidget(selectedCoin!),
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

  Widget coinPriceChartWidget(CoinValue coin) {
    return Expanded(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0,
                    coin.priceUsd ?? 0), // Use 0 as x-axis value for simplicity
                // Add more spots if needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}
