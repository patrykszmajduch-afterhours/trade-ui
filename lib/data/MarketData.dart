class MarketData {
  String exchangeId;
  String baseId;
  String quoteId;
  String baseSymbol;
  String quoteSymbol;
  String volumeUsd24Hr;
  String priceUsd;
  String volumePercent;

  MarketData({
    required this.exchangeId,
    required this.baseId,
    required this.quoteId,
    required this.baseSymbol,
    required this.quoteSymbol,
    required this.volumeUsd24Hr,
    required this.priceUsd,
    required this.volumePercent,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      exchangeId: json['exchangeId'] ?? '',
      baseId: json['baseId'] ?? '',
      quoteId: json['quoteId'] ?? '',
      baseSymbol: json['baseSymbol'] ?? '',
      quoteSymbol: json['quoteSymbol'] ?? '',
      volumeUsd24Hr: json['volumeUsd24Hr'] ?? '',
      priceUsd: json['priceUsd'] ?? '',
      volumePercent: json['volumePercent'] ?? '',
    );
  }
}
