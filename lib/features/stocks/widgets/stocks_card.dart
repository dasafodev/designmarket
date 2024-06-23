import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StocksCard extends StatelessWidget {
  const StocksCard({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company.ticker.split(':').last,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                company.name,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Spacer(),
              Text('\$${company.latestPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              Text(
                '${company.percentChange.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 14,
                  color: (company.percentChange).isNegative
                      ? Colors.red.shade300
                      : Colors.green.shade300,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                company.logo,
                width: 32,
                height: 32,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: child,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
              SizedBox(
                height: 32,
                width: 32,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: company.trades
                            .map((trade) =>
                                FlSpot(trade.timestamp.toDouble(), trade.price))
                            .toList(),
                        isCurved: true,
                        color: (company.percentChange).isNegative
                            ? Colors.red.shade300
                            : Colors.green.shade300,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
