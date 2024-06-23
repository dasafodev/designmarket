class Quote {
  final double currentPrice;
  final double highPrice;
  final double lowPrice;
  final double openPrice;
  final double previousClosePrice;
  final int timestamp;
  final String ticker;

  Quote({
    required this.currentPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.openPrice,
    required this.previousClosePrice,
    required this.timestamp,
    required this.ticker,
  });

  factory Quote.fromJson(
    Map<String, dynamic> json, {
    required String ticker,
  }) {
    return Quote(
      ticker: ticker,
      currentPrice: json['c'].toDouble(),
      highPrice: json['h'].toDouble(),
      lowPrice: json['l'].toDouble(),
      openPrice: json['o'].toDouble(),
      previousClosePrice: json['pc'].toDouble(),
      timestamp: json['t'].toInt(),
    );
  }

  double get percentChange {
    if (previousClosePrice == 0) {
      return 0.0;
    }
    final result =
        ((currentPrice - previousClosePrice) / previousClosePrice) * 100;
    return result;
  }
}
