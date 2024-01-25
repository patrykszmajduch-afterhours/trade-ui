import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trade_app_ui/coinData.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<CoinData>> fetchCoins() async {
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

class PlotData {
  final double value; //todo;change this to money variable
  final String name;
  final String id;
  const PlotData({required this.id, required this.name, required this.value});

  factory PlotData.fromJson(Map<String, dynamic> json) {
    //TODO: replace that
    return switch (json) {
      {
        'value': double value,
        'id': String id,
        'name': String name,
      } =>
        PlotData(
          value: value,
          id: id,
          name: name,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<CoinData>> futureCoins;
  @override
  void initState() {
    super.initState();
    this.futureCoins = fetchCoins();
  }

  void onPressed() {
    this.futureCoins = fetchCoins();
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
                  final posts = snapshot.data!;
                  return buildCoins(posts);
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
