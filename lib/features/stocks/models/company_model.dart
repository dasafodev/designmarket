import 'package:desigmarket/features/stocks/models/quote_model.dart';
import 'package:desigmarket/features/stocks/models/trade_model.dart';
import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String country;
  final String currency;
  final String estimateCurrency;
  final String exchange;
  final String finnhubIndustry;
  final DateTime ipo;
  final String logo;
  final double marketCapitalization;
  final String name;
  final String phone;
  final double shareOutstanding;
  final String ticker;
  final String weburl;
  final Quote? quote;
  final List<Trade> trades;

  const Company({
    required this.country,
    required this.currency,
    required this.estimateCurrency,
    required this.exchange,
    required this.finnhubIndustry,
    required this.ipo,
    required this.logo,
    required this.marketCapitalization,
    required this.name,
    required this.phone,
    required this.shareOutstanding,
    required this.ticker,
    required this.weburl,
    this.trades = const [],
    this.quote,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        country: json["country"],
        currency: json["currency"],
        estimateCurrency: json["estimateCurrency"],
        exchange: json["exchange"],
        finnhubIndustry: json["finnhubIndustry"],
        ipo: DateTime.parse(json["ipo"]),
        logo: json["logo"],
        marketCapitalization: json["marketCapitalization"]?.toDouble(),
        name: json["name"],
        phone: json["phone"],
        shareOutstanding: json["shareOutstanding"]?.toDouble(),
        ticker: json["ticker"],
        weburl: json["weburl"],
      );

  Company copyWith({
    String? country,
    String? currency,
    String? estimateCurrency,
    String? exchange,
    String? finnhubIndustry,
    DateTime? ipo,
    String? logo,
    double? marketCapitalization,
    String? name,
    String? phone,
    double? shareOutstanding,
    String? ticker,
    String? weburl,
    Quote? quote,
    List<Trade>? trades,
  }) {
    return Company(
      country: country ?? this.country,
      currency: currency ?? this.currency,
      estimateCurrency: estimateCurrency ?? this.estimateCurrency,
      exchange: exchange ?? this.exchange,
      finnhubIndustry: finnhubIndustry ?? this.finnhubIndustry,
      ipo: ipo ?? this.ipo,
      logo: logo ?? this.logo,
      marketCapitalization: marketCapitalization ?? this.marketCapitalization,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shareOutstanding: shareOutstanding ?? this.shareOutstanding,
      ticker: ticker ?? this.ticker,
      weburl: weburl ?? this.weburl,
      quote: quote ?? this.quote,
      trades: trades ?? this.trades,
    );
  }

  double get latestPrice =>
      trades.isEmpty ? quote?.currentPrice ?? 0 : trades.last.price;

  double get percentChange {
    final previousClosePrice = quote?.previousClosePrice ?? 0.0;
    if (previousClosePrice == 0 || latestPrice == 0) {
      return 0.0;
    }
    final result =
        ((latestPrice - previousClosePrice) / previousClosePrice) * 100;
    return result;
  }

  @override
  List<Object?> get props => [
        country,
        currency,
        estimateCurrency,
        exchange,
        finnhubIndustry,
        ipo,
        logo,
        marketCapitalization,
        name,
        phone,
        shareOutstanding,
        ticker,
        weburl,
        quote,
        trades,
      ];
}
