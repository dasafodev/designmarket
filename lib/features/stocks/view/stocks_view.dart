import 'package:desigmarket/features/stocks/cubit/stocks_cubit.dart';
import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:desigmarket/features/stocks/widgets/add_to_wishlist.dart';
import 'package:desigmarket/features/stocks/widgets/add_to_wishlist_form.dart';
import 'package:desigmarket/features/stocks/widgets/stock_detail.dart';
import 'package:desigmarket/features/stocks/widgets/stock_tile.dart';
import 'package:desigmarket/features/stocks/widgets/stocks_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StocksView extends StatelessWidget {
  const StocksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StocksCubit(
        stocksRepository: context.read(),
      )..initialize(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          title: const Text('DesignMarket'),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: BlocBuilder<StocksCubit, StocksState>(
          builder: (context, state) {
            if (state.hasError) {
              return const Center(
                child: Text('An error occurred'),
              );
            }
            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Text(
                    'Watchlist',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      AddToWishlist(
                        onTap: () {
                          onAddCompany(context);
                        },
                      ),
                      ...state.watchlistCompanies.map(
                        (company) => StocksCard(
                          company: company,
                          // onTap: (company) {
                          //   onCompanyPressed(context, company);
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Trending',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...state.companies.map(
                        (company) => StockTile(
                            company: company,
                            onTap: (company) {
                              onCompanyPressed(context, company);
                            }),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onCompanyPressed(BuildContext context, Company company) {
    showModalBottomSheet(
      context: context,
      elevation: 2,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return StockDetail(
          company: company,
        );
      },
    );
  }

  void onAddCompany(BuildContext paramContext) {
    showModalBottomSheet(
      context: paramContext,
      elevation: 2,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return AddToWishlistForm(
          cubitContext: paramContext,
        );
      },
    );
  }
}
