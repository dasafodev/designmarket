part of 'stocks_cubit.dart';

class StocksState extends Equatable {
  final bool hasError;
  final List<Company> companies;
  final List<Company> watchlistCompanies;

  const StocksState({
    this.hasError = false,
    this.companies = const [],
    this.watchlistCompanies = const [],
  });

  StocksState copyWith({
    List<Company>? companies,
    List<Company>? watchlistCompanies,
    TradeMessage? stocksData,
    bool? hasError,
  }) {
    return StocksState(
      hasError: hasError ?? this.hasError,
      companies: companies ?? this.companies,
      watchlistCompanies: watchlistCompanies ?? this.watchlistCompanies,
    );
  }

  @override
  List<Object?> get props => [
        hasError,
        companies,
        watchlistCompanies,
      ];
}
