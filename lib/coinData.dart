class CoinData {
  final int id;
  final String code;
  final String name;
  final double value;

  const CoinData(
      {required this.id,
      required this.code,
      required this.value,
      required this.name});

  factory CoinData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'code': String code,
        'name': String name,
        'value': double value,
      } =>
        CoinData(id: id, code: code, value: value, name: name),
      _ => throw const FormatException('Failed to load coins data.'),
    };
  }
}
