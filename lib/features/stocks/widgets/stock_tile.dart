import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:flutter/material.dart';

class StockTile extends StatefulWidget {
  const StockTile({
    required this.company,
    super.key,
    this.onTap,
  });

  final Company company;
  final void Function(Company)? onTap;

  @override
  _StockTileState createState() => _StockTileState();
}

class _StockTileState extends State<StockTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ListTile(
            onTap: () => widget.onTap?.call(widget.company),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              side: BorderSide(color: Colors.grey, width: 0.2),
            ),
            leading: Image.network(
              widget.company.logo,
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
            title: Text(
              widget.company.ticker.split(':').last,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(widget.company.name),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${widget.company.latestPrice}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.company.percentChange.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 14,
                    color: (widget.company.percentChange).isNegative
                        ? Colors.red.shade300
                        : Colors.green.shade300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
