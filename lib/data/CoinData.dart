class CoinData {
  final int id;
  final String code;
  final String name;
  final int value;

  const CoinData(
      {required this.id,
      required this.code,
      required this.name,
      required this.value});

  factory CoinData.fromJson(Map<String, dynamic> json) {
    return CoinData(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        value: json['value']);
  }
}
