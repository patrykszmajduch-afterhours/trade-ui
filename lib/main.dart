import 'package:flutter/material.dart';
import 'package:trade_app_ui/data/CoinData.dart';
import 'package:trade_app_ui/data/CoinValue.dart';
import 'package:trade_app_ui/services/CoinServices.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<CoinData>> futureCoins;
  late Future<List<CoinValue>> coinValues;

  @override
  void initState() {
    super.initState();
    this.futureCoins = getCoins();
    this.coinValues = fetchCoinValues();
  }

  void onPressed() {
    this.futureCoins = getCoins();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
            child: Expanded(
          child: SizedBox(
            child: FutureBuilder<List<CoinData>>(
              future: futureCoins,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final coin = snapshot.data!;
                  return buildCoins(coin);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          // FilledButton(onPressed: onPressed, child: const Text('Filled')),
          // Text('Deliver features faster'),
          // Text('Craft beautiful UIs'),
          // BarChartSample2()
        )),
      ),
    );
  }
}

Widget buildCoins(List<CoinData> coins) {
  return ListView.builder(
    itemCount: coins.length,
    itemBuilder: (context, index) {
      final coin = coins[index];
      return Container(
        color: Colors.grey.shade300,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            // Expanded(flex: 1, child: Image.network(post.url!)),
            SizedBox(width: 10),
            Expanded(flex: 3, child: Text(coin.code!)),
          ],
        ),
      );
    },
  );
}
