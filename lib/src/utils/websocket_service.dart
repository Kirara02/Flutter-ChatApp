import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  StreamController<dynamic>? _messageController;
  Completer<void>? _connectionCompleter;
  bool _isConnecting = false;

  Stream<dynamic> get messages {
    if (_messageController == null || _messageController!.isClosed) {
      return const Stream.empty();
    }
    return _messageController!.stream;
  }

  void connect(String url) {
    if (_isConnecting || _channel != null && _channel?.closeCode == null) {
      return;
    }

    _isConnecting = true;

    _messageController = StreamController.broadcast();
    _connectionCompleter = Completer<void>();
    _channel = WebSocketChannel.connect(Uri.parse(url));

    _channel!.ready
        .then((_) {
          if (!(_connectionCompleter?.isCompleted ?? true)) {
            _isConnecting = false;
            _connectionCompleter?.complete();
          }
        })
        .catchError((_) {
          _isConnecting = false;
        });

    _channel!.stream.listen(
      (message) {
        if (!(_messageController?.isClosed ?? true)) {
          _messageController?.add(message);
        }
      },
      onDone: () {
        if (!(_messageController?.isClosed ?? true)) {
          _messageController?.add(
            json.encode({"type": "info", "content": "Koneksi terputus."}),
          );
        }
      },
      onError: (error) {
        if (!(_messageController?.isClosed ?? true)) {
          _messageController?.add(
            json.encode({
              "type": "error",
              "message": "Terjadi kesalahan koneksi.",
            }),
          );
        }
      },
    );
  }

  Future<void> send(String message) async {
    await _connectionCompleter?.future;
    _channel?.sink.add(message);
  }

  void disconnect() {
    log("Websocket: disconnected");
    if (!(_messageController?.isClosed ?? true)) {
      _messageController?.close();
    }
    _channel?.sink.close();
    _channel = null;
  }
}
