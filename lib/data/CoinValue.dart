class CoinValue {
  final String id;
  final int rank;
  final String symbol;
  final String name;
  final double supply;
  final double maxSupply;
  final double marketCapUsd;
  final double volumeUsd24Hr;
  final double priceUsd;
  final double changePercent24Hr;
  final double vwap24Hr;
  final String explorer;

  CoinValue(
      {required this.id,
      required this.rank,
      required this.symbol,
      required this.name,
      required this.supply,
      required this.maxSupply,
      required this.marketCapUsd,
      required this.volumeUsd24Hr,
      required this.priceUsd,
      required this.changePercent24Hr,
      required this.vwap24Hr,
      required this.explorer});

  factory CoinValue.fromJson(Map<String, dynamic> json) {
    return CoinValue(
        id: json['id'],
        rank: json['rank'],
        symbol: json['symbol'],
        name: json['name'],
        supply: json['supply'],
        maxSupply: json['maxSupply'],
        marketCapUsd: json['marketCapUsd'],
        volumeUsd24Hr: json['volumeUsd24Hr'],
        priceUsd: json['priceUsd'],
        changePercent24Hr: json['changePercent24Hr'],
        vwap24Hr: json['vwap24Hr'],
        explorer: json['explorer']);
  }
}
