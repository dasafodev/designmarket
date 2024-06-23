import 'dart:convert';
import 'dart:developer';

import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:desigmarket/features/stocks/models/quote_model.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class StocksRepository {
  late WebSocketChannel channel;
  late Dio dio;
  late Stream broadcastStream;
  final String token;

  final btcCompany = Company(
    name: 'Bitcoin',
    ticker: 'BINANCE:BTCUSDT',
    logo: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png',
    country: 'US',
    currency: 'USD',
    exchange: 'Binance',
    ipo: DateTime(2009, 1, 3),
    marketCapitalization: 1.0,
    phone: '1-800-555-5555',
    weburl: 'https://bitcoin.org/',
    finnhubIndustry: 'Cryptocurrency',
    estimateCurrency: 'USD',
    shareOutstanding: 1.0,
  );

  final ethCompany = Company(
    name: 'Ethereum',
    ticker: 'BINANCE:ETHUSDT',
    logo: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
    country: 'US',
    currency: 'USD',
    exchange: 'Binance',
    ipo: DateTime(2009, 1, 3),
    marketCapitalization: 1.0,
    phone: '1-800-555-5555',
    weburl: 'https://bitcoin.org/',
    finnhubIndustry: 'Cryptocurrency',
    estimateCurrency: 'USD',
    shareOutstanding: 1.0,
  );

  static const stocks = [
    'AAPL',
    'GOOGL',
    'AMZN',
    'TSLA',
    'BINANCE:BTCUSDT',
    'BINANCE:ETHUSDT',
  ];

  StocksRepository({required this.token}) {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=$token'),
    );
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://finnhub.io/api/v1',
        queryParameters: {'token': token},
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    broadcastStream = channel.stream.asBroadcastStream();
    _subscribeToStocks();
  }

  Future<Company> getStockProfile(String symbol) async {
    if (symbol == 'BINANCE:BTCUSDT') return btcCompany;
    if (symbol == 'BINANCE:ETHUSDT') return ethCompany;
    try {
      final response =
          await dio.get('/stock/profile2', queryParameters: {'symbol': symbol});
      return Company.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      log('Error fetching stock profile: $e');
      rethrow;
    }
  }

  Future<Quote> getStockQuote(String symbol) async {
    try {
      final response =
          await dio.get('/quote', queryParameters: {'symbol': symbol});
      return Quote.fromJson(response.data, ticker: symbol);
    } catch (e) {
      log('Error fetching stock quote: $e');
      rethrow;
    }
  }

  void subscribe(String symbol) {
    final subscribeMessage = {
      'type': 'subscribe',
      'symbol': symbol,
    };

    channel.sink.add(jsonEncode(subscribeMessage));
  }

  void unsubscribe(String symbol) {
    final unsubscribeMessage = {
      'type': 'unsubscribe',
      'symbol': symbol,
    };

    channel.sink.add(jsonEncode(unsubscribeMessage));
  }

  void _subscribeToStocks() {
    for (final stock in stocks) {
      subscribe(stock);
    }
  }

  void dispose() {
    channel.sink.close(status.goingAway);
  }
}
