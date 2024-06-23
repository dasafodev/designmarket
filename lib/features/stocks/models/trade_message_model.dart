import 'package:desigmarket/features/stocks/models/trade_model.dart';

class TradeMessage {
  final String type;
  final List<Trade> data;

  TradeMessage({
    required this.type,
    required this.data,
  });

  factory TradeMessage.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List?;
    List<Trade> tradeList =
        dataList?.map((i) => Trade.fromJson(i)).toList() ?? [];

    return TradeMessage(
      type: json['type'],
      data: tradeList,
    );
  }
}
