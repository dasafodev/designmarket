import 'package:desigmarket/features/stocks/cubit/stocks_cubit.dart';
import 'package:desigmarket/features/stocks/widgets/stock_tile.dart';
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
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Watchlist',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
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
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFEEF2F6),
                        ),
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AAPL',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Apple Inc.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Spacer(),
                                Text('\$150.00',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Text('+0.5%',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.green))
                              ],
                            ),
                            Column(
                              children: [
                                Image.network(
                                  'https://logo.clearbit.com/apple.com',
                                  width: 32,
                                  height: 32,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                    return AnimatedOpacity(
                                      opacity: frame == null ? 0 : 1,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFEEF2F6),
                        ),
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AAPL',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Apple Inc.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Spacer(),
                                Text('\$150.00',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Text('+0.5%',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.green))
                              ],
                            ),
                            Column(
                              children: [
                                Image.network(
                                  'https://logo.clearbit.com/apple.com',
                                  width: 32,
                                  height: 32,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                    return AnimatedOpacity(
                                      opacity: frame == null ? 0 : 1,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Trending',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...state.companies.map(
                  (company) => StockTile(company: company),
                )
              ],
            );
          },
        ),
        // floatingActionButton: Builder(
        //   builder: (context) {
        //     final cubit = context.read<StocksCubit>();
        //     return FloatingActionButton(
        //       onPressed: () {
        //         cubit.subscribe('BINANCE:BTCUSDT');
        //       },
        //       child: const Icon(Icons.add),
        //     );
        //   },
        // ),
      ),
    );
  }
}
