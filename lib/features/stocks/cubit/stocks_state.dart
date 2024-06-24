part of 'stocks_cubit.dart';

class StocksState extends Equatable {
  final bool hasError;
  final List<Company> companies;
  final List<Company> watchlistCompanies;
  final List<Alert> alerts;

  const StocksState({
    this.hasError = false,
    this.companies = const [],
    this.watchlistCompanies = const [],
    this.alerts = const [],
  });

  StocksState copyWith({
    List<Company>? companies,
    List<Company>? watchlistCompanies,
    TradeMessage? stocksData,
    List<Alert>? alerts,
    bool? hasError,
  }) {
    return StocksState(
      hasError: hasError ?? this.hasError,
      companies: companies ?? this.companies,
      watchlistCompanies: watchlistCompanies ?? this.watchlistCompanies,
      alerts: alerts ?? this.alerts,
    );
  }

  @override
  List<Object?> get props => [
        hasError,
        companies,
        watchlistCompanies,
        alerts,
      ];
}
