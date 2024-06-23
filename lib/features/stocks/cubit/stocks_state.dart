part of 'stocks_cubit.dart';

class StocksState extends Equatable {
  final Map<String, dynamic> stocksData;
  final bool hasError;
  final List<Company> companies;

  const StocksState({
    this.stocksData = const {},
    this.hasError = false,
    this.companies = const [],
  });

  StocksState copyWith({
    List<Company>? companies,
    Map<String, dynamic>? stocksData,
    bool? hasError,
  }) {
    return StocksState(
      stocksData: stocksData ?? this.stocksData,
      hasError: hasError ?? this.hasError,
      companies: companies ?? this.companies,
    );
  }

  @override
  List<Object> get props => [
        stocksData,
        hasError,
        companies,
      ];
}
