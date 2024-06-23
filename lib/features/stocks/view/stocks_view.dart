import 'package:desigmarket/features/stocks/cubit/stocks_cubit.dart';
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
            const SizedBox(width: 12),
          ],
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
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFEEF2F6),
                        ),
                        width: 160,
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                      if (state.companies.isNotEmpty)
                        StocksCard(
                          company: state.companies.last,
                        ),
                      if (state.companies.isNotEmpty)
                        StocksCard(
                          company: state.companies[0],
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
                          (company) => StockTile(company: company),
                        )
                      ],
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
