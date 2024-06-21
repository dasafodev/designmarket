part of 'stocks_cubit.dart';

class StocksState extends Equatable {
  final Map<String, dynamic> stocksData;
  final bool hasError;

  const StocksState({
    this.stocksData = const {},
    this.hasError = false,
  });

  StocksState copyWith({Map<String, dynamic>? stocksData, bool? hasError}) {
    return StocksState(
      stocksData: stocksData ?? this.stocksData,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object> get props => [stocksData, hasError];
}
