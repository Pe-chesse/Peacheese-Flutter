import 'package:firebase_auth/firebase_auth.dart';
import 'package:peach_market/services/api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

final ws = WebSocketManager();

class WebSocketManager {
  late WebSocketChannel _channel;

  void connect() {
    final url = 'ws://${API.BASE_ADDRESS}:8001/ws/v1/chat/${FirebaseAuth.instance.currentUser?.uid}/';
    _channel = IOWebSocketChannel.connect(url);
  }

  void listen(void Function(dynamic) onData) {
    _channel.stream.listen(onData);
  }

  void sendMessage(String message) {
    // ignore: unnecessary_null_comparison
    if (_channel != null && _channel.sink != null) {
      _channel.sink.add(message);
    }
  }

  void disconnect() {
    _channel.sink.close();
  }
}