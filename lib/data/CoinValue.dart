class CoinValue {
  final String id;
  final int rank;
  final String symbol;
  final String name;
  final double? supply;
  final double? maxSupply;
  final double? marketCapUsd;
  final double? volumeUsd24Hr;
  final double? priceUsd;
  final double? changePercent24Hr;
  final double? vwap24Hr;
  final String? explorer;

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
      id: json['id'] ?? '',
      rank: json['rank'] ?? 0,
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      supply: (json['supply'] as num?)?.toDouble(),
      maxSupply: (json['maxSupply'] as num?)?.toDouble(),
      marketCapUsd: (json['marketCapUsd'] as num?)?.toDouble(),
      volumeUsd24Hr: (json['volumeUsd24Hr'] as num?)?.toDouble(),
      priceUsd: (json['priceUsd'] as num?)?.toDouble(),
      changePercent24Hr: (json['changePercent24Hr'] as num?)?.toDouble(),
      vwap24Hr: (json['vwap24Hr'] as num?)?.toDouble(),
      explorer: json['explorer'] ?? '',
    );
  }
}
