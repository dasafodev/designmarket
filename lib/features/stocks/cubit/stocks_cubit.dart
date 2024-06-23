import 'dart:convert';

import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:desigmarket/features/stocks/repository/stocks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stocks_state.dart';

class StocksCubit extends Cubit<StocksState> {
  final StocksRepository stocksRepository;

  StocksCubit({required this.stocksRepository}) : super(const StocksState());

  void initialize() async {
    await fetchInitialCompanies();
    Future.delayed(const Duration(seconds: 1), fetchInitialQuotes);
    stocksRepository.broadcastStream.listen(
      (message) {
        _handleWebSocketMessage(message);
      },
      onError: (error) {
        emit(state.copyWith(hasError: true));
      },
      onDone: () {},
    );
  }

  Future<void> fetchInitialCompanies() async {
    try {
      final companies = await Future.wait(
        StocksRepository.stocks
            .map((symbol) => stocksRepository.getStockProfile(symbol)),
      );
      emit(state.copyWith(companies: companies));
    } catch (e) {
      throw Exception('Error fetching all companies: $e');
    }
  }

  Future<void> fetchInitialQuotes() async {
    try {
      final quotes = await Future.wait(
        StocksRepository.stocks
            .map((symbol) => stocksRepository.getStockQuote(symbol)),
      );
      final updatedCompanies = state.companies.map((company) {
        final quote =
            quotes.firstWhere((quote) => quote.ticker == company.ticker);
        return company.copyWith(quote: quote);
      }).toList();
      emit(state.copyWith(companies: updatedCompanies));
    } catch (e) {
      throw Exception('Error fetching all quotes: $e');
    }
  }

  Future<void> fetchCompany(String symbol) async {
    try {
      final profile = await stocksRepository.getStockProfile(symbol);
      emit(state.copyWith(companies: [...state.companies, profile]));
    } catch (e) {
      throw Exception('Error fetching stock profile: $e');
    }
  }

  Future<void> fetchQuote(String symbol) async {
    try {
      final quote = await stocksRepository.getStockQuote(symbol);
      final updatedCompanies = state.companies.map((company) {
        if (company.ticker == symbol) {
          return company.copyWith(quote: quote);
        }
        return company;
      }).toList();
      emit(state.copyWith(companies: updatedCompanies));
    } catch (e) {
      throw Exception('Error fetching stock quote: $e');
    }
  }

  void _handleWebSocketMessage(dynamic message) {
    final parsedMessage = _parseMessage(message);
    final updatedStocksData = Map<String, dynamic>.from(state.stocksData)
      ..addAll(parsedMessage);
    emit(state.copyWith(stocksData: updatedStocksData));
  }

  Map<String, dynamic> _parseMessage(dynamic message) {
    return jsonDecode(message);
  }

  void subscribe(String symbol) {
    stocksRepository.subscribe(symbol);
  }

  void unsubscribe(String symbol) {
    stocksRepository.unsubscribe(symbol);
  }

  @override
  Future<void> close() {
    stocksRepository.dispose();
    return super.close();
  }
}
