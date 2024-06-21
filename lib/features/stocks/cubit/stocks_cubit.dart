import 'package:desigmarket/features/stocks/repository/stocks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stocks_state.dart';

class StocksCubit extends Cubit<StocksState> {
  final StocksRepository stocksRepository;

  StocksCubit({required this.stocksRepository}) : super(const StocksState()) {
    _initialize();
  }

  void _initialize() {
    stocksRepository.channel.stream.listen(
      (message) {
        _handleWebSocketMessage(message);
      },
      onError: (error) {
        emit(state.copyWith(hasError: true));
      },
      onDone: () {},
    );
  }

  void _handleWebSocketMessage(dynamic message) {
    final parsedMessage = _parseMessage(message);
    final updatedStocksData = Map<String, dynamic>.from(state.stocksData)
      ..addAll(parsedMessage);
    emit(state.copyWith(stocksData: updatedStocksData));
  }

  Map<String, dynamic> _parseMessage(dynamic message) {
    return message;
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
