import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:flutter/material.dart';

class StockTile extends StatelessWidget {
  const StockTile({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(color: Colors.grey, width: 0.2)),
        leading: Image.network(
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
                ));
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),
        title: Text(
          company.ticker,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(company.name),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${company.quote?.currentPrice}' ?? 'N/A',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${company.quote?.percentChange.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 14,
                color: (company.quote?.percentChange ?? 0.0).isNegative
                    ? Colors.red.shade300
                    : Colors.green.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
