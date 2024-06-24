import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockDetail extends StatelessWidget {
  const StockDetail({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.5,
      minChildSize: 0.4,
      initialChildSize: 0.45,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chip(
                            side: BorderSide.none,
                            backgroundColor: Colors.grey.shade100,
                            visualDensity: VisualDensity.compact,
                            label: Text(
                              company.ticker.split(':').last,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          Text(
                            company.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$${company.latestPrice.toStringAsFixed(2)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Text(
                            '${company.percentChange.toStringAsFixed(2)}%',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 14,
                              color: (company.percentChange).isNegative
                                  ? Colors.red.shade300
                                  : Colors.green.shade300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (company.trades.isNotEmpty)
                    SizedBox(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toStringAsFixed(0),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 22,
                                getTitlesWidget: (value, meta) {
                                  DateTime date =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          value.toInt());
                                  return Text(
                                    '${date.hour}:${date.minute}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(
                            show: false,
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: company.trades
                                  .take(10)
                                  .map((trade) => FlSpot(
                                      trade.timestamp.toDouble(), trade.price))
                                  .toList(),
                              isCurved: false,
                              color: (company.percentChange).isNegative
                                  ? Colors.red.shade300
                                  : Colors.green.shade300,
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                      height: 120,
                      child: Center(
                        child: Text('Without data'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
