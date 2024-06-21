import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class StocksRepository {
  late WebSocketChannel channel;
  final String token;

  StocksRepository({required this.token}) {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=$token'),
    );

    channel.stream.listen(
      (message) {
        print('Message from server: $message');
      },
      onError: (error) {
        print('WebSocket Error: $error');
      },
      onDone: () {
        print('WebSocket closed');
      },
    );
  }

  void subscribe(String symbol) {
    final subscribeMessage = {
      'type': 'subscribe',
      'symbol': symbol,
    };
    channel.sink.add(subscribeMessage);
  }

  void unsubscribe(String symbol) {
    final unsubscribeMessage = {
      'type': 'unsubscribe',
      'symbol': symbol,
    };
    channel.sink.add(unsubscribeMessage);
  }

  void dispose() {
    channel.sink.close(status.goingAway);
  }
}
