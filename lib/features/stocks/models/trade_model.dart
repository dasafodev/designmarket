import 'package:equatable/equatable.dart';

class Trade extends Equatable {
  final double price;
  final String symbol;
  final int timestamp;
  final double volume;

  const Trade({
    required this.price,
    required this.symbol,
    required this.timestamp,
    required this.volume,
  });

  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      price: json['p'].toDouble(),
      symbol: json['s'],
      timestamp: json['t'],
      volume: json['v'].toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        price,
        symbol,
        timestamp,
        volume,
      ];
}
